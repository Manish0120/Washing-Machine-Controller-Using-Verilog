# Washing Machine Controller
This project is a verilog code for a washing machine controller that performs five cycles: soak, wash, rinse, spin, and dry. The controller has the following features:

It starts when the user deposits a coin and goes through the five cycles in sequence.
It has an optional input for additional rinse cycle, which can be asserted before or during the rinse cycle.
It has a timer that controls the duration of each cycle. The timer is a down counter that counts from 74752000000 to 1 at a frequency of 512 MHz. The timer resets itself after completing a full washing operation, which takes 146 seconds.
It has a lid sensor that pauses the timer and the machine when the lid is raised, and resumes them when the lid is closed.
It has output signals for each cycle that indicate the current operation of the machine. It also has a completed signal that indicates the end of the washing operation.

# Inputs and Outputs
The controller has the following inputs and outputs:

clk: The clock input, which has a frequency of 512 MHz.
rst: The reset input, which resets the controller to the initial state.
coin: The coin input, which starts the washing operation when asserted.
add_rinse: The additional rinse input, which adds an extra rinse cycle when asserted.
lid_cl: The lid sensor input, which pauses the timer and the machine when deasserted, and resumes them when asserted.
Soak_signal: The soak output, which is high when the machine is in the soak cycle and the lid is closed.
Wash_signal: The wash output, which is high when the machine is in the wash cycle and the lid is closed.
Rinse_signal: The rinse output, which is high when the machine is in the rinse cycle and the lid is closed.
Spin_signal: The spin output, which is high when the machine is in the spin cycle and the lid is closed.
Dry_signal: The dry output, which is high when the machine is in the dry cycle and the lid is closed.
completed: The completed output, which is high when the washing operation is finished.

# State Diagram
The controller has six states, which are encoded as follows:

s0: The reset state, where the controller waits for the coin input. The state code is 000.
s1: The soak state, where the controller performs the soak cycle. The state code is 001.
s2: The wash state, where the controller performs the wash cycle. The state code is 010.
s3: The rinse state, where the controller performs the rinse cycle. The state code is 011.
s4: The spin state, where the controller performs the spin cycle. The state code is 100.
s5: The dry state, where the controller performs the dry cycle. The state code is 101.
