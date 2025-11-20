module sustain_fsm (clock, reset, sustain_button, key_pressed, current_note_on_key, final_note);	
	input clock, reset, sustain_button, key_pressed; // Inputs
    input [4:0] current_note_on_key;
    output reg [4:0] final_note; // Sustain note output

	reg [4:0] sustained_note;

	always @ (posedge clock) begin 
		if (reset) begin // Reset on reset signal
			sustained_note <= 0;
		end else begin
			if (sustain_button) begin // If we press the sustain key
				if (key_pressed) begin // And a note is currently being player
					sustained_note <= current_note_on_key; // Store the sustained note
				end else begin 
					sustained_note <= 0; // Otherwise, remove the note
				end
			end
		end
	end

	always @ (*) begin
		final_note = sustained_note; // Output the sustained note
	end
endmodule