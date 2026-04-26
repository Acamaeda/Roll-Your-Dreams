#Making Objects

Ball-rolling adventures require a big collection of things to roll up, and it will be a community effort to build that collection.

To start with, make a duplicate of an existing Rollable .tscn file by right-clicking it and selecting "duplicate". Then open that file in the 3d view.
Double-click the topmost object in the scene tree to rename it to whatever your object is as well.

## Importing the Model

Next, you need the 3d model, ideally in .glb/.gltf format. Otherwise, it's best to open it in Blender and re-export it as the correct format.
Then, make a new folder somewhere in the Godot project and drag the 3d model file in. After it imports, drag the file from the file list into the scene tree, and remove whatever the previous model/mesh was.

## Positioning and Scale

Select the model in the scene tree, and adjust its transform (position/rotation/scale). Generally you want 1 Godot unit to be equal to 1 meter
(although you can re-scale individual objects). If your object is something that usually stays upright, it's best to have y=0 be at the bottom
of the object to make placing things easier. Adjust the position so 0,0,0 is where you want the object to rotate around if it would rotate.
The rotation should be set so it is facing in the positive Z direction (the blue arrow).

## Collision

Collision determines where your object will collidie with other things. It is made up of CollisionShape3Ds.
