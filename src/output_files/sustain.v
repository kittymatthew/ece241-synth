module sustain_feature(clock, reset, sustain_button, key_pressed,current_note_on_key, final_note);
	input clock, reset, sustain_button, key_pressed;
	input [4:0]current_note_on_key; 
	output reg [4:0] final_note;
	reg [4:0]sustained_note;
	
	
	always@(posedge clock)
	begin 
		if(reset)
		begin 
			sustained_note<=0; 
		end
		else
		begin
			if(!sustain_button)
			begin
				sustained_note<=0;
			end
			else if(key_pressed)
			begin 
				sustained_note<=current_note_on_key;
			end
		end
	end
		
	always@(*)
	begin 
		if(sustain_button)
		begin 
			if(key_pressed)
			begin 
				final_note=current_note_on_key; 
			end
			else
			begin 
				final_note=sustained_note;
			end
		end
		else
		begin 
			if(key_pressed)
			begin 
				final_note=current_note_on_key;
			end 
			else
			begin
				final_note=0;
			end
		end
	end

endmodule
