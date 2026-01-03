# simply-love-stepcount
Stepcounter module for Simply Love

# Installing
Add the file `stepcount.lua` to the 'Modules' directory inside your Simply Love theme installation.

# Effect
This will create a folder name 'Sl-Steps' in your profile. Inside, it will created date-stamped files named 'step-yyyymmdd-HHMMSS.json'. This will conatin two fields:

* Steps: the stepcount according to the way Simply Love calculates it
* DateTime: A date and time.

# Using

* goto the [One Million Arrows Challenge page](https://jeffreyatw.github.io/omac/)
* Drag your SL-Steps profile page onto the OMAC website and drop it
* Enjoy!

# Notes

* If you need to quit a song early, don't use ESC or ScrollLock. Hold enter until it fails to Eval Screen. Otherwise, the notes don't get saved by the game.
* Restarting a song will not save notes hit
* Jumps/etc are too ahrd for me to tell from brackets. So jumps are 1 step, since I generally play songs with more BR in them.
* This is *not* how Simply Love counts steps. That step count is *notes* hit, and thus counts a bracket as 2 (or more) notes.
