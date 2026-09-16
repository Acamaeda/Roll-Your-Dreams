# Spin

Spin is a Solo Feature that causes the object to spin around its center point.
It has a visual indicator of which way it rotates (try moving the feature up if
you don't see it), and rotating the Feature will change the axis of rotation.

## Properties
	- Speed, how fast the object rotates in rotations per second. Negative speed goes in reverse.

## Changing the rotation center

You can change the point that an object rotates around by doing the following:
	1. Create a Node3D.
	2. Put both this Feature and the object that should spin inside of it.
	3. Move the object so the Node3D is where the center point should be.
	4. Move the Node3D so the object is in the right position.
