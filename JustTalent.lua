-----------------------------------------------------------------------
-- JustTalent
-----------------------------------------------------------------------
local JustTalent = LibStub("AceAddon-3.0"):NewAddon("JustTalent", "AceConsole-3.0")
local JustTalentGUI = LibStub("AceGUI-3.0")
local JustTalentConsole = LibStub("AceConsole-3.0")
-- char, realm, class, race, faction, factionrealm, profile, global
local JustTalentDB = LibStub("AceDB-3.0"):New("JustTalentDB")

local editBoxValuePlayerName
local editBoxValuePlayerRealm

function GetProfileName()
    return "Profil ---> " .. PlayerName
end

function JustTalent:SetProfile()
    self.db.char.current = playerName
    self.db.realm.current = realmName
    self.db.race.current = raceName
    self.db.class.current = className
    self.db.faction.current = factionName
end

-----------------------------------------------------------------------
-- Addon Lifecycle
-----------------------------------------------------------------------

-- Code that you want to run when the addon is first loaded goes here.
function JustTalent:OnInitialize()
    JustTalentConsole:Print("[Addon] JustTalent - Lifecycle: Initialized")
    local playerName = UnitName("player")
    local raceName = UnitRace("player")
    local className = UnitClass("player")
    local factionName = UnitFactionGroup("player")
    local realmName = GetRealmName()
    self.db = JustTalentDB
    self.db:SetProfile(playerName)
end

-- Called when the addon is enabled
function JustTalent:OnEnable()
    JustTalentConsole:Print("[Addon] JustTalent - Lifecycle: Enabled")
end

-- Called when the addon is disabled
function JustTalent:OnDisable()
    JustTalentConsole:Print("[Addon] JustTalent - Lifecycle: Disabled")
end

-----------------------------------------------------------------------
-- Register Slash command
-----------------------------------------------------------------------
JustTalent:RegisterChatCommand("jt", "SlashCommandWelcomePlayer")

function JustTalent:SlashCommandWelcomePlayer()
    local Frame = JustTalentGUI:Create("Frame")
    -- Create a Frame
    Frame:SetTitle("JustTalent")
    Frame:SetStatusText("JustTalent-0.0.1 --- Development mode")
    Frame:SetCallback("OnClose",function(widget) JustTalentGUI:Release(widget) end)
    -- "List", "Fill" and "Flow"
    Frame:SetLayout("List")
    Frame:EnableResize(false)
    
    -- Create a Label Player Name
    local Frame_EditBox_Name = JustTalentGUI:Create("EditBox")
    Frame_EditBox_Name:SetLabel("Entrez le nom d'un joueur :")
    Frame_EditBox_Name:SetWidth(400)
    Frame_EditBox_Name:SetCallback("OnEnterPressed", function(widget, event, text) editBoxValuePlayerName = text end)
    Frame:AddChild(Frame_EditBox_Name)

    -- Create a Label Player Name
    local Frame_EditBox_Realm = JustTalentGUI:Create("EditBox")
    Frame_EditBox_Realm:SetLabel("Entrez le nom du Serveur de ce joueur :")
    Frame_EditBox_Realm:SetWidth(400)
    Frame_EditBox_Realm:SetCallback("OnEnterPressed", function(widget, event, text) editBoxValuePlayerRealm = text end)
    Frame:AddChild(Frame_EditBox_Realm)

    -- Create a button
    local Frame_Button = JustTalentGUI:Create("Button")
    Frame_Button:SetText("Rechercher")
    Frame_Button:SetWidth(150)
    Frame_Button:SetCallback("OnClick", function() print("https://worldofwarcraft.blizzard.com/fr-fr/character/eu/" .. string.lower(editBoxValuePlayerRealm) .. "/" .. string.lower(editBoxValuePlayerName)) end)
    Frame:AddChild(Frame_Button)
end

-----------------------------------------------------------------------
-- GUI
-----------------------------------------------------------------------