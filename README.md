# simply-love-stepcount
Stepcounter module for Simply Love

# Installing
Add the file `stepcount.lua` to the 'Modules' directory inside your Simply Love theme installation.

# Using
This will create a folder name 'Sl-Steps' in your profile. Inside, it will created date-stamped files named 'step-yyyymmdd-HHMMSS.json'. This will conatin two fields:

* Steps: the stepcount according to the way Simply Love calculates it
* DateTime: A date and time.

# Notes
If you need to quit a song early, don't use ESC or ScrollLock. Hold enter until it fails to Eval Screen. Otherwise, the notes don't get saved by the game.
