# An Introduction to Rolling Your Dreams
Roll Your Dreams takes advantage of Godot's 3D editor and design principles to make creating things accessible.

Get started by downloading [Godot 4.7.1](https://godotengine.org/download/archive/4.7.1-stable) and the RYD source code. (You can also properly use Github if you're planning to do dev work)

## Brief tour of Godot editor

The Godot editor has a lot of features, but most of them aren't needed for Roll Your Dreams so you can just ignore them.
The parts that are important:
	- The Scene Viewer: In the center, this is where you see the level and move objects around.
	- The Scene Tree: At the top left, this is how everything in a level is organized. Each thing in it is called a Node,
	and each Node can have other Nodes put under them (called "children") like how you can put files and subfolders into folders.
	- The File Viewer: At the bottom left, for finding files to add to the level. Mostly you can ignore everything except "The stuff you use".
	- The Inspector: At the far right. When you click on something in the Scene Tree, it lets you edit its details and properties.

(There is also the Output at the bottom which can sometimes give warnings or error messages if something goes wrong)

Some other helpful info:
https://docs.godotengine.org/en/stable/getting_started/introduction/key_concepts_overview.html
https://docs.godotengine.org/en/stable/getting_started/introduction/first_look_at_the_editor.html


## Updating RYD
If you didn't change any old files and just added new ones, you can simply download the new version and use it to replace everything.
If you changed something, make a copy of those files as a backup first.
