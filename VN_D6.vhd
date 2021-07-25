library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity VN_D6 is
    port(
        clk : in std_logic;
        clear : in std_logic;
        VN2CN_en : in std_logic;
        Iterations : in std_logic_vector( 4 downto 0 );
        --rst_n : in std_logic;
        --New_fram : in std_logic;
        --DecoderOver : in std_logic;
        --DV_in : in std_logic;
        RandomNum : in std_logic_vector( 2 downto 0 ); --unsigned number
        LLR  : in std_logic_vector( 3 downto 0);  -- input LLR is 5 bits signed number +-15
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

        codeword    : out std_logic
        --Iterations  : inout std_logic_vector(4 downto 0);

        --DV_out : out std_logic;  -- codeword valid flag
        --DecodeState : out std_logic_vector( 1 downto 0 )
    );
end VN_D6;

architecture Behavioral of VN_D6 is

    component addr_4bit is
        port(
            a : in std_logic_vector(3 downto 0);
            b : in std_logic_vector(3 downto 0);
            sum : out signed(3 downto 0)
        );
    end component;

    --signal clear

    signal in0 : signed( 1 downto 0 );
    signal in1 : signed( 1 downto 0 );
    signal in2 : signed( 1 downto 0 );
    signal in3 : signed( 1 downto 0 );
    signal in4 : signed( 1 downto 0 );  
    signal in5 : signed( 1 downto 0 );

    signal VN2CN0 : signed( 3 downto 0);
    signal VN2CN1 : signed( 3 downto 0);
    signal VN2CN2 : signed( 3 downto 0);
    signal VN2CN3 : signed( 3 downto 0);
    signal VN2CN4 : signed( 3 downto 0);
    signal VN2CN5 : signed( 3 downto 0);
    signal VN2CN0_reg : signed( 3 downto 0);
    signal VN2CN1_reg : signed( 3 downto 0);
    signal VN2CN2_reg : signed( 3 downto 0);
    signal VN2CN3_reg : signed( 3 downto 0);
    signal VN2CN4_reg : signed( 3 downto 0);
    signal VN2CN5_reg : signed( 3 downto 0);

    signal VN2CN0_abs : unsigned( 2 downto 0);
    signal VN2CN1_abs : unsigned( 2 downto 0);
    signal VN2CN2_abs : unsigned( 2 downto 0);
    signal VN2CN3_abs : unsigned( 2 downto 0);
    signal VN2CN4_abs : unsigned( 2 downto 0);
    signal VN2CN5_abs : unsigned( 2 downto 0);

    signal counter0 : signed( 3 downto 0 );
    signal counter1 : signed( 3 downto 0 );
    signal counter2 : signed( 3 downto 0 );
    signal counter3 : signed( 3 downto 0 );
    signal counter4 : signed( 3 downto 0 );
    signal counter5 : signed( 3 downto 0 );
    signal stage1_sum0 : signed( 3 downto 0 ); 
    signal stage1_sum1 : signed( 3 downto 0 );
    signal stage1_sum2 : signed( 3 downto 0 );
    signal stage2_sum0 : signed( 3 downto 0 );
    signal stage2_sum1 : signed( 3 downto 0 );
    signal VN2CN_sum   : signed( 3 downto 0 );

    --signal RandomNum2 :  unsigned( 2 downto 0);

