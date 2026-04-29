# soundpooler

Why use this module?
Just having one sound instance makes it impossible to play the sound instance rapidly without stopping previously played sounds
Default sound instances also do not have support for acoustic simulation
AudioEmitters and AudioPlayers fix this by allowing for support for acoustic simulation (be sure to have AcousticSimulation enabled in SoundService)
However, AudioEmitters and AudioPlayers require a Wire instance to connect them
This can get very messy with a lot of instances and now you have to multiply it if you want to play the sound rapidly
This module provides a lightweight way to create a "pool" for a group of sounds and can be played with :Play() and cleanuped with :Destroy()

Wally: https://wally.run/package/anonymous197a/soundpooler?version=0.1.0

# Installation

Either install as dependency using Wally, or download the rbxm file and insert it into Roblox Studio

# Getting Started

This package is intended to be put in either ReplicatedStorage or ServerStorage

First, require the package

```luau
local SoundPooler = require(ReplicatedStorage.SoundPooler)
```

Next, create a new SoundPool using the constructor
```luau
local partInWorkspace = workspace.Part

local newPool = SooundPooler.new(partInWorkspace, "rbxassetid://0", 1, 10)
--Creates a new SoundPool object with its origin at "partInWorkspace", a sound id of "rbxassetid://0", with volume 1, and a soundpool size of 10.
```

Next, using the :Play() method of the SoundPool object
```luau
newPool:Play()
--Plays the sound from the origin, playing it again while the sound is still playing will not cancel the old sound
```

Finally, cleanup the SoundPool object with the :Destroy() method
```luau
newPool:Destroy()
```
