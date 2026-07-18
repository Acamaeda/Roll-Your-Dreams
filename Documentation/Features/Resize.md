# Recolor

Recolor is a Solor Feature that changes the color of the object by shifting
all of the hues in the object.

You can use this along with RollableProperties to fully make a variant of an object.

## Properties
	- Scale: The amount to scale by. BUT if it is smaller than 1 unit, instead use 1/scale so it is always more than 1.
	- Scale direction: Determines which way to apply model scale (since Godot hates small numbers). Big means your object is larger than the model scale, small means it is smaller.
	- Mode: Multiply multiplies the scale of the object, set directly sets it to the scale you give.
