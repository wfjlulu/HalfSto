--this a dv = 6 vn

library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;  --ieee
-- the flowing two are sysnopsys  
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;  

entity VN_Dv6 is
    port(
        clk : in std_logic;
        rst_n : in std_logic;
        New_LLR : in std_logic;
        DecoderOver : in std_logic;
        --DV_in : in std_logic;
        RandomNum : in std_logic_vector( 3 downto 0 ); --unsigned number
        LLR  : in std_logic_vector( 5 downto 0);  -- input LLR is 5 bits signed number +-15
        Din0 : in std_logic_vector( 1 downto 0);  -- one bit for sign 4 bits for AM 
        Din1 : in std_logic_vector( 1 downto 0);
        Din2 : in std_logic_vector( 1 downto 0);
        Din3 : in std_logic_vector( 1 downto 0);
        Din4 : in std_logic_vector( 1 downto 0);
        Din5 : in std_logic_vector( 1 downto 0);
        VN2CN0_bit : out std_logic;
        VN2CN1_bit : out std_logic;
        VN2CN2_bit : out std_logic;
        VN2CN3_bit : out std_logic;
        VN2CN4_bit : out std_logic;
        VN2CN5_bit : out std_logic;
        VN2CN0_sign : out std_logic;
        VN2CN1_sign : out std_logic;
        VN2CN2_sign : out std_logic;
        VN2CN3_sign : out std_logic;
        VN2CN4_sign : out std_logic;
        VN2CN5_sign : out std_logic;

        codeword    : out std_logic;
        Iterations  : inout std_logic_vector(4 downto 0);

        DV_out : out std_logic;  -- codeword valid flag
        DecodeState : out std_logic_vector( 1 downto 0 )
    );
end VN_Dv6;

architecture Behavioral of VN_Dv6 is 
    signal in0 : signed( 1 downto 0 );
    signal in1 : signed( 1 downto 0 );
    signal in2 : signed( 1 downto 0 );
    signal in3 : signed( 1 downto 0 );
    signal in4 : signed( 1 downto 0 );  
    signal in5 : signed( 1 downto 0 );
    signal in0_sum : signed( 5 downto 0 );
    signal in1_sum : signed( 5 downto 0 );
    signal in2_sum : signed( 5 downto 0 );
    signal in3_sum : signed( 5 downto 0 );
    signal in4_sum : signed( 5 downto 0 );
    signal in5_sum : signed( 5 downto 0 );

    signal Dout0 : signed( 7 downto 0);  -- VN2CN message 2' complement
    signal Dout1 : signed( 7 downto 0);
    signal Dout2 : signed( 7 downto 0);
    signal Dout3 : signed( 7 downto 0);
    signal Dout4 : signed( 7 downto 0);
    signal Dout5 : signed( 7 downto 0);
    signal Dataout0 : unsigned( 6 downto 0 );  -- only AM
    signal Dataout1 : unsigned( 6 downto 0 );
    signal Dataout2 : unsigned( 6 downto 0 );
    signal Dataout3 : unsigned( 6 downto 0 );
    signal Dataout4 : unsigned( 6 downto 0 );
    signal Dataout5 : unsigned( 6 downto 0 );


    signal sum : signed( 7 downto 0 );

    type state is  ( idle, s0, s1, s2, waitoneclk );
    signal CurrentState : state;

    signal cnt : unsigned( 3 downto 0 );
    signal RandomNum2 : std_logic_vector( 3 downto 0);
    signal cnt2 : unsigned(0 downto 0);
    
