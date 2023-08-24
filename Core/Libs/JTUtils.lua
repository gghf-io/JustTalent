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

function JTUtils.SetPlayerFullName(realm,name)
    return name .. "-" .. realm
end

function JTUtils.SetWarcraftLogLink(serverId,className,spec)
    local srvId = 370 -- Hyjal
    return "https://www.warcraftlogs.com/server/rankings/"..serverId.."/34#metric=playerscore&partition=1&class="..className.."&spec="..spec
end