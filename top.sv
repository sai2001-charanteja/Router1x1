module top;

	reg clk;
	
	router_if rif_inst(clk);
	//initalize clock
	initial clk =0;
	always #5 clk = !clk;

	testbench tb(clk,rif_inst);
	
	router_dut router_dut_inst(clk,rif_inst.reset,rif_inst.dut_inp,rif_inst.inp_valid,rif_inst.dut_outp,rif_inst.outp_valid,rif_inst.busy,rif_inst.error);
	
endmodule