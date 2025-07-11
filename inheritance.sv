class base;
  
  int a,b,c;
  
  function new(int a,b);
    this.a = a;
    this.b= b;
    c= 10;
    $display("[Base] Constructor here!!!");
  endfunction
  
  
  /*function new();
    a= 1;
    b= 2;
    c= 3;
  endfunction*/ 
  
     function void print();
     $display("[Base] I am a virtual function The value of a = %0d, b = %0d, c = %0d",a,b,c);
  endfunction
  
  function void tempprint();
    $display("[Base] I am  non - virtual function The class values of a = %0d, b = %0d",a,b);
  endfunction
endclass


class derived extends base;
  
  int a,b;
  
  function new(int a=10,b=20);
    //$display("[Derived] COnstructor here!!!");
    super.new(a,b);
    $display("[Derived] COnstructor here!!!");
    
  endfunction
  
  function void tempInitialization();
    a= 10;b=20;
  endfunction
  
  function void tempprint();
    $display("[Dervied] I am a non virtual function The local class values of a = %0d, b = %0d",a,b);
    $display("[Derived]The parent class values of a = %0d, b = %0d, c = %0d",super.a,super.b,super.c);
    // can call
    print();
  endfunction
  
  virtual function void print();
    $display("[Dervied]I am a virtual function The local class values of a = %0d, b = %0d",a,b);
  endfunction
  
  
endclass

class derived2 extends base;
  
  int a,b;
  
  function new(int a=10,b=20);
    //$display("[Derived] COnstructor here!!!");
    super.new(a,b);
    $display("[Derived2] COnstructor here!!!");
    
  endfunction
  
  function void tempInitialization();
    a= 10;b=20;
  endfunction
  
  function void tempprint();
    $display("[Dervied2] I am a non virtual function The local class values of a = %0d, b = %0d",a,b);
    $display("[Derived2]The parent class values of a = %0d, b = %0d, c = %0d",super.a,super.b,super.c);
    // can call
    print();
  endfunction
  
  function void print();
    $display("[Dervied2]I am a virtual function The local class values of a = %0d, b = %0d",a,b);
  endfunction
  
endclass

class derived3 extends derived;
  
  int p,q;
  
 function new();
    //super.new();
   $display("[Derived 3] Constructor here!!!");  
 endfunction
  
  function void print();
    $display("[Derived-3] The value of p = %0d, q = %0d",p,q);
  endfunction
  
endclass


program top;
  
  derived d;
  derived2 d2;
  base b;
  
  derived3 d3; // extends derived
  initial begin
    
    b = new(1,2);
    b.print();
    b.tempprint();
    
	d = new();
	b = d;
	b.print();
    
	d3 = new();
	b = d3;
	b.print();
	
   /* d= new(11,33);
    d.tempInitialization();
    d.print();
    d.tempprint();
    
    b = d;
    b.print();
    b.tempprint();
    
     d2 = new (1,2);
    d2.print();
    
    
    
    d3 = new;
    d3.print();
   	
    d = d3;
    d.print();
    
    b= d3;
    b.print();
    */
    
    
  end
  
endprogram