begin 
    
    -- sign bit output 
    VN2CN0_sign <= Dout0(7);
    VN2CN1_sign <= Dout1(7);
    VN2CN2_sign <= Dout2(7);
    VN2CN3_sign <= Dout3(7);
    VN2CN4_sign <= Dout4(7);
    VN2CN5_sign <= Dout5(7);
    --amplitude bit output
    VN2CN0_bit <= '1' when Dataout0 > unsigned(RandomNum2) else
                  '0';
    VN2CN1_bit <= '1' when Dataout1 > unsigned(RandomNum2) else
                  '0';
    VN2CN2_bit <= '1' when Dataout2 > unsigned(RandomNum2) else
                  '0';
    VN2CN3_bit <= '1' when Dataout3 > unsigned(RandomNum2) else
                  '0';
    VN2CN4_bit <= '1' when Dataout4 > unsigned(RandomNum2) else
                  '0';
    VN2CN5_bit <= '1' when Dataout5 > unsigned(RandomNum2) else
                  '0';

    codeword <= '1' when sum < 0 else
                '0';

    -- transform to sign + amplitude and truncated to 6 bits
    -- ( 1 bit sign and  5 bits amplitude )
    Dataout0 <= unsigned(Dout0(6 downto 0)) when Dout0(7) = '0' else
                unsigned( not Dout0(6 downto 0) ) + 1 ;
    Dataout1 <= unsigned(Dout1(6 downto 0)) when Dout1(7) = '0' else
                unsigned( not Dout1(6 downto 0) ) + 1 ;
    Dataout2 <= unsigned(Dout2(6 downto 0)) when Dout2(7) = '0' else
                unsigned( not Dout2(6 downto 0) ) + 1 ;
    Dataout3 <= unsigned(Dout3(6 downto 0)) when Dout3(7) = '0' else
                unsigned( not Dout3(6 downto 0) ) + 1 ;
    Dataout4 <= unsigned(Dout4(6 downto 0)) when Dout4(7) = '0' else
                unsigned( not Dout4(6 downto 0) ) + 1 ;
    Dataout5 <= unsigned(Dout5(6 downto 0)) when Dout5(7) = '0' else
                unsigned( not Dout5(6 downto 0) ) + 1 ;
    
    in0 <= ( ( Din0(1) and Din0(0) ) & Din0(0) );
    in1 <= ( ( Din1(1) and Din1(0) ) & Din1(0) );
    in2 <= ( ( Din2(1) and Din2(0) ) & Din2(0) );
    in3 <= ( ( Din3(1) and Din3(0) ) & Din3(0) );
    in4 <= ( ( Din4(1) and Din4(0) ) & Din4(0) );
    in5 <= ( ( Din5(1) and Din5(0) ) & Din5(0) );
    process( rst_n, clk , DecoderOver )   --  i may waste a/two clk but for convenienec i do not modify it
        begin
            if( rst_n = '0' or DecoderOver = '1' ) then 
                CurrentState <= idle;
                Iterations <= "00000";
                --cnt2 <= "00";
            elsif clk'event and clk = '1' then
                case CurrentState is 
                    when idle =>if New_LLR = '1' then
                                    CurrentState <= s0;
                                else
                                    CurrentState <= idle;
                                end if ;
                                --cnt2 <= cnt2 + 1 ;
                                DecodeState <= "00";
                                cnt2(0) <= '0';
                                RandomNum2 <= "0001";
                                --cnt3 <= "00";
                    when s0  => if cnt2 = 1 then
                                    CurrentState <= s1;
                                else
                                    CurrentState <= s0;
                                end if;
                                cnt2 <= cnt2 + 1 ;
                                cnt <= "0000";
                                DV_out <= '0';
                                in0_sum <= "000000";
                                in1_sum <= "000000";
                                in2_sum <= "000000";
                                in3_sum <= "000000";
                                in4_sum <= "000000";
                                in5_sum <= "000000";
                                Dout0 <= signed( LLR(5)&LLR(5)&LLR) ;
                                Dout1 <= signed( LLR(5)&LLR(5)&LLR) ;
                                Dout2 <= signed( LLR(5)&LLR(5)&LLR) ;
                                Dout3 <= signed( LLR(5)&LLR(5)&LLR) ;
                                Dout4 <= signed( LLR(5)&LLR(5)&LLR) ;
                                Dout5 <= signed( LLR(5)&LLR(5)&LLR) ;
                                sum <=  signed ( LLR(5)&LLR(5)&LLR) ;
                                Iterations <= "00000";
                                RandomNum2 <= std_logic_vector(unsigned(RandomNUm2) + 1);
                                --RandomNum2 <= "0001";
                                DecodeState <= "01";
                                --Iterations <= std_logic_vector(unsigned(Iterations) + 1);
                    when s1  => if cnt = 13 then 
                                    CurrentState <= s2;
                                    DV_out <= '1';
                                else
                                    CurrentState <= s1;
                                end if;
                                --cnt3 <= "00";
                                --DV_out <= '1';
                                in0_sum <= in0_sum + in0;
                                in1_sum <= in1_sum + in1;
                                in2_sum <= in2_sum + in2;
                                in3_sum <= in3_sum + in3;
                                in4_sum <= in4_sum + in4;
                                in5_sum <= in5_sum + in5;
                                sum <= sum + in0 + in1 + in2 +
                                       in3 + in4 + in5;
                                cnt <= cnt +1;
                                DecodeState <= "10";
                                RandomNum2 <= std_logic_vector(unsigned(RandomNUm2) + 1);
                    when s2 =>  if unsigned(Iterations) = 20 then
                                    CurrentState <= idle;
                                else
                                    CurrentState <= waitoneclk;
                                end if;
                                --cnt3 <= cnt3 + 1 ; 
                                DV_out <= '0';
                                sum <= signed(LLR(5)&LLR(5)&LLR);
                                in0_sum <= "000000";
                                in1_sum <= "000000";
                                in2_sum <= "000000";
                                in3_sum <= "000000";
                                in4_sum <= "000000";
                                in5_sum <= "000000";
                                Dout0 <= sum - in0_sum;
                                Dout1 <= sum - in1_sum;
                                Dout2 <= sum - in2_sum;
                                Dout3 <= sum - in3_sum;
                                Dout4 <= sum - in4_sum;
                                Dout5 <= sum - in5_sum;
                                cnt <=  "0000";
                                Iterations <= std_logic_vector(unsigned(Iterations) + 1);
                                RandomNum2 <= "0010";
                                DecodeState <= "11";
                    when waitoneclk => CurrentState <= s1;
                    RandomNum2 <= std_logic_vector(unsigned(RandomNUm2) + 1);      
                    -- waitoneclk waits the data from the CN, CN datas are 
                    -- paded one clk
                end case;
            end if ;
    end process;
end Behavioral;



                                   

                                     

                
                      

                


    