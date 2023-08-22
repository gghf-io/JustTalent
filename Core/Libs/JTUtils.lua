-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local JTUtils = private.NewLib("JTUtils")

function JTUtils.case(i,d) return function(t) return t[i] or d end end

function JTUtils.SetPlayerLink(realm,name)
    return "https://worldofwarcraft.blizzard.com/fr-fr/character/eu/" .. string.lower(realm) .. "/" .. string.lower(name)
end