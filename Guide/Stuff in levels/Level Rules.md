# Level Rules

The Level Rules node, under Level Control, is a major part of setting up different goals and conditions for your level.

## The Timer

The first setting, Timer Mode has 3 settings:
	- Countdown gives the level a time limit that you can choose.
	- Time taken instead tracks how long it takes to beat the level.
	- No timer disables the timer.
	
## Score Counters

The Counters node is where the level keeps track of all of the important things in the level.
Size is the player's size, Time is the level timer, Objects counts the total number of objects rolled up.
Objects also has a countdown setting that makes it count down from a starting value instead of counting up. It also has some features in common with other ScoreCounters.

You can add other things to track by adding ScoreCounters from Events/Counters. Change the name to the name of what it tracks.

ScoreCounter Features:
	- Display: Shows the count in the HUD and values in the popup when rolling up an object.
	- Use label: Adds the name to the display. Like "Points: 123"
	- Object Values: Sets the values each object gives to the counter. "Key" is the name of the object, and "value" is how much it gives.
	- Unit: The unit for the score, if any. e.g. "g", "years"
	- Pre unit: A unit that goes before the number like "$"
	- Decimal places: How many decimal places to show
	- Metric Prefixes: Formats the unit with metric prefixes. Full includes "kilo" and "mili", abbreviated is "k" and "m".
	- Value: The starting value of the counter.
	
## End/win/perfect conditions

The end condition is useful in levels without a time limit to determine when the player is finished (but also sometimes helpful in other levels)
The win condition determines if the player actually won the level when it ends. ("End on fail" auto-ends the level if the player can no longer win)
The perfect clear condition is if the player got the best result and the high score should be based on time instead of size/count/etc.

You can ignore any of them that you don't need.

Each of them has:
	- A counter, which is what the condition is based on
	- A target, which it compares the counter to
	- A mode, which is how it compares the counter and target
