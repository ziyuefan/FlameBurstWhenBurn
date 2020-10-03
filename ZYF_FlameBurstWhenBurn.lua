local addonName,addonTable = ...

---------確認是否有載入Lib_ZYF, 若無則返回
if (Lib_ZYF == nil ) then
	print("No Lib_ZYF loaded")	
	return
end
---------
addonTable.CountOfFlameBurst = nil
addonTable.maxIgnite = 0
Lib_ZYF:SetCombatLogEvent("SPELL_AURA_APPLIED",function(...)
---------
	local 	timestamp, eventType, hideCaster,                                                                                           -- arg1  to arg3
			sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,                        -- arg4  to arg11
			spellId, spellName, spellSchool,                                                                                           -- arg12 to arg14
			amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = CombatLogGetCurrentEventInfo()       -- arg15 to arg23
			local msg
			if (sourceGUID == UnitGUID("player")) and (spellId == 190319) then 
				msg = "開始統計"..spellName.."期間炎爆數量"
				if UnitInRaid("player") then 
					SendChatMessage(msg,"say")
				else
					--SendChatMessage(msg,"guild")
					print(msg)
				end
				addonTable.CountOfFlameBurst = 0
			end
end)
Lib_ZYF:SetCombatLogEvent("SPELL_AURA_REMOVED",function(...)
---------
	local 	timestamp, eventType, hideCaster,                                                                                           -- arg1  to arg3
			sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,                        -- arg4  to arg11
			spellId, spellName, spellSchool,                                                                                           -- arg12 to arg14
			amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = CombatLogGetCurrentEventInfo()       -- arg15 to arg23
			local msg
			if (sourceGUID == UnitGUID("player")) and (spellId == 190319) then 
				msg = GetSpellLink(spellId).."結束,期間"..GetSpellLink(11366)
				msg = msg..addonTable.CountOfFlameBurst.."發"
				msg = msg..","..GetSpellLink(12654).."峰值"..addonTable.maxIgnite
				
				if UnitInRaid("player") then 
					SendChatMessage(msg,"say")
				else
					SendChatMessage(msg,"guild")
				end
				addonTable.CountOfFlameBurst = nil
				addonTable.maxIgnite = 0
			end
end)
Lib_ZYF:SetCombatLogEvent("SPELL_CAST_SUCCESS",function(...)
---------
			local 	timestamp, eventType, hideCaster,                                                                         -- arg1  to arg3
			sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,       -- arg4  to arg11
			spellId, spellName, spellSchool,                                                                          -- arg12 to arg14
			amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = ...
			local msg
			local SendChatMessage = SendChatMessage
			if (sourceGUID == UnitGUID("player")) and (spellId == 11366) then 
				if addonTable.CountOfFlameBurst then 
					addonTable.CountOfFlameBurst = addonTable.CountOfFlameBurst + 1
					msg = GetSpellLink(190319)
					msg = msg..GetSpellLink(195283)
					msg = msg..GetSpellLink(11366)
					msg = msg..addonTable.CountOfFlameBurst
					--print(msg)
					if UnitInRaid("player") then 
						SendChatMessage(msg,"say")
					else
						SendChatMessage(msg,"guild")
					end
				end
			end
end)
Lib_ZYF:SetCombatLogEvent("SPELL_PERIODIC_DAMAGE",function(...)
---------
			local 	timestamp, eventType, hideCaster,                                                                         -- arg1  to arg3
			sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,       -- arg4  to arg11
			spellId, spellName, spellSchool,                                                                          -- arg12 to arg14
			amount, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = ...
			if (sourceGUID == UnitGUID("player")) and (spellId == 12654) then 
				if amount > addonTable.maxIgnite then
					addonTable.maxIgnite = amount
					print(GetSpellLink(spellId)..amount.."(MAX:"..addonTable.maxIgnite..")")
				end
			end
end)