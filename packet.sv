typedef enum {IDLE,RESET,STIMULUS} pkt_type;
class packet;

	rand bit [7:0] sa;
	rand bit [7:0] da;
	bit [31:0] len;
	bit [31:0] crc;
	rand bit [7:0] payload[]; // Dynamic Array
	
	pkt_type pkt_kind;
	bit [7:0] reset_cycles;
	bit [7:0] inp_stream[$];
	
	extern constraint C1;
	
	extern function void copy(packet pkt);
	extern function bit compare(packet pkt);
	extern function void pack();
	extern function void unpack(ref bit [7:0]queue[$]);
	extern function void post_randomize();
	extern function void print();
	
	
endclass

constraint packet::C1{
	
	sa inside {[1:4]};
	da inside {[1:4]};
	payload.size() inside {[2:10]};
	
	foreach(payload[i]){
		 payload[i] inside {[0:$]};
	}
};

function void packet::copy(packet pkt);
	this.sa = pkt.sa;
	this.da = pkt.da;
	this.len = pkt.len;
	this.crc = pkt.crc;
	this.payload = pkt.payload;
	this.pkt_kind = pkt.pkt_kind;
	this.reset_cycles = pkt.reset_cycles;
endfunction

function bit packet::compare(packet pkt);
	compare = (this.sa == pkt.sa) && (this.da==pkt.da) && (this.len == pkt.len) && (this.crc == pkt.crc) && (this.payload == pkt.payload);
endfunction

function void packet::pack();
	inp_stream = {<< 8 {this.payload,this.crc,this.len,this.da,this.sa}};
endfunction

function void packet::unpack(ref bit [7:0]queue[$]);
	{<< 8 {this.payload,this.crc,this.len,this.da,this.sa}} = queue;
endfunction

function void packet::post_randomize();
	len  = 1+1+4+4+ this.payload.size();
	crc = payload.sum();
endfunction

function void packet::print();
	$write("sa : %0d, da : %0d , len : %0d, crc : %0d, Payload : ",this.sa,this.da,this.len,this.crc);
	foreach(this.payload[i]) $write("%0d ",this.payload[i]);
	$display();
endfunction



class new_packet extends packet;

	constraint C1{
		sa inside {[4:$]};
		da inside {[4:$]};
		payload.size() inside {[2:100]};
		
		foreach(payload[i]){
			 payload[i] inside {[3:$]};
		}
	
	}
	
endclass