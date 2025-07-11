`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "imonitor.sv"
`include "omonitor.sv"
`include "scoreboard.sv"
`include "coverage.sv"
class environment;
	
	virtual router_if vif;
	virtual router_if.modport_mon ivif;
	virtual router_if.modport_mon ovif;
	int total_no_packets;
	
	generator gen;
	driver drive;
	imonitor imon;
	omonitor omon;
	scoreboard scb;
	coverage cov;
	
	mailbox#(packet) mbx;
	mailbox#(packet) imbx;
	mailbox#(packet) ombx;


	function new(virtual router_if vif,virtual router_if.modport_mon ivif,virtual router_if.modport_mon ovif,int total_no_packets);
		this.vif = vif;
		this.ivif = ivif;
		this.ovif = ovif;
		this.total_no_packets = total_no_packets;
	endfunction
	
	function void results();
		gen.result();
		drive.result();
		imon.result();
		omon.result();
		scb.tempresult();
		scb.result(total_no_packets);
		cov.result();
	endfunction

	function void build();
		$display("[Environment] Build started at time : %0t",$time);
		total_no_packets =5;
		mbx = new(1);
		imbx = new(1);
		ombx = new(1);
		gen = new(mbx,total_no_packets);
		drive = new(mbx,vif,total_no_packets);
		imon = new(imbx,ivif);
		omon = new(ombx,ovif);
		scb = new(imbx,ombx);
		cov = new(imbx);
	endfunction
	
	task run();
		$display("[Environmnet] run started at time : %0t",$time );
		fork
			gen.run();
			drive.run();
			imon.run();
			omon.run();
			scb.run();
			cov.run();
		join_any
		
		wait(scb.total_pkts_recvd == total_no_packets);
		repeat(10) @(vif.cb);
		wait(vif.cb.busy == 0);
		repeat(10) @(vif.cb);
		results();
		repeat(5) @(vif.cb);
		$display("[Environmnet] run Completed at time : %0t",$time );
		$finish;
		
	endtask

endclass