begin
    -- sign + amplitude => 2' complement
    in0 <= ( ( Din0(1) and Din0(0) ) & Din0(0) );
    in1 <= ( ( Din1(1) and Din1(0) ) & Din1(0) );
    in2 <= ( ( Din2(1) and Din2(0) ) & Din2(0) );
    in3 <= ( ( Din3(1) and Din3(0) ) & Din3(0) );
    in4 <= ( ( Din4(1) and Din4(0) ) & Din4(0) );
    in5 <= ( ( Din5(1) and Din5(0) ) & Din5(0) );

    -- core three stage adder
    ----------------------------------------
    --stage1_sum0 <= counter0 + counter1;
    --stage1_sum1 <= counter2 + counter3;
    --stage1_sum2 <= counter4 + counter5;

    --stage2_sum0 <= stage1_sum0 + stage1_sum1;
    --stage2_sum1 <= stage1_sum2 + signed(LLR);

    --VN2CN_sum <= stage2_sum0 + stage2_sum1;
    stage1add0 : addr_4bit port map(
        a => std_logic_vector(counter0),
        b => std_logic_vector(counter1),
        sum => (stage1_sum0)
    );
    stage1add1 : addr_4bit port map(
        a => std_logic_vector(counter2),
        b => std_logic_vector(counter3),
        sum => (stage1_sum1)
    );
    stage1add2 : addr_4bit port map(
        a => std_logic_vector(counter4),
        b => std_logic_vector(counter5),
        sum => (stage1_sum2)
    );

    stage2add0 : addr_4bit port map(
        a => std_logic_vector(stage1_sum0),
        b => std_logic_vector(stage1_sum1),
        sum => (stage2_sum0)
    );
    stage2add1 : addr_4bit port map(
        a => std_logic_vector(stage1_sum2),
        b => (LLR),
        sum => (stage2_sum1)
    );

    stage3add : addr_4bit port map(
        a => std_logic_vector(stage2_sum0),
        b => std_logic_vector(stage2_sum1),
        sum => (VN2CN_sum)
    );



    VN2CN0 <= VN2CN_sum - counter0;
    VN2CN1 <= VN2CN_sum - counter1;
    VN2CN2 <= VN2CN_sum - counter2;
    VN2CN3 <= VN2CN_sum - counter3;
    VN2CN4 <= VN2CN_sum - counter4;
    VN2CN5 <= VN2CN_sum - counter5;
    ---------------------------------------
    -- sign and abs
    VN2CN0_sign <= VN2CN0_reg(3);
    VN2CN1_sign <= VN2CN1_reg(3);
    VN2CN2_sign <= VN2CN2_reg(3);
    VN2CN3_sign <= VN2CN3_reg(3);
    VN2CN4_sign <= VN2CN4_reg(3);
    VN2CN5_sign <= VN2CN5_reg(3);
    VN2CN0_abs <= unsigned(VN2CN0_reg(2 downto 0)) when VN2CN0(3) = '0' else
                  unsigned( not ( VN2CN0_reg( 2 downto 0) ) ) + 1;
    VN2CN1_abs <= unsigned(VN2CN1_reg(2 downto 0)) when VN2CN1(3) = '0' else
                  unsigned( not ( VN2CN1_reg( 2 downto 0) ) ) + 1;
    VN2CN2_abs <= unsigned(VN2CN2_reg(2 downto 0)) when VN2CN2(3) = '0' else
                  unsigned( not ( VN2CN2_reg( 2 downto 0) ) ) + 1;
    VN2CN3_abs <= unsigned(VN2CN3_reg(2 downto 0)) when VN2CN3(3) = '0' else
                  unsigned( not ( VN2CN3_reg( 2 downto 0) ) ) + 1;
    VN2CN4_abs <= unsigned(VN2CN4_reg(2 downto 0)) when VN2CN4(3) = '0' else
                  unsigned( not ( VN2CN4_reg( 2 downto 0) ) ) + 1;
    VN2CN5_abs <= unsigned(VN2CN5_reg(2 downto 0)) when VN2CN5(3) = '0' else
                  unsigned( not ( VN2CN5_reg( 2 downto 0) ) ) ;

    -- comparer to get bitstream-----------
    VN2CN0_bit <= '1' when ( VN2CN0_abs > unsigned(RandomNum) ) else '0';
    VN2CN1_bit <= '1' when ( VN2CN1_abs > unsigned(RandomNum) ) else '0';
    VN2CN2_bit <= '1' when ( VN2CN2_abs > unsigned(RandomNum) ) else '0';
    VN2CN3_bit <= '1' when ( VN2CN3_abs > unsigned(RandomNum) ) else '0';
    VN2CN4_bit <= '1' when ( VN2CN4_abs > unsigned(RandomNum) ) else '0';
    VN2CN5_bit <= '1' when ( VN2CN5_abs > unsigned(RandomNum) ) else '0';
         


    process( clk , clear )
    begin
        if( clear = '1' ) then
            counter0 <= "0000";
        elsif clk'event and clk = '1' then
            if in0(1) = '1' then
                counter0 <= counter0 - 1 ;
            elsif in0(0) = '1' then
                counter0 <= counter0 + 1 ;                
            end if ;
        end if;
    end process;

    process( clk , clear )
    begin
        if( clear = '1' ) then
            counter1 <= "0000";
        elsif clk'event and clk = '1' then
            if in1(1) = '1' then
                counter1 <= counter1 - 1 ;
            elsif in1(0) = '1' then
                counter1 <= counter1 + 1 ;                
            end if ;
        end if;
    end process;

    process( clk , clear )
    begin
        if( clear = '1' ) then
            counter2 <= "0000";
        elsif clk'event and clk = '1' then
            if in2(1) = '1' then
                counter2 <= counter2 - 1 ;
            elsif in2(0) = '1' then
                counter2 <= counter2 + 1 ;                
            end if ;
        end if;
    end process;

    process( clk , clear )
    begin
        if( clear = '1' ) then
            counter3 <= "0000";
        elsif clk'event and clk = '1' then
            if in3(1) = '1' then
                counter3 <= counter3 - 1 ;
            elsif in3(0) = '1' then
                counter3 <= counter3 + 1 ;                
            end if ;
        end if;
    end process;

    process( clk , clear )
    begin
        if( clear = '1' ) then
            counter4 <= "0000";
        elsif clk'event and clk = '1' then
            if in4(1) = '1' then
                counter4 <= counter4 - 1 ;
            elsif in4(0) = '1' then
                counter4 <= counter4 + 1 ;                
            end if ;
        end if;
    end process;

    process( clk , clear )
    begin
        if( clear = '1' ) then
            counter5 <= "0000";
        elsif clk'event and clk = '1' then
            if in5(1) = '1' then
                counter5 <= counter5 - 1 ;
            elsif in5(0) = '1' then
                counter5 <= counter5 + 1 ;                
            end if ;
        end if;
    end process;

    process( clk )
    begin
        if ( clk'event and clk = '1' ) then
            if( VN2CN_en = '1' and Iterations = "00000") then
                VN2CN0_reg <= signed(LLR);
                VN2CN1_reg <= signed(LLR);
                VN2CN2_reg <= signed(LLR);
                VN2CN3_reg <= signed(LLR);
                VN2CN4_reg <= signed(LLR);
                VN2CN5_reg <= signed(LLR);
            else    
                VN2CN0_reg <= VN2CN0;
                VN2CN1_reg <= VN2CN1;
                VN2CN2_reg <= VN2CN2;
                VN2CN3_reg <= VN2CN3;
                VN2CN4_reg <= VN2CN4;
                VN2CN5_reg <= VN2CN5;
                --CodewordValid <= '1';
            end if;
        end if;
    end process;
    codeword <= VN2CN_sum(3);

    -----FSM for controling signal----
    -- FSM may be moved to VNUpdate module
    --process( clk , rst_n , DecoderOver )
    --begin
    --    if( rst_n = '0' or DecoderOver = '1' ) then
    --        CurrentS <= idle;
    --    elsif ( clk'event and clk = '1' ) then
    --        case CurrentS is
    --            when idle =>    if New_fram = '1' then
    --                                CurrentS <= S0;
    --                            else
    --                                CurrentS <= idle;
    --                            end if;
    --                            cnt0 <= "000";
    --                            RandomNum2 <= "001";
    --                            clear <= '1';
    --                            Iterations <=
    --            
    --            when S0 =>      if cnt0 = 5 then
    --                                CurrentS <= S1;
    --                            else
    --                                CurrentS <= S0;
    --                            end if;
    --                            cnt0 <= cnt0 + 1 ;
    --                            clear <= '0';
    --            
    --            when S1 =>      CurrentS <= idle;
    --                            clear <= '1';

    end architecture;                                      
                             




  
            
            