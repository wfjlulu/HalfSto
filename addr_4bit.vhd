library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity addr_4bit is
    port(
        a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        sum : out std_logic_vector(3 downto 0)
    );
end addr_4bit;

architecture arch of addr_4bit is

    signal s : signed(3 downto 0);
    signal overflow : std_logic;
    signal nota3 : std_logic;

begin
    s <= signed(a) + signed(b);
    overflow <= ( not( a(3) xor b(3) ) ) and ( b(3) xor s(3) );
    nota3 <= not a(3);
    sum <= std_logic_vector(s) when overflow = '0' else
           ( a(3) & nota3 & nota3 & '1' );
end arch ; 