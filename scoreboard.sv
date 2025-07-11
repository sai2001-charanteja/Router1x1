class scoreboard;

	mailbox#(packet) imbx,ombx;
	packet i_pkt,o_pkt;
	
	int total_pkts_recvd;
	int matched, misMatched;
	
	function new(mailbox#(packet) ref_imbx,ref_ombx);
		this.imbx = ref_imbx;
		this.ombx = ref_ombx;
	endfunction

	
	task run();
		total_pkts_recvd =0;
		matched  = 0;
		misMatched = 0;
		while(1) begin
			imbx.peek(i_pkt);
			ombx.get(o_pkt);
			
			total_pkts_recvd++;
			$display("[Scoreboard] Packet %0d is captured at time :%0t",total_pkts_recvd,$time);
			
			//i_pkt.print();
			//o_pkt.print();
			if(i_pkt.compare(o_pkt)) matched++;
			else misMatched++;
		end
	
	endtask
	
	function void tempresult();
	
		$display("[ScoreBoard] Matched : %0d , MisMatched : %0d",matched,misMatched);
		
	endfunction
	
	function void result(int total_pkts);
		
		$display("\n******************************************");
		$display("[ScoreBoard] Matched : %0d , MisMatched : %0d",matched,misMatched);
		if(matched == total_pkts && misMatched == 0) begin
			$display("**************TEST PASSED*****************");
		end else begin
			$display("**************TEST FAILED*****************");
		end
		$display("******************************************");
		
	endfunction
	
endclass