# Players

To make a new player, make a duplicate of an existing player in "The stuff you use/Player/".

Key elements:
	- Ball: Controls the player's movement, including speed and other features.
	- Model: Put the 3d model for the ball as a child of this. It doesn't have to be spherical, but
	will behave like it is. The blue sphere shows the hitbox.
	- Collector: Controls everything related to rolling things up.
	- Pusher Character: Put the Pusher Character here.

## Ball Settings
	- Speed mult: A flat multiplier to movement speed.
	- Horizontal mult: Makes the ball go sloweer moving sideways.
	- Back mult: Makes the ball go sloweer moving backwards.
	- Turn speed: How fast the player turns.

## Collector Settings
	- Mode: Choose how it rolls things up:
		- Sticky without collision: Things stick to the ball, but it still behaves like a sphere.
		- Absorb: Objects are absorbed by the ball and it grows.
	- Rollup ratio: How much bigger the player needs to be to roll something up.
	- Exponent: Makes larger objects count more towards growth than smaller ones.
	An exponent of 3 makes a size-2 object worth 8 size-1 objects.
	- Growth mult: A flat multiplier on growth from rolling things up.
