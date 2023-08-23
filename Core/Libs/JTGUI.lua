-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local LibStub = _G.LibStub
local ADDON_NAME, private = ...

local JTGUI = private.NewLib("JTGUI")

JTGUI.config = {
    frame = {
        size = {
            width = 400,
            height = 200
        },
        isResizable = false,
        isMovable = true,
        isMouseEnabled = true,
        isTopLevel = true,
        position = "CENTER",
        level = 100,
        backdrop = BACKDROP_TUTORIAL_16_16
    },
    widgets = {
        ["btnSearch"] = {
            ["size"] = {
                ["width"] = 150,
                ["height"] = 35,
            },
            ["position"] = {
                ["layout"] = "BOTTOM",
                ["x"] = 0,
                ["y"] = 14
            },
            ["text"] = "Rechercher"
        },
        ["btnClose"] = {
            ["size"] = {
                ["width"] = 100,
                ["height"] = 35,
            },
            ["position"] = {
                ["layout"] = "BOTTOMRIGHT",
                ["x"] = -16,
                ["y"] = 14
            },
            ["text"] = "Fermer"
        },
        ["textViewSearch"] = {
            ["id"] = "$frameLabelSearch",
            ["position"] = {
                ["layout"] = "TOP",
                ["x"] = 0,
                ["y"] = -20
            },
            ["typo"] = "GameFontNormalHuge2",
            ["text"] = "La recherche s'effectue sur"
        },
        ["textViewInfo"] = {
            ["id"] = "$frameLabelSearchInfo",
            ["position"] = {
                ["layout"] = "TOP",
                ["x"] = 0,
                ["y"] = -50
            },
            ["typo"] = "GameFontNormalMed2",
            ["text"] = ""
        }
    }
}

--- [Button]
-- 
-- Assign a new button config to JGUI.config.widgets with pref btn...
-- 
-- @param config
-- 
--      1. size
-- 
--          . width = Integer
-- 
--          . height = Integer
-- 
--      2. position
-- 
--          . layout = "CENTER"
-- 
--          . x = Integer
-- 
--          . y = Integer
-- 
--      3. text = String
-- 
-- @return a table of substrings
function JTGUI.Button(config, parent, OnClick)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    btn:SetSize(config.size.width, config.size.height)
    btn:SetText(config.text)
    btn:SetPoint(config.position.layout,config.position.x, config.position.y)
    btn:SetScript("OnClick", OnClick)
    return btn
end

--- [TextView]
-- 
-- Assign a new button config to JGUI.config.widgets with pref btn...
-- 
-- @param config
-- 
--      1. id = String
-- 
--      2. position
-- 
--          . layout = "CENTER"
-- 
--          . x = Integer
-- 
--          . y = Integer
-- 
--      3. text = String
-- 
-- @return a table of substrings
function JTGUI.TextView(config, text, parent)
    local textView = parent:CreateFontString(config.id, "ARTWORK", config.typo)
    textView:SetPoint(config.position.layout, config.position.x, config.position.y)
    textView:SetText(text)
    textView:SetVertexColor(1,1,1)
    return textView
end