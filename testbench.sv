`include "test.sv"
program testbench(input clk,router_if vif);

	//base_test test;
	test1 test;
	
	
	initial begin
		test = new(vif);
		test.run();
	end
	
	
endprogram

