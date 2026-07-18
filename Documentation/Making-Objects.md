#Making Objects

Ball-rolling adventures require a big collection of things to roll up, and it will be a community effort to build that collection.

To start with, make a duplicate of an existing Rollable .tscn file by right-clicking it and selecting "duplicate". Then open that file in the 3d view.
Double-click the topmost object in the scene tree to rename it to whatever your object is as well.

## Importing the Model

Next, you need the 3d model, ideally in .glb/.gltf format. Otherwise, it's best to open it in Blender and re-export it as the correct format.
Then, make a new folder in Assets/3d/[owner of the model] and drag the 3d model file in. After it imports, drag the file from the file list into the scene tree, and remove whatever the previous model/mesh was.

## Positioning and Scale

Select the model in the scene tree, and adjust its transform (position/rotation/scale). It's good to scale it to at least 10 units.
If your object is something that usually stays upright, it's best to have y=0 be at the bottom
of the object to make placing things easier. Adjust the position so 0,0,0 is where you want the object to rotate around if it would rotate.
The rotation should be set so it is facing in the positive Z direction (the blue arrow).

## Standard Collision

Collision determines where your object will collide with other things. It is made up of CollisionShape/Polygon3Ds.
They're usually much less detailed than the model, since they affect performance more. An object can have several diffent collision sets.
The standard collision which is all most objects need should usually not have more than 4 shapes (and usually less).
We'll focus on the standard collision for now, the others are described later.

Click the CollisionShape3D that isn't in the DetailedCollision/SimpleCollision (and delete any others). On the right side, you'll see the CollisionShape3D settings.
Go to the "shape" field and click the drop-down and select the shape type you want (do this even if it's already the correct shape).
You'll usually want box or cylinder, possibly sphere or capsule.
After you've selected the shape, if you click on it, you'll be able to adjust its size. This is the best way to change the dimensions of the shape.
Once you've done that and adjusted the position with transform, if you need another shape, you can duplicate the object and repeat the process.

## Final Steps

Click on the "Rollable" object in the scene tree to edit it. It has the following relevant properties:
	- Object Name: Name of the object
	- Description: Description in the Collection (You can also get suggestions from other people on this)
	- Creator: The creator of the model for the object
	- Link: Link to the creator's page/source for the model
	- Base size: The size of the object without scaling. This is 1/2.16 the standard "size to roll up", and it's up to you to figure out what feels right.
		"1" size is a 1-meter sphere, a solid 1-meter cube has 1.2 times more size. 
		The average of the length, width, and height is a good starting point. (Or cube root of l*w*h)
	- Model scale: The scale your model is at. How many meters one unit is equal to. BUT if it is smaller than 1 unit, instead use 1/scale so it is always more than 1.
	- Scale direction: Determines which way to apply model scale (since Godot hates small numbers). Big means your object is larger than the model scale, small means it is smaller.
	- Solid: Determines if the object can collide with other objects and the player (it can still be rolled up)

## License stuff

This only matters for officially adding the object to the RYD collection. If you don't have the rights to the model, it can't be added.
If someone else made it and it has a downloadable license, include that lisence in the folder alongside the assets. If you made it, you can use your own license.
I suggest making a copy of [point to noncommercial license template in repo]

## Other collisions

The DetailedCollision system is a way to make an object usable at large and small scales. You can make a house object,
Which is at the center of a level that goes up on its porch and in its garage, but then later use a dozen houses in a city.
You set the first house to use the DetailedCollision, and the other houses to use the normal, low-detail collison with the "collision" selector in RollableProperties.
Setting up the DetailedCollision is the same as the regular collision, except you put it inside the DetailedCollision object.
You can also use more complex CollisionShapes like HeightMap or PolygonShapes.

There's also the SimpleCollision which would be used for small objects that have several shapes in their standard collision, in cases where it would hurt performance.
(Like lots of small, moving things)
