library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

entity semaforo is
 port ( sensor  : in STD_LOGIC; -- Sensor 
        clk  : in STD_LOGIC; -- clock 
        rst: in STD_LOGIC; -- reset ativo em 0 
        rua_a  : out STD_LOGIC_VECTOR(2 downto 0); 
			rua_b:    out STD_LOGIC_VECTOR(2 downto 0)
   );
end semaforo;
architecture controlador of semaforo is
signal clk_1s: std_logic_vector(27 downto 0):= x"0000000";
signal contador:std_logic_vector(3 downto 0):= b"0000";
signal atr_10s, atr_3sb,atr_3sa, verm_hab, am_hab1,am_hab2: std_logic:='0';
signal clk_1s_hab: std_logic;
type estados is (ab_ruaa, am_ruaa, ab_ruab, am_ruab);
signal agora, depois: estados;

begin 

	Acionamento:process(clk,rst) 
		begin
			if(rst='0') then
			 agora <= ab_ruaa;
			elsif(rising_edge(clk)) then 
			 agora <= depois; 
			end if; 
	end process;
	Controle:process(agora,sensor,atr_3sb,atr_3sa,atr_10s)
		begin
			case agora is 
			when ab_ruaa =>
			 verm_hab <= '0';
			 am_hab1 <= '0';
			 am_hab2 <= '0';
			 rua_a <= "001";
			 rua_b <= "100";
			 if(sensor = '1') then 
			  depois <= am_ruaa; 
			 else 
			  depois <= ab_ruaa; 
			 end if;
			when am_ruaa =>
			 rua_a <= "010";
			 rua_b <= "100";
			 verm_hab <= '0';
			 am_hab1 <= '1';
			 am_hab2 <= '0';
			 if(atr_3sa='1') then  
			  depois <= ab_ruab; 
			 else 
			  depois <= am_ruaa; 
			 end if;
			when ab_ruab => 
			 rua_a <= "100";
			 rua_b <= "001";
			 verm_hab <= '1';
			 am_hab1 <= '0';
			 am_hab2 <= '0';
			 if(atr_10s='1') then
			 
			  depois <= am_ruab;
			 else 
			  depois <= ab_ruab; 
			 end if;
			when am_ruab =>
			 rua_a <= "100";
			 rua_b <= "010"; 
			 verm_hab <= '0'; 
			 am_hab1 <= '0';
			 am_hab2 <= '1';
			 if(atr_3sb='1') then 

			 depois <= ab_ruaa;
			 else 
			 depois <= am_ruab;

			 end if;
			when others => depois <= ab_ruaa;
			end case;
	end process;

	tempo:process(clk)
	begin
	if(rising_edge(clk)) then 
	if(clk_1s_hab='1') then
	 if(verm_hab='1' or am_hab1='1' or am_hab2='1') then
	  contador <= contador + b"01";
	  if((contador = b"1001") and verm_hab ='1') then 
		atr_10s <= '1';
		atr_3sa <= '0';
		atr_3sb <= '0';
		contador <= b"0000";
	  elsif((contador = b"0010") and am_hab1= '1') then
		atr_10s <= '0';
		atr_3sa <= '1';
		atr_3sb <= '0';
		contador <= b"0000";
	  elsif((contador = b"0010") and am_hab2= '1') then
		atr_10s <= '0';
		atr_3sa <= '0';
		atr_3sb <= '1';
		contador <= b"0000";
	  else
		atr_10s <= '0';
		atr_3sa <= '0';
		atr_3sb <= '0';
	  end if;
	 end if;
	 end if;
	end if;
	end process;

	counter:process(clk)
	begin
	if(rising_edge(clk)) then 
	 clk_1s <= clk_1s + b"01";
	 if(clk_1s >= b"11") then 
	  clk_1s <= x"0000000";
	 end if;
	end if;
	end process;
	clk_1s_hab <= '1' when clk_1s = b"11" else '0'; 
end controlador;