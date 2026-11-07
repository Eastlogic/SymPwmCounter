library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


-- Счетчик формирования симметричной ШИМ
-- Формирует внутренний сигнал dir - направление счета (он же флаг OverFlow/UnderFlow)
-- Формирует сигналы-стробы strobe_topб strobe_bot - признаки максимума/минимума текущего значения
-- Предусмотрен внешний шинный интерфейс

entity SymPwmCounter is
generic(
CntWidth:integer:=16;					-- Разрядность счетчика по умолчанию
CntTop:integer:=65535;					-- Вершина счета после сброса(по умолчанию)
ChNumber:integer:=16						-- Число каналов сравнения
);
port(
res,clk: 		in std_logic;
q_out:			out std_logic_vector(CntWidth-1 downto 0);	-- Выход счетчика
strobe_top:		out std_logic;  										-- Импульс на вершине счета
strobe_bot:		out std_logic;   										-- Импульс внизу счета (в нуле)

-- Комплементарные выходы ШИМ для верхних и нижних ключей полумостов
pwm_out_h:      out std_logic_vector(ChNumber-1 downto 0);
pwm_out_l:      out std_logic_vector(ChNumber-1 downto 0);

-- Процессорный интерфейс таймера (8-битная шина адреса, 32-битная шина данных)
addr:				in std_logic_vector(7 downto 0);					-- Адрес регистра (до 0xFF)
wr_data:			in std_logic_vector(31 downto 0);				-- Фиксированная 32-битная шина данных на запись
rd_data:      	out std_logic_vector(31 downto 0);				-- Порт чтения данных
wr_en:			in std_logic											-- Строб записи от процессора
);
end entity;


architecture SymPwmCounter_arch of SymPwmCounter is

signal 	dir: std_logic:='0';											-- Признак направления счета "вверх/вниз"
																				-- dir='0' - счет вверх (OverFlow), dir='1' - счет вниз (UnderFlow)
signal	s_cnt: std_logic_vector(CntWidth-1 downto 0):= (others => '0');


constant	CTRL1_WR_MASK:		std_logic_vector(31 downto 0):=x"00000001";				-- Битовая маска записи только используемых бит
signal 	s_ctrl1_reg: 		std_logic_vector(31 downto 0) := (others => '0');		-- Регистр конфигурации и управления CNT_CTRL1
																											-- Объявлен, как полноценный 32-битный вектор
																											-- [31:1] - RESERVED, [0] - EN (Enable)

-- Регистры для динамического управления вершиной счета (CntTop)
-- Стандартное преобразование типов std_logic_vector <- unsigned <- integer
signal	s_top_wr_reg:  std_logic_vector(CntWidth-1 downto 0) := std_logic_vector(to_unsigned(CntTop, CntWidth)); -- Теневой регистр записи
signal	s_top_active:  std_logic_vector(CntWidth-1 downto 0) := std_logic_vector(to_unsigned(CntTop, CntWidth)); -- Рабочий (активный) регистр таймера

-- Внутренние сигналы для чтения состояния стробов внутри архитектуры
signal	s_strobe_bot: std_logic := '0';
signal	s_strobe_top: std_logic := '0';

-- Тип - массив размерностью числа каналов, векторов ширины равной ширине счетчика
type 		cmpr_array_t is array (0 to ChNumber-1) of std_logic_vector(CntWidth-1 downto 0);

-- Буферизация для регистров сравнения (теневые для записи процессором и активные рабочие)
signal	s_cmpr_wr_regs:     cmpr_array_t := (others => (others => '0'));		-- Теневые  регистры сравнения
signal	s_cmpr_active_regs: cmpr_array_t := (others => (others => '0'));		-- Активные регистры сравнения


-- Внутренние сигналы для выходов ШИМ
signal  s_pwm_out_h:    std_logic_vector(ChNumber-1 downto 0) := (others => '0');
signal  s_pwm_out_l:    std_logic_vector(ChNumber-1 downto 0) := (others => '0');




begin

-----------------------------------------------------------------------------------------------------------
process(res,clk)
	
