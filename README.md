# soundpooler

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
