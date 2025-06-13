library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity for 8-bit binary to BCD converter
entity binary_to_bcd_8bit is
    port (
        clk          : in std_logic;                         -- Clock input
        binary_input : in std_logic_vector(7 downto 0);      -- 8-bit binary input
        bcd_output   : out std_logic_vector(11 downto 0)     -- 12-bit BCD output (hundreds, tens, ones)
    );
end binary_to_bcd_8bit;

architecture behavioral of binary_to_bcd_8bit is
    -- Internal signals for readability (optional, not used directly)
    signal hundreds, tens, ones : std_logic_vector(3 downto 0);
begin
    process(clk)
        -- 20-bit shift register: [19:12]=hundreds, [11:8]=tens, [7:0]=binary input
        variable shift_reg : std_logic_vector(19 downto 0); 
        variable i         : integer;
    begin
        if rising_edge(clk) then
            -- Initialize shift register with binary input in lower 8 bits
            shift_reg := (others => '0');
            shift_reg(7 downto 0) := binary_input;

            -- Perform 8 iterations of the Double Dabble algorithm
            for i in 0 to 7 loop
                -- Check if any BCD digit >= 5, then add 3 (BCD correction)
                if shift_reg(11 downto 8) > "0100" then
                    shift_reg(11 downto 8) := std_logic_vector(unsigned(shift_reg(11 downto 8)) + 3);
                end if;
                if shift_reg(15 downto 12) > "0100" then
                    shift_reg(15 downto 12) := std_logic_vector(unsigned(shift_reg(15 downto 12)) + 3);
                end if;
                if shift_reg(19 downto 16) > "0100" then
                    shift_reg(19 downto 16) := std_logic_vector(unsigned(shift_reg(19 downto 16)) + 3);
                end if;

                -- Shift the entire register left by 1 bit
                shift_reg := shift_reg(18 downto 0) & '0';
            end loop;

            -- Assign the resulting BCD digits to the output
            bcd_output <= shift_reg(19 downto 16) &  -- Hundreds
                          shift_reg(15 downto 12) &  -- Tens
                          shift_reg(11 downto 8);    -- Ones
        end if;
    end process;
end behavioral;
