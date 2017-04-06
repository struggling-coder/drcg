#Flying Spaghetti Monster generator

heuristic = [0, 9, 8, 7, 6, 5, 4, 3, 2, 1]

digits=[
"1110111", #0
"0010010", #1
"1011101", #2
"1011011", #3
"0111010", #4
"1101011", #5
"1101111", #6
"1010010", #7
"1111111", #8
"1111011"  #9
]

print """
library ieee;
use ieee.std_logic_1164.all;

entity layer is
port (sclk, clk: in std_logic;
dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in std_logic; 
disp: out string(1 to 10):="CAPTURE 0 ";
led : out std_logic_vector (7 downto 1));
end entity layer;
"""
#ctrl:inout integer range -10 to 300;

print """architecture assembly of layer is\n"""

print "signal mode0, mode1, mode2, mode3, mode4, mode5, mode6, mode7, mode8, mode9: std_logic;"
print "signal tr_out0, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9: std_logic;"
print "type inputs is array (0 to 9) of std_logic;"
print "signal inp1, inp2, inp3, inp4, inp5, inp6, inp7: inputs;"
print "signal inp1_1, inp2_1, inp3_1, inp4_1, inp5_1, inp6_1, inp7_1: inputs;"
print "signal inp1_2, inp2_2, inp3_2, inp4_2, inp5_2, inp6_2, inp7_2: inputs;"
print "signal data1, data2, data3, data4, data5, data6, data7: inputs;\n"
print "signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9: std_logic;"
print "signal done: std_logic:= '0';"
print "signal disp1, disp2: string(1 to 10);"
#print "constant cfast: integer:= 50000;"
#print "constant cslow: integer:= 750000;"
print "signal ctrl: integer range -1 to 300:= -1;"
print "signal fctrl: integer range -1 to 13:=-1;"

print """
component perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in std_logic;
		output: out std_logic);
end component;
"""

print "\nbegin\n"

for digit in range(0,10): 
	print "neuron"+str(digit)+": perceptron port map(inp1("+str(digit)+"), inp2("+str(digit)+"), inp3("+str(digit)+"), inp4("+str(digit)+"), inp5("+str(digit)+"), inp6("+str(digit)+"), inp7("+str(digit)+"), tr_out"+str(digit)+", mode"+str(digit)+", out"+str(digit)+");"


print """
process(sclk)
begin
	if fctrl /= 10 then
		disp <= disp1;
	else
		disp <= disp2;
	end if;
end process;
"""

print """
process(clk)
begin
	if fctrl < 10 then 
"""
for d in range(1, 8): print "\t\tinp"+str(d)+"<= inp"+str(d)+"_2;"
print """
	else
"""
for d in range(1, 8): print "\t\tinp"+str(d)+"<= inp"+str(d)+"_1;"
print "\tend if;\nend process;"

print "\n\tcaptureFSM: process(sclk) is\n\tbegin\n\tif rising_edge(sclk) then\n\tcase fctrl is \n\t\twhen -1=>\n\t\t\tdisp1 <= \"CAPTURE 0 \";\n\t\t\tfctrl <= 0;"

for digit in range(0, 10):
	print "\twhen "+str(digit)+" =>"
	for d in range(1, 8): 
		print "\t\t\tdata"+str(d)+"("+str(digit)+") <= dpin"+str(d)+";"
		
	#print "\t\t\tchar <= \""+str(digit)+"\";"
	if digit < 9: 
		print "\t\t\tdisp1 <= \"CAPTURE "+str(digit+1)+" \";"
		print "\t\t\tfctrl <= "+str(digit + 1)+";\n"
	else:
		print "\t\t\tdisp1 <= \"LETS DO IT\";" 
		print "\t\t\tdone <= '1';\n\t\t\tfctrl <= 10;"
	#print "\t\t\tcount := 1;"
	#print "\tcount := count + 1;\n"

print """when 10 =>
	fctrl <= 11;
	when 11 => 
"""
for d in range (1,8): print "\t\tled("+str(d)+") <= " + "data"+str(d)+"("+str(5)+");"
print "\t\tfctrl <= 12;"
print "\t\twhen 12 => "
for digit in range(0, 10):
	for d in range(1, 8): print "\t\t\tinp"+str(d)+"_1("+str(digit)+") <= " + "dpin"+str(d)+";"
