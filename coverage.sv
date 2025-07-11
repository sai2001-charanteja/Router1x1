class coverage;

	packet pkt;
	mailbox#(packet) mbx;
	real coverage_score;
	
	covergroup fcov with function sample(packet pkt);
	
	coverpoint pkt.sa{
		bins sa1 ={1};
		bins sa2 ={2};
		bins sa3 ={3};
		bins sa4 ={4};
	}
	coverpoint pkt.da{
		bins da1 ={1};
		bins da2 ={2};
		bins da3 ={3};
		bins da4 ={4};
	}
	
	coverpoint pkt.len{
		bins length_small = {[10:50]};
		bins length_short = {[50:100]};
		bins length_medium = {[100:500]};
		bins length_long = {[500:700]};
		bins length_verylong = {[700:1000]};
	}
	
	cross pkt.sa,pkt.da;
	
	cross pkt.sa,pkt.len;
	cross pkt.da,pkt.len;
	
	endgroup
	
	function new(mailbox#(packet) mbx);
	
		fcov = new;
		this.mbx = mbx;
	endfunction
	
	task run();
		while(1) begin
			@(mbx.num);
			mbx.peek(pkt);
			
			fcov.sample(pkt);
			
			coverage_score = fcov.get_coverage();
			$display("[Coverage] Coverage Score : %0f",coverage_score);
		end
	endtask
	
	function void result();
		
		$display("\n******************************************");
		$display("*****[Coverage] COverage Score : %0f********",coverage_score);
		$display("******************************************");
	
	endfunction
	
endclass