
--        ____.               __ ___________      .__                 __   
--       |    |__ __  _______/  |\__    ___/____  |  |   ____   _____/  |_ 
--      |    |  |  \/  ___/\   __\|    |  \__  \ |  | _/ __ \ /    \   __\
-- /\__|    |  |  /\___ \  |  |  |    |   / __ \|  |_\  ___/|   |  \  |  
-- \________|____//____  > |__|  |____|  (____  /____/\___  >___|  /__|  
--                     \/                     \/          \/     \/      

local LibStub = _G.LibStub
local Self = LibStub("AceAddon-3.0"):NewAddon("JustTalent", "AceConsole-3.0")

local ADDON_NAME, private = ...

local JTGUI = private.ImportLib("JTGUI")
local JTUtils = private.ImportLib("JTUtils")

local frame = CreateFrame

-- char, realm, class, race, faction, factionrealm, profile, global
local default = {
    profile = {
        settings = true,
        isFrameOpen = false
    }
}

local className = {
    ["Démoniste"] = {
        ["name"] = "warlock",
        ["spec"] = {
            [""] = "",
            [""] = "",
            [""] = ""
        }
    },
    ["Guerrier"] = {
        name = "warrior",
    },
    ["Chaman"] = {
        name = "shaman",
    },
    ["Voleur"] = {
        name = "rogue",
    },
    ["Prêtre"] = {
        name = "priest",
    },
    ["Paladin"] = {
        name = "paladin",
    },
    ["Moine"] = {
        name = "monk",
    },
    ["Mage"] = {
        name = "mage"
    },
    ["Chasseur"] = {
        name = "hunt"
    },
    ["Evocateur"] = {
        name = "evoker"
    },
    ["Druide"] = {
        name = "druid"
    },
    ["Chasseur de démon"] = {
        name = "demon-hunter"
    },
    ["Chevalier de la mort"] = {
        name = "death-knight"
    }
}

function Self:GetSpecInfo(key)
    local id, name, desc, icon, role = GetSpecializationInfo(GetSpecialization())
    return JTUtils.case(key) {
        id=id,
        name=name,
        desc=desc,
        icon=icon,
        role=role
    }
end

-----------------------------------------------------------------------
-- Addon Lifecycle
-----------------------------------------------------------------------

function Self:OnInitialize()
    private.db = LibStub("AceDB-3.0"):New("JustTalentDB", default, true)
    local name, realm = UnitFullName("player")
    private.db.profile.name = name
    private.db.profile.realm = realm
    private.db.profile.faction = UnitFactionGroup("player")
    private.db.profile.className = UnitClass("player")
    Self:Print("[Event] Lifecycle: Initialized " ..private.db.profile.name .. "-" .. private.db.profile.realm .. " !")
end

function Self:OnEnable()
    Self:Print("[Event] Lifecycle: Enabled " ..private.db.profile.name .. "-" .. private.db.profile.realm .. " !")
end

function Self:OnDisable()
    Self:Print("[Event] Lifecycle: Disabled" ..private.db.profile.name .. "-" .. private.db.profile.realm .. " !")
end

-----------------------------------------------------------------------
-- Register Slash command Main Frame
-----------------------------------------------------------------------
Self:RegisterChatCommand("jt", "SlashCommandOpenMainFrame")

function Self:SlashCommandOpenMainFrame()
    if(private.db.profile.isFrameOpen == false) then
        private.db.profile.isFrameOpen = true
        frame = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
        frame:SetMovable(JTGUI.config.frame.isMovable)
        frame:SetResizable(JTGUI.config.frame.isResizable)
        frame:EnableMouse(JTGUI.config.frame.isMouseEnabled)
        frame:SetSize(JTGUI.config.frame.size.width, JTGUI.config.frame.size.height)
        frame:SetFrameLevel(JTGUI.config.frame.level)
        frame:SetToplevel(JTGUI.config.frame.isTopLevel)
        frame:SetBackdrop(JTGUI.config.frame.backdrop)
        frame:SetPoint("CENTER")
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", function(self, button)
            self:StartMoving()
        end)
        frame:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)

        local icon = CreateFrame("Frame", nil, frame)
        icon:SetPoint("CENTER")
        icon:SetSize(64, 64)
        icon.tex = icon:CreateTexture()
        icon.tex:SetAllPoints(icon)
        icon.tex:SetTexture(self:GetSpecInfo('icon'))

        JTGUI.TextView(
            JTGUI.config.widgets.textViewSearch,
            JTGUI.config.widgets.textViewSearch.text.." "..JTUtils.SetPlayerFullName(private.db.profile.realm,private.db.profile.name),
            frame
        )

        JTGUI.TextView(
            JTGUI.config.widgets.textViewInfo,
            private.db.profile.className.." "..self:GetSpecInfo("name"),
            frame
        )


        JTGUI.Button(
            JTGUI.config.widgets.btnSearch,
            frame,
            function()
                local msg = JTUtils.SetWarcraftLogLink(370,className[private.db.profile.className],self:GetSpecInfo("name"))
                SendSystemMessage()
            end
        )

        JTGUI.Button(
            JTGUI.config.widgets.btnClose,
            frame,
            function ()
                private.db.profile.isFrameOpen = false
                frame:Hide()
            end
        )
    else
        private.db.profile.isFrameOpen = false
        frame:Hide()
    end
end

-----------------------------------------------------------------------
-- GUI
-----------------------------------------------------------------------