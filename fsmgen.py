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

print "signal out0, out1, out2, out3, out4, out5, out6, out7, out8, out9: bit;\nsignal tr_out0, tr_out1, tr_out2, tr_out3, tr_out4, tr_out5, tr_out6, tr_out7, tr_out8, tr_out9: bit;"
print "type inputs is array (0 to 9) of integer;"
print "signal inp1, inp2, inp3, inp4, inp5, inp6, inp7: inputs;"

print "type states is ("
for j in range(0, 10): print ("capture"+str(j)+",")
for digit in range(0, 10): print "".join(["pcp_trn"+str(digit)+str(k)+", " for k in range(0, 10)])
for digit in range(0, 10): print "".join(["pcp_tst"+str(digit)+str(k)+", " for k in range(0, 11)])

print "\n\nprocess(ctrl) is\nbegin\ncase ctrl is\n"

for j in range(0, 10):
	print "when capture"+str(j)+" =>"

for digit in range(0, 10):
	
	heuristic = [0, 9, 8, 7, 6, 5, 4, 3, 2, 1]
	for z in range(0, len(heuristic)):
		h = heuristic.pop(0)
		print "when pcp_trn"+str(digit)+str(h)+" =>"
		print "\t--TRAIN digit "+ str(h)
		print "\tmode"+str(digit)+" <= '0';"
		for d in range(1, 8): print "\tinp"+str(d)+"("+str(digit)+") <= '"+digits[h][d-1]+"';"
		if h is digit: print "\ttr_out"+str(digit)+" <= '1';"
		else: print "\ttr_out"+str(digit)+" <= '0';"
		if len(heuristic) > 0: print "\tctrl <= pcp_trn"+str(digit)+str(heuristic[0])+"' after 1 ns;\n"
		else: print "\tctrl <= pcp_tst"+str(digit)+"0 after 1 ns;\n"
	
	print "when pcp_tst"+str(digit)+"0 =>"
	for d in range(1, 8): print "\tinp"+str(d)+"("+str(digit)+") <= '"+digits[0][d-1]+"';"		
	print "\tmode <= '0';\n\tctrl <= pcp_tst"+str(digit)+"1 after 1 ns;"

	for z in range(1, 10):
		print "when pcp_tst"+str(digit)+str(z)+" =>"
		print "\t--TEST digit "+ str(digit)
		for d in range(1, 8): print "\tinp"+str(d)+"("+str(digit)+") <= '"+digits[z][d-1]+"';"
		print "\tmode <= '0';"
		if z is digit + 1: print "\tif out"+str(digit)+" = '0' then"
		else: print "\tif out"+str(digit)+" = '1' then"
		print "\t\tctrl <= pcp_trn"+str(digit)+str(z-1)+"after 1 ns;"
		print "\telse"
		if z < 10: print "\t\tctrl <= pcp_tst"+str(digit)+str(z + 1)+"after 1 ns";
		else: print "\t\tctrl <= pcp_trn"+str(digit+1)+"0 after 1 ns;"

print "\tend case;\nend process;"