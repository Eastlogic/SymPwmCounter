library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


-- Счетчик формирования симметричной ШИМ
-- Формирует внутренний сигнал dir - направление счета (он же флаг OverFlow/UnderFlow)

entity SymPwmCounter is
generic(
CntWidth:integer:=4;						-- Разрядность счетчика по умолчанию
CntTop:integer:=15;						-- Вершина счета по умолчанию
ChNumber:integer:=1						-- Число каналов сравнения
);
port(
res,clk: 		in std_logic;
q_out:			out std_logic_vector(CntWidth-1 downto 0);	-- Выход счетчика
strobe_top:		out std_logic;  										-- Импульс на вершине счета
strobe_bot:		out std_logic   										-- Импульс внизу счета (в нуле)
);
end entity;


architecture SymPwmCounter_arch of SymPwmCounter is

signal dir: std_logic:='0';			-- Признак направления счета "вверх/вниз"
												-- dir='0' - счет вверх (OverFlow), dir='1' - счет вниз (UnderFlow)
signal s_cnt: std_logic_vector(CntWidth-1 downto 0):= (others => '0');
begin

------------------------------------------------------------------------------------
process(res,clk)
	
begin
	if res='0' then
	s_cnt<= (others => '0');
	dir<='0';
	
	strobe_top <= '0';
	strobe_bot <= '0';
	
		elsif (clk'event and clk='1') then
		
			-- По умолчанию гасим стробы каждый такт (делаем их импульсными)
			strobe_top <= '0'; -- (Шаг 1: задаем базовое значение по умолчанию)
			strobe_bot <= '0';
		
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
			-- Описание формирования стробов 
			---------------------------------------------------------------------------
			if dir='0' and s_cnt = (CntTop - 1) then
			strobe_top <= '1';  -- строб вершины, на один такт!
			end if;
			
			if dir='1' and s_cnt = 1 then
			strobe_bot <= '1';  -- строб подножия, на один такт!
			end if;
			
			
	end if;

end process;

------------------------------------------------------------------------------------
q_out<=s_cnt;



end architecture;