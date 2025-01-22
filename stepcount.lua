local t = {}

local function write_step_count(filename)
    local DateFormat = "%04d%02d%02d-%02d%02d%02d"
    local DateFormat2 = "%04d-%02d-%02d %02d:%02d:%02d"
    local datestr = DateFormat:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())        
    local datestr2 = DateFormat2:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())
    local profileSlot = {
            [PLAYER_1] = "ProfileSlot_Player1",
            [PLAYER_2] = "ProfileSlot_Player2"
        }
    for player in ivalues(GAMESTATE:GetHumanPlayers()) do
        local notesHitThisGame = 0
        local content = { }
        local profileDir  = PROFILEMAN:GetProfileDir(profileSlot[player])
        for i,stats in pairs( SL[ToEnumShortString(player)].Stages.Stats ) do
            if stats and stats.judgments then
                for judgment, judgment_count in pairs(stats.judgments) do
                    if string.len(judgment) == 2 then
                        notesHitThisGame = notesHitThisGame + judgment_count
                    end
                end
            end
        end
        content.Steps = { notesHitThisGame }
        content.DateTime = { datestr2 }
        
        local f = RageFileUtil.CreateRageFile()        
        if f:Open(profileDir .. "SL-Steps/" .. filename, 2) then
            f:Write(JsonEncode(content, true))
        end
        f:destroy()
        SM("Writing step count of " .. notesHitThisGame)
    end
end

t["filename"] = ""

t["ScreenTitleMenu"] = Def.ActorFrame {
    ModuleCommand=function(self)
        local DateFormat = "%04d%02d%02d-%02d%02d%02d"
        local datestr = DateFormat:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())        
        local filename = "steps-" .. datestr .. ".json"
        t["filename"] = filename
        SM("Initializing step count module: " .. datestr)
    end
}

t["ScreenEvaluationStage"] = Def.ActorFrame {
	ModuleCommand=function(self)
	    write_step_count(t["filename"])
    end
}

t["ScreenEvaluationSummary"] = Def.ActorFrame {
	ModuleCommand=function(self)
	    write_step_count(t["filename"])
    end
}

return t
