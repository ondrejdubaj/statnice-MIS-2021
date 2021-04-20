dtmc

const int max_buffer = 5;
const int requests_to_send = 20;

const double send_prob = 0.9;
const double receive_prob = 0.3;




module producent

   request: [0..requests_to_send] init requests_to_send;
   ready_to_produce: [0..1] init 0;

   [] (ready_to_produce = 0)  -> send_prob : (ready_to_produce'=1) + (1-send_prob):true; 
   [to_buffer] (ready_to_produce = 1) & (request > 0) ->  1 : (request'= request - 1) & (ready_to_produce'=0);

endmodule 



module buffer
   buffer: [0..max_buffer] init 0;
   lost: [0..requests_to_send] init 0;

   [to_buffer] (buffer < max_buffer) ->  1 : (buffer' = buffer + 1);
   //[to_buffer] (buffer = max_buffer) ->  1 : true; 
   //[to_buffer] (buffer = max_buffer) & (lost < requests_to_send) ->  1 : (lost' = lost + 1);

   [consume] (buffer > 0)  ->  1 : (buffer' = buffer - 1);
endmodule 



module consumer
ready_to_receive : [0..1] init 0;

   [] (ready_to_receive = 0) -> receive_prob : (ready_to_receive' = 1) + (1-receive_prob) : true; 
   [consume] (ready_to_receive = 1) -> 1:(ready_to_receive' = 0);
   
endmodule 

rewards "buffer"
 true:buffer;
endrewards

rewards "max_buffer"
 max_buffer=buffer:1;
endrewards

rewards "consume"
[consume] true:1;
endrewards


rewards "lost"
[to_buffer] buffer = max_buffer:1;
endrewards











