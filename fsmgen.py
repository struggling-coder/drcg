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
entity final is
port (dpin1, dpin2, dpin3, dpin4, dpin5, dpin6, dpin7: in bit)
end entity final;
"""

print """architecture assembly of final is\n"""
print "signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9: bit;"
print "signal tr_out0, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9: bit;"
print "type inputs is array (0 to 9) of integer;"
print "signal inp1, inp2, inp3, inp4, inp5, inp6, inp7: inputs;"
print "signal data1, data2, data3, data4, data5, data6, data7: inputs;\n"

print "type states is ("
print "".join(["capture"+str(j)+"," for j in range(0, 10)])
for digit in range(0, 10): print "".join(["pcp_trn"+str(digit)+str(k)+", " for k in range(0, 10)])
for digit in range(0, 10): print "".join(["pcp_tst"+str(digit)+str(k)+", " for k in range(0, 11)])
print "ready0, ready1, ready2);"

print "\nbegin"

print "\n\tprocess(ctrl) is\n\tbegin\n\tcase ctrl is\n"

for digit in range(0, 10):
	print "when capture"+str(digit)+" =>"
	for d in range(1, 8): print "\t\tdata"+str(d)+"("+str(digit)+") <= '"+digits[digit][d-1]+"';"
		
for digit in range(0, 10):
	
	heuristic = [0, 9, 8, 7, 6, 5, 4, 3, 2, 1]
	for z in range(0, len(heuristic)):
		h = heuristic.pop(0)
		print "\twhen pcp_trn"+str(digit)+str(h)+" =>"
		print "\t\t--TRAIN digit "+ str(h)
		print "\t\tmode"+str(digit)+" <= '0';"
		for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(h)+");"
		if h is digit: print "\t\ttr_out"+str(digit)+" <= '1';"
		else: print "\t\ttr_out"+str(digit)+" <= '0';"
		if len(heuristic) > 0: print "\t\tctrl <= pcp_trn"+str(digit)+str(heuristic[0])+"' after 1 ns;\n"
		else: print "\t\tctrl <= pcp_tst"+str(digit)+"0 after 1 ns;\n"
	
	print "\twhen pcp_tst"+str(digit)+"0 =>"
	for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(0)+");"	
	print "\t\tmode <= '0';\n\t\tctrl <= pcp_tst"+str(digit)+"1 after 1 ns;\n"

	for z in range(1, 10):
		print "\twhen pcp_tst"+str(digit)+str(z)+" =>"
		print "\t\t--TEST digit "+ str(digit)
		for d in range(1, 8): print "\t\tinp"+str(d)+"("+str(digit)+") <= " + "data"+str(d)+"("+str(z)+");"
		print "\t\tmode <= '0';"
		if z is digit + 1: print "\t\tif out"+str(digit)+" = '0' then"
		else: print "\t\tif out"+str(digit)+" = '1' then"
		print "\t\t\tctrl <= pcp_trn"+str(digit)+str(z-1)+" after 1 ns;"
		print "\t\telse"
		print "\t\t\tctrl <= pcp_tst"+str(digit)+str(z + 1)+" after 1 ns;\n"
	print "\twhen pcp_tst"+str(digit)+"10 => \n\t\t--TEST digit "+str(digit)
	if 10 is digit + 1: print "\t\tif out"+str(digit)+" = '0' then"
	else: print "\t\tif out"+str(digit)+" = '1' then"
	print "\t\t\tctrl <= pcp_trn"+str(digit)+str(9)+" after 1 ns;"
	print "\t\telse"
	print "\t\t\tctrl <= pcp_tst"+str(digit+1)+str(0)+" after 1 ns;\n"

print "\tend case;\nend process;"
