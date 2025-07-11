`include "environment.sv"
class base_test;
	
	environment env;
	
	int total_no_packets;
		
	virtual router_if vif;
	function new(virtual router_if vif);
		this.vif = vif;
		
	endfunction
	
	
	function void build();
		$display("[Test case] Build started at time : %0t",$time);
		total_no_packets = 5;
		env = new(vif,vif,vif,total_no_packets);
		env.build();
		$display("[Test case] Build completed at time : %0t",$time);
		
	endfunction
	
	virtual task run();
		$display("[Testcase] run started at time :%0t",$time);
		build();
		env.run();
	
	endtask
	
endclass



class test1 extends base_test;

	new_packet new_pkt;
	function new(virtual router_if vif);
		super.new(vif);
	endfunction
	
	virtual task run();
		$display("[New Testcase] run started at time :%0t",$time);
		new_pkt = new();
		
		build();
		env.gen.ref_pkt = new_pkt;
		env.run();
		$display("[New Testcase] run completed at time :%0t",$time);
	endtask

endclass