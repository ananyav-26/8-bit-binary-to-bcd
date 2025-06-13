library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_binary_to_bcd_8bit is
end tb_binary_to_bcd_8bit;

architecture behavior of tb_binary_to_bcd_8bit is

    -- Component Declaration
    component binary_to_bcd_8bit
        port (
            clk          : in std_logic;
            binary_input : in std_logic_vector(7 downto 0);
            bcd_output   : out std_logic_vector(11 downto 0)  -- [11:8]=hundreds, [7:4]=tens, [3:0]=ones
        );
    end component;

    -- Signals
    signal clk          : std_logic := '0';
    signal binary_input : std_logic_vector(7 downto 0) := (others => '0');
    signal bcd_output   : std_logic_vector(11 downto 0);

begin

    -- Instantiate UUT (Unit Under Test)
    uut: binary_to_bcd_8bit
        port map (
            clk          => clk,
            binary_input => binary_input,
            bcd_output   => bcd_output
        );
        
     -- Clock Generation Process (20 ns period)
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Apply first input: 15
        binary_input <= "00001111";  -- 15
        wait for 20 ns;              -- wait 1 clock cycle
        report "BCD for 15 = " & integer'image(to_integer(unsigned(bcd_output)));

        -- Apply second input: 42
        binary_input <= "00101010";  -- 42
        wait for 20 ns;
        report "BCD for 42 = " & integer'image(to_integer(unsigned(bcd_output)));

        -- Apply third input: 99
        binary_input <= "01100011";  -- 99
        wait for 20 ns;
        report "BCD for 99 = " & integer'image(to_integer(unsigned(bcd_output)));

        -- Done
        wait;
    end process;

end behavior;
