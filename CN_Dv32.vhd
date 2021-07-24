library ieee;
use ieee.std_logic_1164.all;

entity CN_Dv32 is
    port(
        --rst_n : in std_logic;
        --clk   : in std_logic;
        --DV_in : in std_logic;
        VN2CN_bit  : in std_logic_vector( 31 downto 0 );
        VN2CN_sign : in std_logic_vector( 31 downto 0 );
        CN2VN_bit  : out std_logic_vector( 31 downto 0 );
        CN2VN_sign : out std_logic_vector( 31 downto 0)
        --DV_out : out std_logic
    );
end CN_Dv32;

architecture behavioral of CN_Dv32 is 
    signal sign_flag : std_logic;


begin
    sign_flag <= VN2CN_sign(31) XOR VN2CN_sign(30) XOR VN2CN_sign(29) XOR
                 VN2CN_sign(28) XOR VN2CN_sign(27) XOR VN2CN_sign(26) XOR
                 VN2CN_sign(25) XOR VN2CN_sign(24) XOR VN2CN_sign(23) XOR
                 VN2CN_sign(22) XOR VN2CN_sign(21) XOR VN2CN_sign(20) XOR
                 VN2CN_sign(19) XOR VN2CN_sign(18) XOR VN2CN_sign(17) XOR
                 VN2CN_sign(16) XOR VN2CN_sign(15) XOR VN2CN_sign(14) XOR
                 VN2CN_sign(13) XOR VN2CN_sign(12) XOR VN2CN_sign(11) XOR
                 VN2CN_sign(10) XOR VN2CN_sign(9)  XOR VN2CN_sign(8) XOR
                 VN2CN_sign(7)  XOR VN2CN_sign(6)  XOR VN2CN_sign(5) XOR
                 VN2CN_sign(4)  XOR VN2CN_sign(3)  XOR VN2CN_sign(2) XOR
                 VN2CN_sign(1)  XOR VN2CN_sign(0) ;
    signloop : for i in 0 to 31 generate
        CN2VN_sign(i) <= VN2CN_sign(i) xor sign_flag;
    end generate;

    CN2VN_bit(31) <= VN2CN_bit(30) and VN2CN_bit(29) and
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(30) <= VN2CN_bit(31) and VN2CN_bit(29)  and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(29) <= VN2CN_bit(31) and VN2CN_bit(30) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and
                     VN2CN_bit(1)  and VN2CN_bit(0) ;
    
    CN2VN_bit(28) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and
                                       VN2CN_bit(27) and VN2CN_bit(26) and
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(27) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28)                   and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(26) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(25) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                                       VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(24) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25)                   and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(23) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and  
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(22) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                                       VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(21) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22)                   and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ; 
                     
    CN2VN_bit(20) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and  
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ; 
                     
    CN2VN_bit(19) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                                       VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(18) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19)                   and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(17) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(16) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                                       VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;    
                     
    CN2VN_bit(15) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16)                   and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(14) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and  
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(13) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                                       VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(12) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13)                   and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(11) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(10) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                                       VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(9) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10)                   and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(8) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and  
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(7) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                                       VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(6) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)                    and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(5) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and  
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(4) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                                       VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(3) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)                    and VN2CN_bit(2)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(2) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and 
                     VN2CN_bit(1)  and VN2CN_bit(0) ;

    CN2VN_bit(1) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                                       VN2CN_bit(0) ;

    CN2VN_bit(0) <= VN2CN_bit(31) and VN2CN_bit(30) and VN2CN_bit(29) and 
                     VN2CN_bit(28) and VN2CN_bit(27) and VN2CN_bit(26) and 
                     VN2CN_bit(25) and VN2CN_bit(24) and VN2CN_bit(23) and 
                     VN2CN_bit(22) and VN2CN_bit(21) and VN2CN_bit(20) and 
                     VN2CN_bit(19) and VN2CN_bit(18) and VN2CN_bit(17) and 
                     VN2CN_bit(16) and VN2CN_bit(15) and VN2CN_bit(14) and 
                     VN2CN_bit(13) and VN2CN_bit(12) and VN2CN_bit(11) and 
                     VN2CN_bit(10) and VN2CN_bit(9)  and VN2CN_bit(8)  and 
                     VN2CN_bit(7)  and VN2CN_bit(6)  and VN2CN_bit(5)  and 
                     VN2CN_bit(4)  and VN2CN_bit(3)  and VN2CN_bit(2)  and 
                     VN2CN_bit(1);
end behavioral;

    