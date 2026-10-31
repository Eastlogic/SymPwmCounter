library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all; -- Требуется для функций конвертации (conv_std_logic_vector)


-- Счетчик формирования симметричной ШИМ
-- Формирует внутренний сигнал dir - направление счета (он же флаг OverFlow/UnderFlow)

entity SymPwmCounter is
generic(
CntWidth:integer:=16;					-- Разрядность счетчика по умолчанию
CntTop:integer:=65535;					-- Вершина счета после сброса(по умолчанию)
ChNumber:integer:=1						-- Число каналов сравнения
);
port(
res,clk: 		in std_logic;
q_out:			out std_logic_vector(CntWidth-1 downto 0);	-- Выход счетчика
strobe_top:		out std_logic;  										-- Импульс на вершине счета
strobe_bot:		out std_logic;   										-- Импульс внизу счета (в нуле)

-- Процессорный интерфейс таймера(фиксированная ширина шины)
addr:				in std_logic_vector(3 downto 0);					-- Адрес регистра (до 16 регистров)
wr_data:			in std_logic_vector(31 downto 0);				-- Фиксированная 32-битная шина данных
wr_en:			in std_logic											-- Строб записи от процессора
);
end entity;


architecture SymPwmCounter_arch of SymPwmCounter is

signal dir: std_logic:='0';			-- Признак направления счета "вверх/вниз"
												-- dir='0' - счет вверх (OverFlow), dir='1' - счет вниз (UnderFlow)
signal s_cnt: std_logic_vector(CntWidth-1 downto 0):= (others => '0');

-- Регистры для динамического управления вершиной счета (CntTop)
signal s_top_wr_reg:  std_logic_vector(CntWidth-1 downto 0) := conv_std_logic_vector(CntTop, CntWidth); -- Теневой регистр записи
signal s_top_active:  std_logic_vector(CntWidth-1 downto 0) := conv_std_logic_vector(CntTop, CntWidth); -- Рабочий (активный) регистр таймера

-- Внутренние сигналы для чтения состояния стробов внутри архитектуры
signal s_strobe_bot: std_logic := '0';
signal s_strobe_top: std_logic := '0';

begin

------------------------------------------------------------------------------------
process(res,clk)
	
begin
	if res='0' then
	s_cnt<= (others => '0');
	dir<='0';
	
	s_strobe_bot <= '0';
	s_strobe_top <= '0';
	
	s_top_wr_reg <= conv_std_logic_vector(CntTop, CntWidth);
	s_top_active <= conv_std_logic_vector(CntTop, CntWidth);
	
	
		elsif (clk'event and clk='1') then

			---------------------------------------------------------------------------
			-- 1. Обработка шинного интерфейса (запись от процессора)
			---------------------------------------------------------------------------
			if wr_en = '1' then
				case addr is
					when "0001" =>
					-- Процессор пишет новое значение вершины счета
					-- Обрезаем 32-битные данные шины до разрядности счетчика CntWidth
					s_top_wr_reg <= wr_data(CntWidth-1 downto 0);
                    
					when others =>
					null; -- Другие адреса пока не задействованы
				end case;
			end if;
        
			---------------------------------------------------------------------------
			-- 2. Обновление активной вершины счета строго внизу (двойная буферизация)
			---------------------------------------------------------------------------
			if s_strobe_bot = '1' then
				s_top_active <= s_top_wr_reg;
			end if;

			---------------------------------------------------------------------------
			-- 3. Базовые импульсы стробов (гасим по умолчанию)
			---------------------------------------------------------------------------	
			-- По умолчанию гасим стробы каждый такт (делаем их импульсными)
			s_strobe_top <= '0'; -- (Шаг 1: задаем базовое значение по умолчанию)
			s_strobe_bot <= '0';

			---------------------------------------------------------------------------
			-- 4. Автомат счета (использует s_top_active вместо статической константы)
			---------------------------------------------------------------------------		
			-- СЧЕТ ВВЕРХ: идем до значения TopValue
			if dir='0' and s_cnt < CntTop then
			s_cnt<=s_cnt+1;
			
			-- Достигли вершины -> меняем направление на счет вниз, генерируем строб
			elsif dir='0' and s_cnt = CntTop then
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
			
			---------------------------------------------------------------------------
			-- 5. Формирование стробов относительно текущей активной вершины
			---------------------------------------------------------------------------
			if dir='0' and s_cnt = (CntTop - 1) then
			s_strobe_top <= '1';  -- строб вершины, на один такт!
			end if;
			
			if dir='1' and s_cnt = 1 then
			s_strobe_bot <= '1';  -- строб подножия, на один такт!
			end if;
			
			
	end if;

end process;

------------------------------------------------------------------------------------
q_out <= s_cnt;
strobe_top <= s_strobe_top;
strobe_bot <= s_strobe_bot;

end architecture;