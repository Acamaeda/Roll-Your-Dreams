# Orbit

Orbit is a Group Feature that causes the objects to move around its center point.
It has a visual indicator of its orbit (try moving the feature up if
you don't see it), and rotating the feature will change the axis of rotation.

## Properties
	- Radius: the distance objects orbit at.
		(If this is zero, they will use their current distance)
	- Speed: how fast things orbit in orbits per second. Negative speed goes in reverse.
	- Arc used: The part of a full circle that objects take up, in degrees.
		e.g. 180 means objects will be spread over only half of the circle.
	- Rotation style: How orbiting objects will change their rotation while orbiting:
		- Towards ground: Objects will face forwards in the direction of movement, with
		the "down" direction oriented towards the ground. Like people walking in a circle.
		- Towards ground: Objects will face forwards in the direction of movement, with
		the "down" direction oriented towards the orbit center.
		- No rotation: Objects' rotation is not affected by Orbit.

## Changing the rotation center of objects

You can change the point that an object rotates around by doing the following:
	1. Create a Node3D where the object currently is.
	2. Put the object inside of it.
	3. Move the object so the Node3D is where the center point should be.
