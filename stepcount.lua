local MODULE_TAG = "[Stepcount]"
local t = {}

local function write_step_count(filename, actor)
    local filename = t["filename"]
    local DateFormat = "%04d%02d%02d-%02d%02d%02d"
    local DateFormat2 = "%04d-%02d-%02d %02d:%02d:%02d"
    local datestr = DateFormat:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())        
    local datestr2 = DateFormat2:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())
    local profileSlot = {
            [PLAYER_1] = "ProfileSlot_Player1",
            [PLAYER_2] = "ProfileSlot_Player2"
        }
    local msgbox = {
            [PLAYER_1] = actor:GetChild("CountP1"),
            [PLAYER_2] = actor:GetChild("CountP2")
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
        local msg = msgbox[player]
        msg:settext("✔ Steps: " .. notesHitThisGame)
    end
end

t["filename"] = ""

t["ScreenTitleMenu"] = Def.ActorFrame {
    InitCommand = function(self)
        self:xy(10, 35):zoom(0.8):halign(1)
    end,
    ModuleCommand=function(self)
        local bmt = self:GetChild("Status")
        if not bmt then return end
        local DateFormat = "%04d%02d%02d-%02d%02d%02d"
        local datestr = DateFormat:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())        
        local filename = "steps-" .. datestr .. ".json"
        t["filename"] = filename
        bmt:settext("✔ Step Count")
    end,
    LoadFont("Common Normal") .. {
    Name = "Status",
    InitCommand = function(self)
      self:halign(0)
      self:settext("❌ Step Count")
    end
  },
}

t["ScreenEvaluationStage"] = Def.ActorFrame {
	ModuleCommand=function(self)
        write_step_count(t["filename"], self)
    end,
    LoadFont("Common Normal") .. {
        Name = "CountP1",
        InitCommand = function(self)
            self:xy(10, _screen.h - 65):zoom(0.6):halign(0)
            self:settext("❌")
        end
    },
    LoadFont("Common Normal") .. {
        Name = "CountP2",
        InitCommand = function(self)
            self:xy(_screen.w - 10, _screen.h - 65):zoom(0.6):halign(1)
            self:settext("❌")
        end
    }
}

t["ScreenEvaluationSummary"] = Def.ActorFrame {
	ModuleCommand=function(self)
        write_step_count(t["filename"], self)
    end,
    LoadFont("Common Normal") .. {
        Name = "CountP1",
        InitCommand = function(self)
            self:xy(10, _screen.h - 48):zoom(0.8):halign(0)
            self:settext("")
        end
    },
    LoadFont("Common Normal") .. {
        Name = "CountP2",
        InitCommand = function(self)
            self:xy(_screen.w - 10, _screen.h - 48):zoom(0.8):halign(1)
            self:settext("")
        end
    }
}

return t
