class omonitor;
	
	mailbox#(packet) mbx;
	virtual router_if.modport_mon vif;
	
	int pkt_id;
	packet outp_stream[$];
	packet o_pkt;
	bit [7:0] o_streamq[$];
	
	function new(mailbox#(packet) ref_mbx, virtual router_if.modport_mon ref_vif);
		mbx = ref_mbx;
		this.vif = ref_vif;
	endfunction

	task run();
		pkt_id=0;
		while(1) begin
			@(posedge vif.cbMon.outp_valid);
			//@(vif.cbMon);
			while(vif.cbMon.outp_valid) begin
				o_streamq.push_back(vif.cbMon.dut_outp);
				@(vif.cbMon);
				if(!vif.cbMon.outp_valid) break;
			end
			o_pkt = new;
			o_pkt.unpack(o_streamq);
			o_streamq.delete();
			mbx.put(o_pkt);
			
			pkt_id++;
			$display("[OMonitor] Captured packet %0d at time : %0t",pkt_id,$time);
			
		end
		
	endtask
	
	
	function void result();
		$display("[oMonitor] The total captured packets are : %0d",pkt_id);
	endfunction
endclass