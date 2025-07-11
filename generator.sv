class generator;
	
	packet ref_pkt;
	packet gen_pkt;
	mailbox#(packet) mbx;
	int total_gen_pkts;
	int current_pkt_id;
	function new(mailbox #(packet) ref_mbx,int total_no_packets);
		this.mbx = ref_mbx;
		this.total_gen_pkts = total_no_packets;
		this.ref_pkt = new;
	endfunction
	
	
	task run();
		current_pkt_id = 0;
		
		gen_pkt = new;
		gen_pkt.pkt_kind = RESET;
		gen_pkt.reset_cycles = 2;
		$display("[Generator] Reset Packet generated at time : %0t",$time);
		mbx.put(gen_pkt);
		
		repeat(total_gen_pkts) begin
		
			current_pkt_id++;
			gen_pkt = new();
			void'(ref_pkt.randomize());
			gen_pkt.copy(ref_pkt);
			gen_pkt.pkt_kind = STIMULUS;
			gen_pkt.pack();
			mbx.put(gen_pkt);
			$display("[Generator] Packet '%0d' is generated at time : (%0t)",current_pkt_id,$time);
			
		end
	endtask
	
	function void result();
		$display("[Generator] The total no. generated packets are %0d",current_pkt_id);
	endfunction
	
endclass