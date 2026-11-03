LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY SymPwmCounter_tb IS
END SymPwmCounter_tb;

ARCHITECTURE behavior OF SymPwmCounter_tb IS 

   -- Входные сигналы тестбенча
   signal res_t     : std_logic := '0';
   signal clk_t     : std_logic := '0';
   signal addr_t    : std_logic_vector(7 downto 0) := (others => '0');
   signal wr_data_t : std_logic_vector(31 downto 0) := (others => '0');
   signal wr_en_t   : std_logic := '0';

   -- Выходные сигналы тестбенча
   signal q_out_t       : std_logic_vector(3 downto 0);
   signal strobe_top_t  : std_logic;
   signal strobe_bot_t  : std_logic;
	signal rd_data_t		: std_logic_vector(31 downto 0);

   -- Определение периода тактовой частоты (100 нс)
   constant clk_period : time := 100 ns;
   
BEGIN
 
    -- Инстанцирование тестируемого модуля (UUT)
    uut: entity work.SymPwmCounter 
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
		  rd_data	 => rd_data_t,
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
       -- Шаг 1. Удерживаем активный сброс
       res_t     <= '0';
       addr_t    <= (others => '0');
       wr_data_t <= (others => '0');
       wr_en_t   <= '0';
       wait for 200 ns;    
       res_t     <= '1'; -- Снимаем сброс

       -- Шаг 2. Проверяем остановленное состояние: 
       -- EN пока равен 0 (сброшен), счетчик должен стоять в нуле
       wait for clk_period * 5;

       -- Шаг 3. Включаем счетчик: пишем '1' в регистр CNT_CTRL1 (адрес смещения 0x00)
       wait until rising_edge(clk_t);
       addr_t    <= x"00";         	 -- Адрес 0x00 (CNT_CTRL1)
       wr_data_t <= x"00000001";     -- Бит 0 (EN) = 1
       wr_en_t   <= '1';
       
       wait until rising_edge(clk_t);
       wr_en_t   <= '0';             -- Снимаем строб записи
       
       -- Даем счетчику поработать с дефолтной вершиной (CntTop = 7)
       wait for clk_period * 25;

       -- Шаг 4. Меняем вершину CntTop на значение 12 в процессе счета
       -- Адрес регистра CNT_TOP = 0x0C, данные = 12 (0x0000000C)
       wait until rising_edge(clk_t);
       addr_t    <= x"0C";          -- Адрес 0x0C (CNT_TOP)
       wr_data_t <= x"0000000C";     -- Новое значение вершины = 12
       wr_en_t   <= '1';             -- Выставляем строб записи
       
       wait until rising_edge(clk_t);
       wr_en_t   <= '0';             -- Снимаем строб записи

       -- Наблюдаем отработку нового максимума
       wait for clk_period * 40;
		 
		 -- Шаг 5. Тестирование паузы (остановка счета): пишем '0' в CNT_CTRL1 (0x00)
       wait until rising_edge(clk_t);
       addr_t    <= x"00";          -- Адрес 0x00 (CNT_CTRL1)
       wr_data_t <= x"00000000";     -- Бит 0 (EN) = 0 (Пауза)
       wr_en_t   <= '1';
       
       wait until rising_edge(clk_t);
       wr_en_t   <= '0';

       -- Удерживаем паузу на 15 тактов - счетчик должен замереть в текущем положении
       wait for clk_period * 15;

       -- Шаг 6. Возобновление счета: снова пишем '1' в CNT_CTRL1 (0x00)
       wait until rising_edge(clk_t);
       addr_t    <= x"00";          -- Адрес 0x00 (CNT_CTRL1)
       wr_data_t <= x"00000001";     -- Бит 0 (EN) = 1 (Продолжить счет)
       wr_en_t   <= '1';
       
       wait until rising_edge(clk_t);
       wr_en_t   <= '0';

       -- Наблюдаем дальнейшую работу счетчика после паузы
       wait for clk_period * 40;
		 

       -- Завершение симуляции
       wait;
   end process;

END;