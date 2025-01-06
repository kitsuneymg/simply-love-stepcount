local t = {}

t["ScreenProfileSave"] = Def.ActorFrame {
    ModuleCommand=function(self)
		local DateFormat = "%04d%02d%02d-%02d%02d%02d"
		local datestr = DateFormat:format(Year(), MonthOfYear()+1, DayOfMonth(), Hour(), Minute(), Second())
		local profileSlot = {
				[PLAYER_1] = "ProfileSlot_Player1",
				[PLAYER_2] = "ProfileSlot_Player2"
			}		
		for player in ivalues(GAMESTATE:GetHumanPlayers()) do
			local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
			local notesHitThisGame = 0
			local content = { }
			local profileDir  = PROFILEMAN:GetProfileDir(profileSlot[player])
				if stats and stats.column_judgments then
					for column, judgments in ipairs(stats.column_judgments) do
						for judgment, judgment_count in pairs(judgments) do
							-- Early hits are a stored in a table, we want to ignore those for this calculation.
							if type(judgment_count) == "number" then
								if judgment ~= "Miss" then
									notesHitThisGame = notesHitThisGame + judgment_count
								end
							end
						end
					end
				end
			end
			content.Steps = { notesHitThisGame }
			local filename = "steps-" .. datestr:gsub(':', '') .. ".json"
			local f = RageFileUtil.CreateRageFile()		
			if f:Open(profileDir .. "SL-Steps/" .. filename, 2) then
				f:Write(JsonEncode(content, true))
			end
			f:destroy()
		end
    end
}

return t