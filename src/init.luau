--[[
Why use this module?
Just having one sound instance makes it impossible to play the sound instance rapidly without stopping previously played sounds
Default sound instances also do not have support for acoustic simulation
AudioEmitters and AudioPlayers fix this by allowing for support for acoustic simulation (be sure to have AcousticSimulation enabled in SoundService)
However, AudioEmitters and AudioPlayers require a Wire instance to connect them
This can get very messy with a lot of instances and now you have to multiply it if you want to play the sound rapidly
This module provides a lightweight way to create a "pool" for a group of sounds and can be played with :Play() and cleanuped with :Destroy()
]]

local SoundPool = {}
SoundPool.__index = SoundPool

type SoundEntry = {
    player : AudioPlayer,
    emitter : AudioEmitter,
    wire : Wire,
}

export type SoundPool = {
	Play : (self : SoundPool) -> SoundEntry?,

    Destroy : (self : SoundPool) -> (),

    Volume : number,

    _audioPlayers : {SoundEntry},
}

--Constructor for the SoundPool object
---@param parent BasePart | Attachment -- The physical part or attachment that the audio plays from
---@param soundID string -- The sound id to play when the :Play() method is called
---@param volume number -- The volume that the sounds will play at
---@param poolSize number -- The size of the pool to create, set this to the length of the audio divided by the rate the audio will play at
---@return SoundPool
function SoundPool.new(parent: BasePart | Attachment, soundID: string, volume: number, poolSize: number): SoundPool
    local self = setmetatable({}, SoundPool)
    self._parent = parent
    self._audioPlayers = {}
	self._volume = volume

    for _ = 1, poolSize do
        local audioPlayer = Instance.new("AudioPlayer")
        local audioEmitter = Instance.new("AudioEmitter")
        local wire = Instance.new("Wire")

        audioPlayer.Volume = volume
        audioPlayer.AssetId = soundID

        wire.SourceInstance = audioPlayer
        wire.TargetInstance = audioEmitter

        audioPlayer.Parent = parent
        audioEmitter.Parent = parent
        wire.Parent = parent

        table.insert(self._audioPlayers, {
            player = audioPlayer,
            emitter = audioEmitter,
            wire = wire,
        })
    end

    return self
end

--Plays the first AudioPlayer that isnt playing, also returns the SoundEntry that played
function SoundPool:Play(): SoundEntry?
    for _, entry in self._audioPlayers do
        if not entry.player.IsPlaying then
            entry.player:Play()
            return entry
        end
    end

    warn("SoundPool: all players are busy")
    return nil
end

--cleans up the object
function SoundPool:Destroy()
    for _, entry in self._audioPlayers do
        entry.player:Destroy()
        entry.emitter:Destroy()
        entry.wire:Destroy()
    end
	setmetatable(self, nil)
    table.clear(self)
end

return SoundPool