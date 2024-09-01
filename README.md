# oUF_Riphie

`oUF_Riphie` is a library built on top of [oUF](https://github.com/oUF-wow/oUF) to create unit
frames for World of Warcraft. You can check out
[oUF_RiphieConfig](https://github.com/tombell/oUF_RiphieConfig) as an example of
using this library.

## Frames

### Player

This is your main player unit frame.

```lua
local A, L = ...

L.C.player = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 180, 30 }, -- { width:number, height:number }
    -- position of this frame
    point = { "RIGHT", "UIParent", "CENTER", -200, -177 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number
}
```

### Pet

This is your pet unit frame.

```lua
local A, L = ...

L.C.pet = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 80, 20 }, -- { width:number, height:number }
    -- position of this frame
    point = { "RIGHT", "oUF_RiphiePlayer", "LEFT", -10, 0 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number
}
```

### Focus

This is your focus unit frame.

```lua
local A, L = ...

L.C.focus = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 150, 20 }, -- { width:number, height:number }
    -- position of this frame
    point = { "RIGHT", "UIParent", "CENTER", -200, -300 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number
}
```

### Target

This is your target unit frame.

```lua
local A, L = ...

L.C.target = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 180, 30 }, -- { width:number, height:number }
    -- position of this frame
    point = { "LEFT", "UIParent", "CENTER", 200, -177 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number
}
```

### Target of target

This is your target of target unit frame.

```lua
local A, L = ...

L.C.targettarget = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 60, 20 }, -- { width:number, height:number }
    -- position of this frame
    point = { "BOTTOMRIGHT", "oUF_RiphieTarget", "TOPRIGHT", 0, 5 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number
}
```

### Party

This is your party unit frames.

```lua
local A, L = ...

L.C.party = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 150, 25 }, -- { width:number, height:number }
    -- position of the first party member frame
    point = { "CENTER", "UIParent", "CENTER", -450, 0 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number

    -- setup is needed to spawn the party header (https://wowpedia.fandom.com/wiki/SecureGroupHeaderTemplate)
    setup = {
        -- name of a Blizzard frame template, uses SecureGroupHeaderTemplate if nil
        template = nil, -- string
        -- custom state driver for visibility of the frames
        visibility = "custom [group:party,nogroup:raid] show; hide", -- string
        -- show the player in the group header when not in a raid
        showPlayer = false, -- boolean
        -- show the group header when the player is not in any group
        showSolo = false, -- boolean
        -- show the group header when the player is in a party
        showParty = true, -- boolean
        -- show the group header when the player is in a raid
        showRaid = false, -- boolean
        -- XML anchor point
        point = "TOP", -- string
        -- the x offset to be used when anchoring new frames
        xOffset = 0, -- number
        -- the y offset to be used when anchoring new frames
        yOffset = -5, -- number
    },
}
```

### Raid

This is your raid unit frames.

```lua
local A, L = ...

L.C.raid = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 80, 20 }, -- { width:number, height:number }
    -- position for each raid group, must be 8 tables
    points = {
        { "TOPLEFT", 20, -20 },
        { "TOP", "oUF_RiphieRaidHeader1", "BOTTOM", 0, -10 },
        { "TOP", "oUF_RiphieRaidHeader2", "BOTTOM", 0, -10 },
        { "TOP", "oUF_RiphieRaidHeader3", "BOTTOM", 0, -10 },
        { "LEFT", "oUF_RiphieRaidHeader1", "RIGHT", 10, 0 },
        { "TOP", "oUF_RiphieRaidHeader5", "BOTTOM", 0, -10 },
        { "TOP", "oUF_RiphieRaidHeader6", "BOTTOM", 0, -10 },
        { "TOP", "oUF_RiphieRaidHeader7", "BOTTOM", 0, -10 },
    },
    -- scale of this frame
    scale = 1, -- number

    -- setup is needed to spawn the raid header (https://wowpedia.fandom.com/wiki/SecureGroupHeaderTemplate)
    setup = {
        -- name of a Blizzard frame template, uses SecureGroupHeaderTemplate if nil
        template = nil, -- string
        -- custom state driver for visibility of the frames
        visibility = "custom [group:raid] show; hide", -- string
        -- show the player in the group header when not in a raid
        showPlayer = false, -- boolean
        -- show the group header when the player is not in any group
        showSolo = false, -- boolean
        -- show the group header when the player is in a party
        showParty = false, -- boolean
        -- show the group header when the player is in a raid
        showRaid = true, -- boolean
        -- XML anchor point
        point = "TOP", -- string
        -- the x offset to be used when anchoring new frames
        xOffset = 0, -- number
        -- the y offset to be used when anchoring new frames
        yOffset = -6, -- number
    },
}
```

### Boss

This is your boss unit frames.

```lua
local A, L = ...

L.C.boss = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 180, 30 }, -- { width:number, height:number }
    -- position of this frame
    point = { "CENTER", "UIParent", "CENTER", 500, 120 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1, -- number

    setup = {
        -- XML anchor point
        point = "TOP", -- string
        -- XML anchor point that this frame will be anchored to, the relative to frame will be the preceeding boss frame
        relativePoint = "BOTTOM", -- string
        -- the x offset to be used when anchoring new frames
        xOffset = 0, -- number
        -- the y offset to be used when anchoring new frames
        yOffset = -10, -- number
    },
}
```

### Nameplates

This is for nameplate frames.

```lua
local A, L = ...

L.C.boss = {
    -- whether to show this frame
    enabled = true, -- boolean
    -- width and height of this frame
    size = { 180, 15 }, -- { width:number, height:number }
    -- position of this frame
    point = { "CENTER" }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
    -- scale of this frame
    scale = 1 * UIParent:GetScale(), -- number
}
```

You can specify a table of NPC IDs that map to RGB colours for custom nameplate
colours.

```lua
local NamePlateCustomUnits = {
    [194649] = { 1, 0, 1 }, -- Normal Raid Dummy (Valdrakken)
    [194644] = { 1, 0.2, 0.3 }, -- Dungeoneer's Training Dummy (Valdrakken)
}
L.C.NamePlateCustomUnits = NamePlateCustomUnits
```

You can specify nameplate console variables you want to configure as well.

```lua
local NamePlateCVars = {
    nameplateMinScale = 1,
    nameplateMaxScale = 1,

    nameplateMinScaleDistance = 0,
    nameplateMaxScaleDistance = 40,

    nameplateGlobalScale = 1,
    NamePlateHorizontalScale = 1,
    NamePlateVerticalScale = 1,
    nameplateSelfScale = 1,
    nameplateSelectedScale = 1.1,
    nameplateLargerScale = 1,

    nameplateShowFriendlyNPCs = 0,

    nameplateMinAlpha = 0.6,
    nameplateMaxAlpha = 0.6,

    nameplateMinAlphaDistance = 0,
    nameplateMaxAlphaDistance = 40,

    nameplateSelectedAlpha = 1,
    nameplateOccludedAlphaMult = 0.8,
}
L.C.NamePlateCVars = NamePlateCVars
```

## Elements

These are the elements that can be configured per frame. Some elements cannot be
disabled, for example the health bar.

### Health Bar

The health bar frame cannot be disabled. The size and position of the health bar
match the unit frame.

```lua
-- inside the frame configuration table
healthbar = {
    -- enable/disable colouring by disconnect colour
    colorDisconnected = false, -- boolean
    -- enable/disable colouring by reaction colour
    colorReaction = false, -- boolean
    -- enable/disable colouring by class colour
    colorClass = true, -- boolean
    -- enable/disable colouring by health colour
    colorHealth = false, -- boolean
    -- enable/disable colouring by threat status
    colorThreat = false, -- boolean

    -- health prediction element
    absorb = {
        -- enable/disable health prediction and absorbs
        enabled = true, -- boolean
    },

    -- name configuration
    name = {
        enabled = true, -- boolean
        point = { "CENTER", 0, 0 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
        font = "path\\to\\font", -- string
        size = 12, -- number
        outline = "OUTLINE", -- string
        align = "LEFT", -- string
        noshadow = true, -- boolean
        tag = "[oUF_RiphieConfig:status]", -- string
    },

    -- health amount configuration
    health = {
        enabled = true, -- boolean
        point = { "LEFT", 5, 0 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
        font = "path\\to\\font", -- string
        size = 12, -- number
        outline = "OUTLINE", -- string
        align = "LEFT", -- string
        noshadow = true, -- boolean
        tag = "[oUF_Ripie:health]", -- string
    },

    -- health percentage configuration
    healthperc = {
        enabled = true, -- boolean
        point = { "RIGHT", -5, 0 }, -- { anchor1:string, parent:string, anchor2:string, x:number, y:number }
        font = "path\\to\\font", -- string
        size = 12, -- number
        outline = "OUTLINE", -- string
        align = "LEFT", -- string
        noshadow = true, -- boolean
        tag = "[perhp]%", -- string
    },
}
```

### Power Bar

### Cast Bar

### Auras

### Raid Target Indicator

### Ready Check Indicator

### Range
