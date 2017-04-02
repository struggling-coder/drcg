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
dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit; 
disp: out string(1 to 10));
end entity layer;
"""
#ctrl:inout integer range -10 to 300;

print """architecture assembly of layer is\n"""

print "signal mode0, mode1, mode2, mode3, mode4, mode5, mode6, mode7, mode8, mode9: bit;"
print "signal tr_out0, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9: bit;"
print "type inputs is array (0 to 9) of bit;"
print "signal inp1, inp2, inp3, inp4, inp5, inp6, inp7: inputs;"
print "shared variable data1, data2, data3, data4, data5, data6, data7: inputs;\n"
print "signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9: bit;"
print "shared variable parity: bit:= '0';"
#print "constant cfast: integer:= 50000;"
#print "constant cslow: integer:= 750000;"
print "signal ctrl: integer range -11 to 300:= -11;"

print """
component perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in bit;
		output: out bit);
end component;
"""

print "\nbegin"

for digit in range(0,10): 
	print "neuron"+str(digit)+": perceptron port map(inp1("+str(digit)+"), inp2("+str(digit)+"), inp3("+str(digit)+"), inp4("+str(digit)+"), inp5("+str(digit)+"), inp6("+str(digit)+"), inp7("+str(digit)+"), tr_out"+str(digit)+", mode"+str(digit)+", out"+str(digit)+");"

print """pUpdate: process(sclk) 
begin
parity := not parity;
end process;
"""

print "\n\tFSM: process(clk) is\n\tbegin\n\t\n\tcase ctrl is\n\n\t\twhen -11=>\n\t\t\tdisp <= \"CAPTURE  0\";\n\t\t\tctrl <= -10;"

for digit in range(0, 10):
	print "\twhen "+str(digit-10)+" =>"
	print "\t\tif parity = '1' and clk = '1' then"	
	for d in range(1, 8): print "\t\t\tdata"+str(d)+"("+str(digit)+") := dpin"+str(d)+";"
	#print "\t\t\tchar <= \""+str(digit)+"\";"
	if digit < 9: 
		print "\t\t\tdisp <= \"CAPTURE "+str(digit+1)+" \";"
		print "\t\t\tctrl <= "+str(digit -9)+";\n"
	else:
		print "\t\t\tdisp <= \"LETS DO IT\";" 
		print "\t\t\tctrl <= 0;\n"
	#print "\t\t\tcount := 1;"
	print "\t\tend if;"
	#print "\tcount := count + 1;\n"

for digit in range(0, 10):
	for h in range(0, 10):
		print "\twhen "+str((digit*10) + h)+" =>"
		print "\t\t--TRAIN digit "+ str(h)
		#print "\t\tif count = cfast then"
		print "\t\t\tmode"+str(digit)+" <= '1';"
		for d in range(1, 8): print "\t\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(h)+");"
		if h is digit: print "\t\t\ttr_out"+str(digit)+" <= '1';"
		else: print "\t\t\ttr_out"+str(digit)+" <= '0';"
		if h < 9: print "\t\t\tctrl <= "+str(digit*10 + (h+1))+";"
		else: print "\t\t\tctrl <= "+str(digit*10 + h + 100)+";"
		#print "\t\t\tcount := 1;"
		print "\t\t\tdisp <= \"TRAIN "+str(digit)+"   \";"
		#print "\t\tend if;"
		#print "\tcount := count + 1;\n"

	for z in range(0, 10):
		print "\twhen "+str(digit*10 + 100 + z)+" =>"
		#print "\t\tif clk = '1' then"
		print "\t\t--TEST digit "+ str(z)
		for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(z)+");"
		print "\t\tmode"+str(digit)+" <= '0';"
		print "\t\tctrl <= "+str(digit*10 + 200 + z)+";"	
		#print "\t\t\tcount := 1;"
		print "\t\t\tdisp <= \"TEST "+str(digit)+"    \";"
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
			print "\t\t\tdisp <= \"TEST  "+str(digit)+"   \";"
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
			print "\t\t\tdisp <= \"TEST  "+str(digit)+"   \";"
			#print "\t\tend if;"
			#print "\tcount := count + 1;\n"

print "\twhen 300 => \n --WHATEVER"
#for d in range(1, 8): print "\t\tled"+str(d)+" <= '1';"
print "\t\tdisp <= \"INPUT PLS \";"
print "when others => \n\tend case;\n\tend process;\n"

print "\nend architecture assembly;"#"\tend case;\nend process;\nend architecture assembly;"