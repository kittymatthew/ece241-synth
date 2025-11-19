module sustain_fsm (clock, reset, sustain_button, key_pressed, current_note_on_key, final_note);	
	input clock;
    input reset;
    input sustain_button;      
    input key_pressed;        
    input [4:0] current_note_on_key;
    output reg [4:0] final_note;

	reg [4:0] sustained_note;
	always@(posedge clock)
	begin 
		if(reset)
		begin 
			sustained_note<=0;
		end
		else 
		begin 
			if(sustain_button)
			begin 
				if(key_pressed)
				begin 
					sustained_note<=current_note_on_key;
				end
				else
				begin 
					sustained_note<=0; 
				end
			end
		end
	end
	always@(*)
	begin 
		final_note=sustained_note;
	end

endmodule
