LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY SymPwmCounter_tb IS
END SymPwmCounter_tb;

ARCHITECTURE behavior OF SymPwmCounter_tb IS 


       -- Объявление компонента UUT с учетом новых портов (по стандарту VHDL-87)
--    COMPONENT SymPwmCounter
--    GENERIC(
--        CntWidth : integer := 4;
--        CntTop   : integer := 7;      -- Уменьшаем для удобства симуляции (вершина = 7)
--        ChNumber : integer := 1
--    );
--    PORT(
--        res         : IN  std_logic;
--        clk         : IN  std_logic;
--        q_out       : OUT std_logic_vector(CntWidth-1 downto 0);
--        strobe_top  : OUT std_logic;
--        strobe_bot  : OUT std_logic;
--        addr        : IN  std_logic_vector(3 downto 0);
--        wr_data     : IN  std_logic_vector(31 downto 0);
--        wr_en       : IN  std_logic
--    );
--    END COMPONENT; 

   -- Входные сигналы тестбенча
   signal res_t     : std_logic := '0';
   signal clk_t     : std_logic := '0';
   signal addr_t    : std_logic_vector(3 downto 0) := (others => '0');
   signal wr_data_t : std_logic_vector(31 downto 0) := (others => '0');
   signal wr_en_t   : std_logic := '0';

   -- Выходные сигналы тестбенча
   signal q_out_t       : std_logic_vector(3 downto 0);
   signal strobe_top_t  : std_logic;
   signal strobe_bot_t  : std_logic;

   -- Определение периода тактовой частоты (100 нс -> 10 МГц)
   constant clk_period : time := 100 ns;
   
BEGIN
 
    -- Инстанцирование тестируемого модуля (UUT)
    -- Переопределяем через generic разрядность на 4 бита, а вершину на 7
--    uut: SymPwmCounter								-- вариант VHDL-87
	 uut:entity work.SymPwmCounter					-- вариант VHDL-93
    GENERIC MAP(
        CntWidth => 4,
        CntTop   => 7,
        ChNumber => 1
    )
    PORT MAP(
        res        => res_t,
        clk        => clk_t,
        q_out      => q_out_t,
        strobe_top => strobe_top_t,
        strobe_bot => strobe_bot_t,
        addr       => addr_t,
        wr_data    => wr_data_t,
        wr_en      => wr_en_t
    );

   -- Процесс генерации тактовой частоты
   clk_process : process
   begin
        clk_t <= '0';
        wait for clk_period/2;
        clk_t <= '1';
        wait for clk_period/2;
   end process;
 

   -- Процесс подачи стимулов (тест-сценарий)
   stim_proc: process
   begin        
       -- Шаг 1. Удерживаем активный сброс 200 нс
       res_t <= '0';
       wait for 200 ns;    
       res_t <= '1'; -- Снимаем сброс

       -- Даем счетчику поработать с дефолтной вершиной (CntTop = 7) несколько периодов
       wait for clk_period * 20;

       -- Шаг 2. Имитируем запись от процессора: меняем вершину CntTop на значение 12
       -- Адрес регистра вершины = "0001", данные = 12 (0x0000000C)
       wait until rising_edge(clk_t);
       addr_t    <= "0001";          -- Адрес регистра CntTop
       wr_data_t <= x"0000000C";     -- Новое значение вершины = 12
       wr_en_t   <= '1';             -- Выставляем строб записи на один такт
       
       wait until rising_edge(clk_t);
       wr_en_t   <= '0';             -- Снимаем строб записи
       addr_t    <= (others => '0');
       wr_data_t <= (others => '0');

       -- Наблюдаем в симуляторе, как счетчик доработает текущий период до 7, 
       -- а внизу (по strobe_bot) аккуратно переключится на новый максимум 12!
       wait for clk_period * 40;

       -- Завершение симуляции
       wait;
   end process;

END;