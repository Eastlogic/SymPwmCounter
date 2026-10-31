LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY SymPwmCounter_tb IS
END SymPwmCounter_tb;
 
ARCHITECTURE behavior OF SymPwmCounter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SymPwmCounter
    PORT(
         res : IN  std_logic;
         clk : IN  std_logic;
         q_out : OUT  std_logic_vector(3 downto 0);
         strobe_top : OUT  std_logic;
			strobe_bot : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal res_t : std_logic := '1';
   signal clk_t : std_logic := '0';

 	--Outputs
   signal q_out_t : std_logic_vector(3 downto 0);
   signal strobe_top_t : std_logic;
	signal strobe_bot_t : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SymPwmCounter PORT MAP (
          res => res_t,
          clk => clk_t,
          q_out => q_out_t,
          strobe_top => strobe_top_t,
			 strobe_bot => strobe_bot_t
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk_t <= '0';
		wait for clk_period/2;
		clk_t <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
