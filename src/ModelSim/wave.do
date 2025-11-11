onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK_50 -radix binary /testbench/CLOCK_50
add wave -noupdate -label KEY -radix binary -childformat {{{/testbench/KEY[3]} -radix binary} {{/testbench/KEY[2]} -radix binary} {{/testbench/KEY[1]} -radix binary} {{/testbench/KEY[0]} -radix binary}} -expand -subitemconfig {{/testbench/KEY[3]} {-radix binary} {/testbench/KEY[2]} {-radix binary} {/testbench/KEY[1]} {-radix binary} {/testbench/KEY[0]} {-radix binary}} /testbench/KEY
add wave -noupdate -label SW -radix binary -childformat {{{/testbench/SW[9]} -radix binary} {{/testbench/SW[8]} -radix binary} {{/testbench/SW[7]} -radix binary} {{/testbench/SW[6]} -radix binary} {{/testbench/SW[5]} -radix binary} {{/testbench/SW[4]} -radix binary} {{/testbench/SW[3]} -radix binary} {{/testbench/SW[2]} -radix binary} {{/testbench/SW[1]} -radix binary} {{/testbench/SW[0]} -radix binary}} -expand -subitemconfig {{/testbench/SW[9]} {-radix binary} {/testbench/SW[8]} {-radix binary} {/testbench/SW[7]} {-radix binary} {/testbench/SW[6]} {-radix binary} {/testbench/SW[5]} {-radix binary} {/testbench/SW[4]} {-radix binary} {/testbench/SW[3]} {-radix binary} {/testbench/SW[2]} {-radix binary} {/testbench/SW[1]} {-radix binary} {/testbench/SW[0]} {-radix binary}} /testbench/SW
add wave -noupdate -divider synth
add wave -noupdate -label AUDIO_OUT -radix binary -childformat {{{/testbench/U1/AUDIO_OUT[31]} -radix binary} {{/testbench/U1/AUDIO_OUT[30]} -radix binary} {{/testbench/U1/AUDIO_OUT[29]} -radix binary} {{/testbench/U1/AUDIO_OUT[28]} -radix binary} {{/testbench/U1/AUDIO_OUT[27]} -radix binary} {{/testbench/U1/AUDIO_OUT[26]} -radix binary} {{/testbench/U1/AUDIO_OUT[25]} -radix binary} {{/testbench/U1/AUDIO_OUT[24]} -radix binary} {{/testbench/U1/AUDIO_OUT[23]} -radix binary} {{/testbench/U1/AUDIO_OUT[22]} -radix binary} {{/testbench/U1/AUDIO_OUT[21]} -radix binary} {{/testbench/U1/AUDIO_OUT[20]} -radix binary} {{/testbench/U1/AUDIO_OUT[19]} -radix binary} {{/testbench/U1/AUDIO_OUT[18]} -radix binary} {{/testbench/U1/AUDIO_OUT[17]} -radix binary} {{/testbench/U1/AUDIO_OUT[16]} -radix binary} {{/testbench/U1/AUDIO_OUT[15]} -radix binary} {{/testbench/U1/AUDIO_OUT[14]} -radix binary} {{/testbench/U1/AUDIO_OUT[13]} -radix binary} {{/testbench/U1/AUDIO_OUT[12]} -radix binary} {{/testbench/U1/AUDIO_OUT[11]} -radix binary} {{/testbench/U1/AUDIO_OUT[10]} -radix binary} {{/testbench/U1/AUDIO_OUT[9]} -radix binary} {{/testbench/U1/AUDIO_OUT[8]} -radix binary} {{/testbench/U1/AUDIO_OUT[7]} -radix binary} {{/testbench/U1/AUDIO_OUT[6]} -radix binary} {{/testbench/U1/AUDIO_OUT[5]} -radix binary} {{/testbench/U1/AUDIO_OUT[4]} -radix binary} {{/testbench/U1/AUDIO_OUT[3]} -radix binary} {{/testbench/U1/AUDIO_OUT[2]} -radix binary} {{/testbench/U1/AUDIO_OUT[1]} -radix binary} {{/testbench/U1/AUDIO_OUT[0]} -radix binary}} -subitemconfig {{/testbench/U1/AUDIO_OUT[31]} {-radix binary} {/testbench/U1/AUDIO_OUT[30]} {-radix binary} {/testbench/U1/AUDIO_OUT[29]} {-radix binary} {/testbench/U1/AUDIO_OUT[28]} {-radix binary} {/testbench/U1/AUDIO_OUT[27]} {-radix binary} {/testbench/U1/AUDIO_OUT[26]} {-radix binary} {/testbench/U1/AUDIO_OUT[25]} {-radix binary} {/testbench/U1/AUDIO_OUT[24]} {-radix binary} {/testbench/U1/AUDIO_OUT[23]} {-radix binary} {/testbench/U1/AUDIO_OUT[22]} {-radix binary} {/testbench/U1/AUDIO_OUT[21]} {-radix binary} {/testbench/U1/AUDIO_OUT[20]} {-radix binary} {/testbench/U1/AUDIO_OUT[19]} {-radix binary} {/testbench/U1/AUDIO_OUT[18]} {-radix binary} {/testbench/U1/AUDIO_OUT[17]} {-radix binary} {/testbench/U1/AUDIO_OUT[16]} {-radix binary} {/testbench/U1/AUDIO_OUT[15]} {-radix binary} {/testbench/U1/AUDIO_OUT[14]} {-radix binary} {/testbench/U1/AUDIO_OUT[13]} {-radix binary} {/testbench/U1/AUDIO_OUT[12]} {-radix binary} {/testbench/U1/AUDIO_OUT[11]} {-radix binary} {/testbench/U1/AUDIO_OUT[10]} {-radix binary} {/testbench/U1/AUDIO_OUT[9]} {-radix binary} {/testbench/U1/AUDIO_OUT[8]} {-radix binary} {/testbench/U1/AUDIO_OUT[7]} {-radix binary} {/testbench/U1/AUDIO_OUT[6]} {-radix binary} {/testbench/U1/AUDIO_OUT[5]} {-radix binary} {/testbench/U1/AUDIO_OUT[4]} {-radix binary} {/testbench/U1/AUDIO_OUT[3]} {-radix binary} {/testbench/U1/AUDIO_OUT[2]} {-radix binary} {/testbench/U1/AUDIO_OUT[1]} {-radix binary} {/testbench/U1/AUDIO_OUT[0]} {-radix binary}} /testbench/U1/AUDIO_OUT
add wave -noupdate /testbench/U1/sine_gen/sine_generator/COUNT
add wave -noupdate /testbench/U1/sine_gen/sine_generator/STEP
add wave -noupdate /testbench/U1/sine_gen/sine_generator/ADDRESS
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 80
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {120 ns}
