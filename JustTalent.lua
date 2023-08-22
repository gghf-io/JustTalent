-----------------------------------------------------------------------
-- JustTalent
-----------------------------------------------------------------------
local Self = LibStub("AceAddon-3.0"):NewAddon("JustTalent", "AceConsole-3.0")
local GUI = LibStub("AceGUI-3.0")
-- char, realm, class, race, faction, factionrealm, profile, global
-- local JustTalentDB = LibStub("AceDB-3.0"):New("JustTalentDB")

local Data = {
    player = {
        name = UnitName("player"),
        class = UnitClass("player"),
        faction = UnitFactionGroup("player"),
        spec = {
            id = -1,
            name = "",
            icon = -1,
        }
    }
}
local GUIConf = {
    frame = {
        title = "JustTalent",
        status = "JustTalent-0.0.1 --- Development mode",
        width = 320,
        height = 150,
        layout = "List",
        isResizable = false
    },
    labelSearch = {
        text = "",
        fullWidth = true
    },
    btnSearch = {
        text = "Recherche les meilleurs talents pour ton personnage",
        width = 300
    },
}

function Self:SetPlayerLink(realm,name)
    return "https://worldofwarcraft.blizzard.com/fr-fr/character/eu/" .. string.lower(realm) .. "/" .. string.lower(name)
end

-----------------------------------------------------------------------
-- Addon Lifecycle
-----------------------------------------------------------------------

-- local raceName = UnitRace("player")
-- local className = UnitClass("player")
-- local factionName = UnitFactionGroup("player")
-- local spec = 

-- self.db = JustTalentDB
-- JustTalent:SetCurrentProfile(self.db)
-- Code that you want to run when the addon is first loaded goes here.
function Self:OnInitialize()
    Self:Print("[Event] Lifecycle: Initialized for player " .. Data.playerName .. " !")
end

-- Called when the addon is enabled
function Self:OnEnable()
    Self:Print("[Event] Lifecycle: Enabled ".. Data.playerName .. " !")
end

-- Called when the addon is disabled
function Self:OnDisable()
    Self:Print("[Event] Lifecycle: Disabled")
end

-----------------------------------------------------------------------
-- Register Slash command
-----------------------------------------------------------------------
Self:RegisterChatCommand("jt", "SlashCommandOpenMainFrame")

function Self:SlashCommandOpenMainFrame()
    local frame = GUI:Create("Frame")
    frame:SetHeight(GUIConf.frame.height)
    frame:SetWidth(GUIConf.frame.width)
    frame:SetTitle(GUIConf.frame.title)
    frame:SetStatusText(GUIConf.frame.status)
    frame:SetLayout(GUIConf.frame.layout)
    frame:EnableResize(GUIConf.frame.isResizable)
    frame:SetCallback("OnClose",function(widget) GUI:Release(widget) end)

    local lblSearch = GUI:Create("Label")
    lblSearch:SetFullWidth(GUIConf.labelSearch.fullWidth)
    lblSearch:SetHeight(100)
    lblSearch:SetText(GUIConf.labelSearch.text)
    frame:AddChild(lblSearch)

    local btnSearch = GUI:Create("Button")
    btnSearch:SetText(GUIConf.btnSearch.text)
    btnSearch:SetWidth(GUIConf.btnSearch.width)
    btnSearch:SetCallback("OnClick",function() UpdateLabel(lblSearch, PrintClick()) end)
    frame:AddChild(btnSearch)
end

function PrintClick()
    local active = GetSpecialization()
    local id, name, description, icon, background, role = GetSpecializationInfo(active)
    Data.player.spec.id = id
    Data.player.spec.name = name
    Data.player.spec.icon = icon
    return "Class =" .. Data.player.class .. " | Id = ".. Data.player.spec.id .. " | name = ".. Data.player.spec.name .. " | icon = ".. Data.player.spec.icon
end

function UpdateLabel(label, text)
    label:SetText(text)
end
-----------------------------------------------------------------------
-- GUI
-----------------------------------------------------------------------