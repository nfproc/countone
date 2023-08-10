-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2021.1 (64-bit)
-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity countone_countone_Pipeline_VITIS_LOOP_65_2_char2letter_V is 
    generic(
             DataWidth     : integer := 3; 
             AddressWidth     : integer := 8; 
             AddressRange    : integer := 256
    ); 
    port (
          address0      : in std_logic_vector(AddressWidth-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DataWidth-1 downto 0);
          reset     : in std_logic;
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of countone_countone_Pipeline_VITIS_LOOP_65_2_char2letter_V is 

signal address0_tmp : std_logic_vector(AddressWidth-1 downto 0); 
type mem_array is array (0 to AddressRange-1) of std_logic_vector (DataWidth-1 downto 0); 
signal mem : mem_array := (
    0 to 6=> "000", 7 => "010", 8 to 10=> "000", 11 => "010", 12 => "000", 13 to 14=> "010", 
    15 => "100", 16 to 18=> "000", 19 => "010", 20 => "000", 21 to 22=> "010", 23 => "100", 
    24 => "000", 25 to 26=> "010", 27 => "100", 28 => "010", 29 to 30=> "100", 31 => "011", 
    32 to 34=> "000", 35 => "010", 36 => "000", 37 to 38=> "010", 39 => "100", 40 => "000", 
    41 to 42=> "010", 43 => "100", 44 => "010", 45 to 46=> "100", 47 => "011", 48 => "000", 
    49 to 50=> "010", 51 => "100", 52 => "010", 53 to 54=> "100", 55 => "011", 56 => "010", 
    57 to 58=> "100", 59 => "011", 60 => "100", 61 to 62=> "011", 63 => "001", 64 to 66=> "000", 
    67 => "010", 68 => "000", 69 to 70=> "010", 71 => "100", 72 => "000", 73 to 74=> "010", 
    75 => "100", 76 => "010", 77 to 78=> "100", 79 => "011", 80 => "000", 81 to 82=> "010", 
    83 => "100", 84 => "010", 85 to 86=> "100", 87 => "011", 88 => "010", 89 to 90=> "100", 
    91 => "011", 92 => "100", 93 to 94=> "011", 95 => "001", 96 => "000", 97 to 98=> "010", 
    99 => "100", 100 => "010", 101 to 102=> "100", 103 => "011", 104 => "010", 105 to 106=> "100", 
    107 => "011", 108 => "100", 109 to 110=> "011", 111 => "001", 112 => "010", 113 to 114=> "100", 
    115 => "011", 116 => "100", 117 to 118=> "011", 119 => "001", 120 => "100", 121 to 122=> "011", 
    123 => "001", 124 => "011", 125 to 127=> "001", 128 to 130=> "000", 131 => "010", 132 => "000", 
    133 to 134=> "010", 135 => "100", 136 => "000", 137 to 138=> "010", 139 => "100", 140 => "010", 
    141 to 142=> "100", 143 => "011", 144 => "000", 145 to 146=> "010", 147 => "100", 148 => "010", 
    149 to 150=> "100", 151 => "011", 152 => "010", 153 to 154=> "100", 155 => "011", 156 => "100", 
    157 to 158=> "011", 159 => "001", 160 => "000", 161 to 162=> "010", 163 => "100", 164 => "010", 
    165 to 166=> "100", 167 => "011", 168 => "010", 169 to 170=> "100", 171 => "011", 172 => "100", 
    173 to 174=> "011", 175 => "001", 176 => "010", 177 to 178=> "100", 179 => "011", 180 => "100", 
    181 to 182=> "011", 183 => "001", 184 => "100", 185 to 186=> "011", 187 => "001", 188 => "011", 
    189 to 191=> "001", 192 => "000", 193 to 194=> "010", 195 => "100", 196 => "010", 197 to 198=> "100", 
    199 => "011", 200 => "010", 201 to 202=> "100", 203 => "011", 204 => "100", 205 to 206=> "011", 
    207 => "001", 208 => "010", 209 to 210=> "100", 211 => "011", 212 => "100", 213 to 214=> "011", 
    215 => "001", 216 => "100", 217 to 218=> "011", 219 => "001", 220 => "011", 221 to 223=> "001", 
    224 => "010", 225 to 226=> "100", 227 => "011", 228 => "100", 229 to 230=> "011", 231 => "001", 
    232 => "100", 233 to 234=> "011", 235 => "001", 236 => "011", 237 to 239=> "001", 240 => "100", 
    241 to 242=> "011", 243 => "001", 244 => "011", 245 to 247=> "001", 248 => "011", 249 to 255=> "001" );


begin 


memory_access_guard_0: process (address0) 
begin
      address0_tmp <= address0;
--synthesis translate_off
      if (CONV_INTEGER(address0) > AddressRange-1) then
           address0_tmp <= (others => '0');
      else 
           address0_tmp <= address0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(address0_tmp)); 
        end if;
    end if;
end process;

end rtl;

