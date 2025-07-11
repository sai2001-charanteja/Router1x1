`include "packet.sv"
//program testbench(clk,vif.reset,vif.cb.dut_inp,vif.cb.inp_valid,vif.cb.dut_outp,vif.cb.outp_valid,vif.cb.busy,vif.cb.error);
program testbench(input clk,router_if.tb vif);

	/* input clk;
	output reg vif.reset;
	output reg [7:0]vif.cb.dut_inp;
	output reg vif.cb.inp_valid;
	input [7:0]vif.cb.dut_outp;
	input vif.cb.outp_valid;
	input vif.cb.busy;
	input [3:0] vif.cb.error;
	 */
	default clocking bus @(vif.cb);
	endclocking
	
	int total_no_packets;
	
	packet pkt;
	packet o_pkt;
	
	packet inp_pkts[$];
	packet outp_pkts[$];
	
	int drive_size;
	int sampled_size;
	int matched;
	int missMatched;
	
	bit [7:0] inp_stream[$];
	bit [7:0] outp_stream[$];
	
	
	
	// Apply Reset
	task automatic apply_reset();
		$display("[TB Reset] Applied Reset to DUT");
		vif.reset <= 1;
		//repeat(2) @(vif.cb);
		##2
		vif.reset <= 0;
		$display("[TB Reset] Reset Completed!");
	endtask

	// Driving the stimulus
	task automatic drive(input bit [7:0]inp_queue[$]);
		
		$display("[TB Drive] Driving of Stimuls is started at %0t",$time);
		wait(vif.cb.busy==0);
		//@(vif.cb);
		##1
		vif.cb.inp_valid <= 1;
		foreach(inp_queue[i]) begin
			vif.cb.dut_inp <= inp_queue[i];
			##1;
		end
		
		vif.cb.inp_valid<=0;
		
		$display("[TB Drive] Driving of Stimuls is Completed at %0t",$time);
	
	endtask
	
	function void displayResult(int drive_size,int sampled_size,int matched, int missMatched,bit flag);
		
		$display("Drived Packets = %0d, Sampled Packets = %0d => Matched = %0d & MissMatched = %0d,  Status = %s",drive_size,sampled_size,matched,
		missMatched,
		flag?"PASS":"FAIL"
		);
	
	endfunction

	function void CompareResults();
		
		drive_size = inp_pkts.size;
		sampled_size = outp_pkts.size;
		
		if(drive_size == sampled_size && drive_size == total_no_packets) begin
			matched =0;
			missMatched = 0;
			for(int i=0;i<drive_size;i++) begin
				if(inp_pkts[i].compare(outp_pkts[i])) matched++;
				else missMatched++;
				inp_pkts[i].print();
				outp_pkts[i].print();
			end
			
			if(matched == total_no_packets && missMatched == 0) displayResult(drive_size,sampled_size,matched,missMatched,1'b1);
			else displayResult(drive_size,sampled_size,matched,missMatched,1'b0);
			
		end else begin
			displayResult(drive_size,sampled_size,-1,-1,1'b0);
		end
	
	endfunction

	initial begin
		apply_reset();
		
		total_no_packets =2;
		
		repeat(total_no_packets) begin
			wait(vif.cb.busy == 0);
			pkt = new();
			void'(pkt.randomize());
			pkt.pack(inp_stream);
			
			drive(inp_stream);
			inp_pkts.push_back(pkt);
			
			inp_stream.delete();
			##5;
		end
		
		
		wait(vif.cb.busy ==0);
		##10
		
		CompareResults();
		##5
		$finish;
		
	end
	
	initial begin
	
		while(1) begin
			
			@(posedge vif.cb.outp_valid);
			$display("[TB Output Reading] Capturing Packets Started at %0t",$time);
			//@(vif.cb);
			while(vif.cb.outp_valid) begin
				outp_stream.push_back(vif.cb.dut_outp);
				##1
				if(!vif.cb.outp_valid) break;
			end
			
			o_pkt = new();
			o_pkt.unpack(outp_stream);
			outp_pkts.push_back(o_pkt);
			outp_stream.delete();
			
			$display("[TB Output Reading] Capturing Packets Completed at %0t",$time);
		
		end
		
	end
	
endprogram

