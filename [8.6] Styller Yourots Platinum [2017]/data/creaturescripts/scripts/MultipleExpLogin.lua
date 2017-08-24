local config = getBooleanFromString(getConfigInfo('experienceStages'))


function onLogin(cid)
registerCreatureEvent(cid, "MultipleExp")
if(config) then
		exp = getExperienceStage(getPlayerLevel(cid), getVocationInfo(getPlayerVocation(cid)).experienceMultiplier)
end
local players = getPlayersOnline()

if(#players >= 19 and #players <= 59) then
    for _, pid in ipairs(players) do
		if isPremium(pid) then
		doPlayerSetRate(pid, SKILL__LEVEL, 1.1)
		else
		doPlayerSetRate(pid, SKILL__LEVEL, 1.0)
    end
end
if isPremium(cid) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "--[MultipleExp System]--\nPlayers Online : "..#players.."\nSeu Exp Foi Atualizado Para : ("..exp.."x + 0.5x)")
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "--[MultipleExp System]--\nPlayers Online : "..#players.."\nSeu Exp Foi Atualizado Para : ("..exp.."x)")
end

elseif(#players >= 60) then
    for _, pid in ipairs(players) do
		if isPremium(pid) then
		doPlayerSetRate(pid, SKILL__LEVEL, 1.2)
		else
		doPlayerSetRate(pid, SKILL__LEVEL, 1.1)
    end
end
if isPremium(cid) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "--[MultipleExp System]--\nPlayers Online : "..#players.."\nSeu Exp Foi Atualizado Para : ("..exp.."x + 0.5x + 0.5x)")
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "--[MultipleExp System]--\nPlayers Online : "..#players.."\nSeu Exp Foi Atualizado Para : ("..exp.."x + 0.5x)")
end
end
return true
end