begin
	if res='0' then
	s_cnt<= (others => '0');
	dir<='0';
	
	s_strobe_bot <= '0';
	s_strobe_top <= '0';

	s_top_wr_reg <= std_logic_vector(to_unsigned(CntTop, CntWidth));
	s_top_active <= std_logic_vector(to_unsigned(CntTop, CntWidth));
	
	s_ctrl1_reg <=  (others => '0'); 					-- Значение CNT_CTRL1 при сбросе
	
	for i in 0 to ChNumber-1 loop							-- Сброс регистров сравнения
	s_cmpr_wr_regs(i)     <= (others => '0');
	s_cmpr_active_regs(i) <= (others => '0');
	end loop;	
	
	s_pwm_out_h   <= (others => '0');					-- Значения выходов ШИМ при сбросе
	s_pwm_out_l   <= (others => '0');	
	
	
		elsif (clk'event and clk='1') then

			--------------------------------------------------------------------------------------------------
			-- 1. Обработка шинного интерфейса (на запись от процессора)
			--------------------------------------------------------------------------------------------------
			if wr_en = '1' then
			
				case addr(7 downto 2) is	-- Смещение по словам, младшие биты отбрасываются
				
					when "000000" => -- Смещение 0x00: CNT_CTRL1
					s_ctrl1_reg <= wr_data and CTRL1_WR_MASK;		-- Обработка записи только задействованых бит																				
																				-- Зарезервированные биты обнуляются
                    
					when "000011" => -- Смещение 0x0C: CNT_TOP (Вершина счета)
					s_top_wr_reg <= wr_data(CntWidth-1 downto 0);
                    
					when others =>
						
						-- Проверяем, попадает ли адрес строго в диапазон наших каналов CMPR
						if addr(7 downto 2) >= 12 and addr(7 downto 2) < (12 + ChNumber) then
						  
							-- Универсальная запись в теневые регистры CMPR1..CMPR16, начиная с адреса 0x30 (слово №12)
							for i in 0 to ChNumber-1 loop
								if addr(7 downto 2) = std_logic_vector(to_unsigned(12 + i, 6)) then
								s_cmpr_wr_regs(i) <= wr_data(CntWidth-1 downto 0);
								end if;
							end loop;
						else
						null; -- Для остальных адресов запись игнорируется
						end if;
						
				end case;
			end if;
        
			--------------------------------------------------------------------------------------------------
			-- 2. Обновление активных регистров внизу счета (буферизация)
			--------------------------------------------------------------------------------------------------
			if s_strobe_bot = '1' then
			
				-- Обновление вершины счета (TOP)
				s_top_active <= s_top_wr_reg;
						
				-- обновление регистров сравнения
				for i in 0 to ChNumber-1 loop
				s_cmpr_active_regs(i) <= s_cmpr_wr_regs(i);
				end loop;
				
			end if;

			--------------------------------------------------------------------------------------------------
			-- 3. Базовые импульсы стробов (гасим по умолчанию)
			--------------------------------------------------------------------------------------------------
			-- По умолчанию гасим стробы каждый такт (делаем их импульсными)
			s_strobe_top <= '0'; -- (Шаг 1: задаем базовое значение по умолчанию)
			s_strobe_bot <= '0';

			--------------------------------------------------------------------------------------------------
			-- 4. Автомат счета (использует s_top_active вместо статической константы)
			-- (выполняется ТОЛЬКО если разрешено битом ctrl_en_reg = '1')
			--------------------------------------------------------------------------------------------------
			if s_ctrl1_reg(0) = '1' then									-- CNT_CTRL1, EN[0] bit
			
				-- СЧЕТ ВВЕРХ: идем до значения TopValue
				if dir='0' and s_cnt < s_top_active then
				s_cnt<=s_cnt+1;
			
				-- Достигли вершины -> меняем направление на счет вниз, генерируем строб
				elsif dir='0' and s_cnt = s_top_active then
				dir<='1';
				s_cnt<=s_cnt-1;
			
				-- СЧЕТ ВНИЗ: идем до нуля
				elsif dir='1' and s_cnt > 0 then
				s_cnt<=s_cnt-1;
	
				-- Достигли нуля -> меняем направление на счет вверх
				elsif dir='1' and s_cnt = 0 then
				dir<='0';
				s_cnt<=s_cnt+1;			
				end if;
			
			-----------------------------------------------------------------------------------
			-- 5. Формирование стробов относительно текущей активной вершины
			-----------------------------------------------------------------------------------
				if dir='0' and s_cnt = (s_top_active - 1) then
				s_strobe_top <= '1';  -- строб вершины, на один такт!
				end if;
			
				if dir='1' and s_cnt = 1 then
				s_strobe_bot <= '1';  -- строб подножия, на один такт!
				end if;
			
			end if;
			
			--------------------------------------------------------------------------------------------------
			-- 6. Формирование ШИМ-выходов для всех каналов через цикл (используем активные уставки)
			--------------------------------------------------------------------------------------------------
			for i in 0 to ChNumber-1 loop
				if s_cnt < s_cmpr_active_regs(i) then
				s_pwm_out_h(i) <= '1';
				s_pwm_out_l(i) <= '0'; -- Нижний ключ инверсен верхнему
				else
				s_pwm_out_h(i) <= '0';
				s_pwm_out_l(i) <= '1';
            end if;
			end loop;
			
	end if;

end process;

--------------------------------------------------------------------------------------------
q_out <= s_cnt;
strobe_top <= s_strobe_top;
strobe_bot <= s_strobe_bot;
pwm_out_h   <= s_pwm_out_h;
pwm_out_l   <= s_pwm_out_l;


--------------------------------------------------------------------------------------------
-- Комбинационный процесс чтения регистров (Мультиплексор для процессора)
--------------------------------------------------------------------------------------------
process(addr, s_ctrl1_reg, s_top_active, s_cnt)
begin
		-- По умолчанию обнуляем всю шину чтения
		rd_data <= (others => '0');

		case addr(7 downto 2) is
			when "000000" => -- Смещение 0x00: CNT_CTRL1
			rd_data <= s_ctrl1_reg;	-- Отдаем весь регистр управления скопом
            
		when "000011" =>				-- Смещение 0x0C: CNT_TOP (читаем активный регистр вершины)
			rd_data(CntWidth-1 downto 0) <= s_top_active;
            
		when "000101" =>				-- Смещение 0x14: CNT_VAL (текущее значение счетчика)
			rd_data(CntWidth-1 downto 0) <= s_cnt;
            
		when others =>
			rd_data <= (others => '0');
		end case;
		
end process;









end architecture;