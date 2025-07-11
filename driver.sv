class driver;

	packet cap_pkt;
	mailbox#(packet) mbx;
	int current_pkt_id;
	int total_pkts;
	
	virtual router_if.modport_tb vif;
	
	function new(mailbox#(packet) ref_mbx,virtual router_if.modport_tb ref_vif, int total_no_packets);
		this.mbx = ref_mbx;
		this.total_pkts = total_no_packets;
		this.vif = ref_vif;
		
	endfunction
	
	task automatic apply_reset(bit [7:0] reset_cycles);
		
		$display("[Driver] The reset is started on DUT at time : %0t",$time);
		vif.reset <= 1;
		repeat(reset_cycles) @(vif.cb);
		vif.reset <= 0;
		$display("[Driver] The reset is completed on DUT at time : %0t",$time);
	
	endtask
	
	task automatic drivePkt();
		wait(vif.cb.busy == 0);
		$display("[Driver] The driving of packet (%0d) started at time : %0t",current_pkt_id,$time);
		@(vif.cb);
		vif.cb.inp_valid <= 1;
		foreach(cap_pkt.inp_stream[i]) begin
			vif.cb.dut_inp <= cap_pkt.inp_stream[i];
			@(vif.cb);
		end	
		vif.cb.inp_valid <= 0;
		
		$display("[Driver] The driving of packet (%0d) Completed at time : %0t",current_pkt_id,$time);
		
	endtask
	
	task automatic drive_pkt_by_kind();
		case(cap_pkt.pkt_kind)
			RESET: apply_reset(cap_pkt.reset_cycles);
			STIMULUS: begin
						drivePkt();
						current_pkt_id++;
						repeat(5) @(vif.cb);
					end
		endcase
	endtask
	
	
	task run();
		current_pkt_id = 1;
		while(1) begin
			mbx.get(cap_pkt);
			drive_pkt_by_kind();
			//if(current_pkt_id == total_pkts) break;
		end
	endtask
	
	function void result();
		$display("[Driver] The total no. drived packets are %0d",current_pkt_id-1);
	endfunction

endclass