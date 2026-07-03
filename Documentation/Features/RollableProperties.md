# Rollable Properties

Rollable Properties is a Solor Feature that lets you change a lot of different properties of a Rollable.


## Properties
	- Object Name: The name of the object (changing this will make a new entry in the Collection)
	- Description: The description in the Collection
	- Collision: Which type of collision to use (if they are implemented!)
		- Use Detailed Collision for very large objects that are terrain
		- Use super simple collision for things that are very small and numerous.
	- Solid: Toggle if the object will collide and block things including the player
		(It is still rollable)
	- Rollable: Toggle if the object is possible to roll up even if it's the right size
	- Include in Collection: Toggle if the object is included in the collection
		(It shouldn't be included if it isn't possible to roll up)
