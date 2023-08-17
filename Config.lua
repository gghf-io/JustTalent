
local JustTalentMessage = {
    firstMessage = function (PlayerName)
        local text = "Bienvenue dans JustTalent, " .. PlayerName .. "!"
        message(text)
    end
}
local JustTalentMessageHandler = {
    firstMessage = function (PlayerName)
        local nameExists = string.len(PlayerName) > 0
    
        if(nameExists) then
            JustTalentMessage:firstMessage(PlayerName)
        else
            local playerName = UnitName("player")
            JustTalentMessage:firstMessage(playerName)
        end
    end
}