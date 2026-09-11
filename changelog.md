# Changelog

## 0.2
- Added Counters and Timers! They're key to many current and future features.
- Added level timer.
- Added ScoreCounters which lets you give objects different types of values when you roll them up
	- ScoreCounter values can be displayed along with size.
- Added ChangeCounterValue, ChangeTimerSpeed actions, CounterTrigger.
- ShowDialogue changes:
	- A single ShowDialogue action now can contain multiple dialogue messages.
	- You can use %countername (e.g. %size) to insert them into the dialogue.
	- Added CancelDialogue action
- Increased default sideways and backwards speed.

### 0.1.3
- Fixed moving objects being deleted (including in demo level)
- Changing size values automatically updates the rollable visualizer.

### 0.1.2
- The camera now zooms in to avoid clipping into walls.
- Camera now has smoother rotation.
- Properly added ChangePlayerSize action with different modes, and framework to easily add more "change x" actions.
- Separated MapScale from LevelScale, this is useful for re-using maps, editing big levels, and more in the future.
- Small demo level visual improvement.

### 0.1.1
- Added "Size to roll up visualizer" for Rollables
- Exported various player speed variables
- Slightly increased base turning speed
