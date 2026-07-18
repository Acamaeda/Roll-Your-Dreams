# Levels

Levels are the heart of Roll Your Dreams. 

Key elements:
	- Level Control. Has a lot of settings that are important to the level.
	- The player: This is the player. Place it where the player starts.
		(You can also replace it with a different player object to change the player character)
	- Zones: A zone is a portion of the level that unlocks when you reach a certain size. For small levels they don't matter a huge amount,
		but you should put all of the Rollables into the "Rollables" of a zone.
	- WorldEnvironment: Lets you change the background, and other visual details.
	- Light Source: A source of global light.

## Initial stuff in Level Control

The first thing you need to do is set the level's scale, which is the same as the player's starting size, if the player is at least 1 meter.
Otherwise, set it to 1 divided by the starting size, and set the "scale direction" to "small". (Godot hates small numbers)

## Building the level:
	
Get Rollables from the "Stuff you use" folder and place them into the level under the "Rollables" of a Zone. You can adjust the position, rotation,
and scale (which also changes rolling them up!). You can also duplicate existing objects to save time. While terrain technically doesn't have to be rollable, it's treated the same way.

(Tip! Rotating objects differently can make things seem more natural and varied!)

## Adding features to objects

You can put a Feature as a child of a Rollable to change it in some way. The most important Feature, RollableProperties, lets you modify some basic properties of a Rollable.
For example, if an object is too large to roll up in the level, you should set "include in collection" to false so it's possible to complete the collection for the level.
Also, if a value is left blank it keeps the Rollable's original value.

## More on Zones

The idea of Zones is to break up the level into sections that are unlocked at different sizes, then load in things for that section. Zones have three key parts:
	- Rollables: The stuff that loads when this zone is opened. But remember, things go into a zone if they're VISIBLE from that zone, even if outside it.
	- Barrier: An invisible wall that is removed when the zone is opened. Add CollisionShapes/Polygons to it if you need them to keep the player in
	- Spawnpoint: Sets a new emergency respawn point at the position of this object for the player in case something goes wrong.
	
Properties:
	- Unlock with size: If true, it works how you'd expect. Otherwise, it must be unlocked another way.
	- Size Required: The size the player needs to unlock the zone. If it's zero, the zone is always unlocked.
	- Lowest height: The lowest height of the ground in the zone. (Needed to determine if the player fell off the map)
