interface router_if(input clk);

	logic reset;
	logic [7:0]dut_inp;
	logic inp_valid;
	logic [7:0]dut_outp;
	logic outp_valid;
	logic busy;
	logic [3:0] error;

	clocking cb @(posedge clk);
		output dut_inp,inp_valid; 
		input dut_outp,outp_valid,busy,error;
	endclocking
	
	clocking cbMon @(posedge clk);
		input inp_valid,dut_inp;
		input dut_outp,outp_valid,busy,error;
	endclocking

	modport modport_tb(output reset, clocking cb);
	modport modport_mon(clocking cbMon);

endinterface