print "\t\t\tfctrl <= 13;"
print "\t\twhen 13 => "
for digit in range(0, 10):
	#if u is 0: print "\t\t\tif out"+str(digit)+" = '1' then"
	#else: print "\t\t\telsif out"+str(digit)+" = '1' then"
	print "\t\t\tif out"+str(digit)+" = '1' then"
	print "\t\t\t\tdisp1("+str(digit + 1)+") <= '1';"
	print "\t\t\telse"
	print "\t\t\t\tdisp1("+str(digit + 1)+") <= '0';"
	print "end if;"
	
print "end case;\n\tend if;\n\tend process;"

print "\n\tFSM: process(clk) is\n\tbegin\n\tif done='1' then\n\tcase ctrl is\n\n\t\twhen -1=>\n\t\t\tdisp2 <= \"WHAT THE F\";\n\t\t\tctrl <= 0;"

for digit in range(0, 10):
	for h in range(0, 10):
		print "\twhen "+str((digit*10) + h)+" =>"
		print "\t\t--TRAIN digit "+ str(h)
		#print "\t\tif count = cfast then"
		print "\t\t\tmode"+str(digit)+" <= '1';"
		for d in range(1, 8): 
			print "\t\t\tinp"+str(d)+"_2("+str(digit)+") <= " + "data"+str(d)+"("+str(h)+");"
		if h is digit: print "\t\t\ttr_out"+str(digit)+" <= '1';"
		else: print "\t\t\ttr_out"+str(digit)+" <= '0';"
		if h < 9: print "\t\t\tctrl <= "+str(digit*10 + (h+1))+";"
		else: print "\t\t\tctrl <= "+str(digit*10 + h + 100)+";"
		#print "\t\t\tcount := 1;"
		print "\t\t\tdisp2 <= \"TRAIN "+str(digit)+"   \";"
		#print "\t\tend if;"
		#print "\tcount := count + 1;\n"

	for z in range(0, 10):
		print "\twhen "+str(digit*10 + 100 + z)+" =>"
		#print "\t\tif clk = '1' then"
		print "\t\t--TEST digit "+ str(z)
		for d in range(1, 8): print "\t\tinp"+str(d)+"_2("+str(digit)+") <= " + "data"+str(d)+"("+str(z)+");"
		print "\t\tmode"+str(digit)+" <= '0';"
		print "\t\tctrl <= "+str(digit*10 + 200 + z)+";"	
		#print "\t\t\tcount := 1;"
		print "\t\t\tdisp2 <= \"TEST "+str(digit)+"    \";"
		#print "\t\tend if;"
		#print "\tcount := count + 1;\n"
		
		if z < 9:
			print "\twhen "+str(digit*10 + 200 + z)+" =>"
			#print "\t\tif clk = '1' then"
			if z is digit: print "\t\tif out"+str(digit)+" = '0' then"
			else: print "\t\tif out"+str(digit)+" = '1' then"
			print "\t\t\tctrl <= "+str(digit* 10 + z)+";"
			print "\t\telse"
			print "\t\t\tctrl <= "+str(digit* 10 + 100 + z + 1)+";"
			print "\t\tend if;"
			#print "\t\t\tcount := 1;"
			print "\t\t\tdisp2 <= \"TEST  "+str(digit)+"   \";"
			#print "\t\tend if;"
			#print "\tcount := count + 1;\n"
		
		else:
			print "\twhen "+str(digit*10 + 200 + 9)+" => \n\t\t--TEST digit "+str(digit)
			#print "\t\tif clk = '1' then"
			if 9 is digit: print "\t\tif out"+str(digit)+" = '0' then"
			else: print "\t\tif out"+str(digit)+" = '1' then"
			print "\t\t\tctrl <= "+str(digit*10+9)+";"
			print "\t\telse"
			if digit < 9: print "\t\t\tctrl <= "+str(10*(digit+1))+";"
			else: print "\t\t\tctrl <= 300;"
			print "\t\tend if;"
			#print "\t\t\tcount := 1;"
			print "\t\t\tdisp2 <= \"TEST  "+str(digit)+"   \";"
			#print "\t\tend if;"
			#print "\tcount := count + 1;\n"

#for d in range(1, 8): print "\t\tled"+str(d)+" <= '1';"
print "when others => \n\tend case;\n\tend if;\n\tend process;\n"

print "\nend architecture assembly;"#"\tend case;\nend process;\nend architecture assembly;"