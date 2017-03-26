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
entity layer is
port (clk, dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit; 
led0, led1, led2, led3, led4, led5, led6, led7: inout bit);
end entity layer;
"""

print """architecture assembly of layer is\n"""
print "signal mode0, mode1, mode2, mode3, mode4, mode5, mode6, mode7, mode8, mode9: bit;"
print "signal tr_out0, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9: bit;"
print "type inputs is array (0 to 9) of bit;"
print "signal inp1, inp2, inp3, inp4, inp5, inp6, inp7: inputs;"
print "signal data1, data2, data3, data4, data5, data6, data7: inputs;\n"
print "signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9: bit;"
print "signal fclk, sclk: bit;"
print "signal count: bit:= 0;"
print "constant cfast: integer:= 50000;"
print "constant cslow: integer:= 750000000;"

print "type states is ("
print "".join(["capture"+str(j)+", " for j in range(0, 10)])
for digit in range(0, 10): print "".join(["pcp_trn"+str(digit)+str(k)+", " for k in range(0, 10)])
for digit in range(0, 10): print "".join(["pcp_tst"+str(digit)+str(k)+", " for k in range(0, 10)])
for digit in range(0, 10): print "".join(["pcp_tsth"+str(digit)+str(k)+", " for k in range(0, 10)])
print "pcp_trn100);"
print "signal ctrl: states:= capture0;"

print """
component perceptron is
port (in1, in2, in3, in4, in5, in6, in7, tr_out, mode: in bit;
		output: out bit);
end component;
"""

print "\nbegin"

for digit in range(0,10): 
	print "neuron"+str(digit)+": perceptron port map(inp1("+str(digit)+"), inp2("+str(digit)+"), inp3("+str(digit)+"), inp4("+str(digit)+"), inp5("+str(digit)+"), inp6("+str(digit)+"), inp7("+str(digit)+"), tr_out"+str(digit)+", mode"+str(digit)+", out"+str(digit)+");"

print "\n\tcaptureFSM: process(sclk) is\n\tbegin\n\tcase ctrl is\n"

for digit in range(0, 10):
	print "\twhen capture"+str(digit)+" =>"
	for d in range(1, 8): print "\t\tdata"+str(d)+"("+str(digit)+") <= dpin"+str(d)+";"
	for d in range(1, 8): print "\t\tled"+str(d)+" <= dpin"+str(d)+";"
	print "\t\tled0 <= not led0;"
	if digit < 9: print "\t\tctrl <= capture"+str(digit + 1)+";\n"
	else: print "\t\tctrl <= pcp_trn00;\n"

print "\twhen others => \n\tend case;"
print "\n\tend process;"

print "\n\tprocessFSM: process(fclk) is\n\tbegin\n\tcase ctrl is\n"

for digit in range(0, 10):
	
	for h in range(0, 10):
		print "\twhen pcp_trn"+str(digit)+str(h)+" =>"
		print "\t\t--TRAIN digit "+ str(h)
		print "\t\tmode"+str(digit)+" <= '1';"
		for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(h)+");"
		if h is digit: print "\t\ttr_out"+str(digit)+" <= '1';"
		else: print "\t\ttr_out"+str(digit)+" <= '0';"
		if h < 9: print "\t\tctrl <= pcp_trn"+str(digit)+str(h+1)+";\n"
		else: print "\t\tctrl <= pcp_tst"+str(digit)+"0;\n"
		
#	print "\twhen pcp_tst"+str(digit)+"0 =>"
#	for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(0)+");"	#
#	print "\t\tmode"+str(digit)+" <= '0';\n\t\tctrl <= pcp_tsth"+str(digit)+"0 after 10 ms;\n"

	for z in range(0, 10):
		print "\twhen pcp_tst"+str(digit)+str(z)+" =>"
		print "\t\t--TEST digit "+ str(z)
		for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(z)+");"
		print "\t\tmode"+str(digit)+" <= '0';"
		print "\t\tctrl <= pcp_tsth"+str(digit)+str(z)+";\n"	

		if z < 9:
			print "\twhen pcp_tsth"+str(digit)+str(z)+" =>"
			if z is digit: print "\t\tif out"+str(digit)+" = '0' then"
			else: print "\t\tif out"+str(digit)+" = '1' then"
			print "\t\t\tctrl <= pcp_trn"+str(digit)+str(z)+";"
			print "\t\telse"
			print "\t\t\tctrl <= pcp_tst"+str(digit)+str(z + 1)+";"
			print "\t\tend if;\n"

		else:
			print "\twhen pcp_tsth"+str(digit)+"9 => \n\t\t--TEST digit "+str(digit)
			if 9 is digit: print "\t\tif out"+str(digit)+" = '0' then"
			else: print "\t\tif out"+str(digit)+" = '1' then"
			print "\t\t\tctrl <= pcp_trn"+str(digit)+"9;"
			print "\t\telse"
			print "\t\t\tctrl <= pcp_trn"+str(digit+1)+str(0)+";"
			print "\t\tend if;\n"

print "\twhen pcp_trn100 => \n --WHATEVER"
for d in range(1, 8): print "\t\tled"+str(d)+" <= '1';"
print "when others => \n\tend case;\n\tend process;\n"

print "\tmclock: process(clk) is\n\tbegin"
print """\tif clk='1' and clk'event then
		if count mod cslow = 0 then
			sclk <= not sclk;
		end if;
		if count mod cfast = 0 then
			fclk <= not fclk;
		end if;
		count <= count + 1;
"""
print "\tend if;\nend process;\nend architecture assembly;"#"\tend case;\nend process;\nend architecture assembly;"
