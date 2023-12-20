`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: IIT JAMMU
// Engineer: Manish Kumar
// 
// Create Date: 24.11.2023 15:53:45
// Design Name: Washing Machine Controller 
// Module Name: Controller
// Project Name: Major Project VHDL
// Target Devices: Xilinx FPGA
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller(
    input clk,
    input rst,
    input coin,
    input add_rinse,
    input lid_cl,
    output Soak_signal, Wash_signal, Rinse_signal, Spin_signal, Dry_signal,
    output completed
);

    reg [36:0] count;
    reg [2:0] cs;
    parameter s0 = 3'd0, s1 = 3'd1, s2 = 3'd2, s3 = 3'd3, s4 = 3'd4, s5 = 3'd5;
    
    // output
    assign Soak_signal = (cs == s1 & lid_cl) ? 1:0;
    assign Wash_signal = (cs == s2 & lid_cl) ? 1:0;
    assign Rinse_signal = (cs == s3 & lid_cl) ? 1:0;
    assign Spin_signal = (cs == s4 & lid_cl) ? 1:0;
    assign Dry_signal = (cs == s5 & lid_cl) ? 1:0;
    assign completed = (cs == s0);
    
    // Counter
    always @(posedge clk) begin : counter
        if(rst | cs == s0) count <= 37'd74752000000;
        else if(lid_cl & cs != s0)  count <= (count == 36'd1)? 37'd74752000000  : count-1; 
        else count <= count;
    end
    
    // State Transition
    always @(posedge clk) begin : state_transition
        if(rst) cs <= s0;
        
        else begin
            case (cs)
                s0 : cs <= (coin) ? s1 : s0; // Reset State
                s1 : cs <= (count == 37'd59801600001) ? s2 : s1; // Soak State
                s2 : cs <= (count == 37'd44851200001) ? s3 : s2; // Wash State
                
                s3 : begin // // Rinse State
                    if(add_rinse) begin
                        cs <= (count == 37'd14950400001) ? s4 : s3;
                    end
                     else cs <= (count == 37'd29900800001) ? s4 : s3; 
                end
                
                 s4 : begin // Spin State
                    if(add_rinse) begin
                        cs <= (count == 37'd1) ? s5 : s4;
                    end
                     else cs <= (count == 37'd14950400001) ? s5 : s4; 
                end
                
                 s5 : begin // Dry State
                    if(add_rinse) begin
                        cs <= (count == 37'd59801600001) ? s0 : s5;
                    end
                     else cs <= (count == 37'd1) ? s0 : s5; // Rinse State
                end 
                
                default cs <= s0;
                
            endcase  
        end
    end


endmodule
