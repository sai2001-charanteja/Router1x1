class imonitor;

	mailbox#(packet) mbx;
	virtual router_if.modport_mon vif;
	
	packet i_pkt;
	
	bit [7:0]i_streamq[$];
	
	int pkt_id;
	
	function new(mailbox#(packet) ref_mbx,virtual router_if.modport_mon ref_vif);
		mbx = ref_mbx;
		vif = ref_vif;
	endfunction
	
	task run();
		pkt_id =0;
		while(1) begin
		
			@(posedge vif.cbMon.inp_valid);
			
			while(vif.cbMon.inp_valid) begin
				i_streamq.push_back(vif.cbMon.dut_inp);
				@(vif.cbMon);
			
			end
			
			i_pkt = new;
			i_pkt.unpack(i_streamq);
			i_streamq.delete();
			mbx.put(i_pkt);
			pkt_id++;
			$display("[iMonitor] Captured packet %0d at time : %0t",pkt_id,$time);
			
			begin
				packet tempPkt;
				#0 while(mbx.num>=1) void'(mbx.try_get(tempPkt)); 
			end
			
				
		end
	
	endtask
		
	function void result();
		$display("[iMonitor] The total captured packets are : %0d",pkt_id);
	endfunction
	
endclass