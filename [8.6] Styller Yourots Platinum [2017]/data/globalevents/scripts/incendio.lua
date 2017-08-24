local premio = {
[1] = {item = 2160, count = 10},
}

local configs = {
        hours = 2, -- quantas em quantas horas, vai acontecer.
        winners = 1 -- qntos players podem ganhar.
}

function onThink(interval, lastExecution)

local p = getPlayersOnline()
local winners = configs.winners

if #p < winners then
        winners = #p
end


for i = 1, winners do
        local p = getPlayersOnline()
        local c, w = #p, #premio
        local d, e = math.random(c), math.random(w)
        local playerwin = p[d]
        doPlayerAddItem(playerwin, premio[e].item, premio[e].count)
        doBroadcastMessage("")
        if i == winners then
                doBroadcastMessage("[" .. i .. "ST PLACE] Winner: " .. getCreatureName(playerwin) .. ", Reward: " .. premio[e].count .. " " .. getItemNameById(premio[e].item) .. ", Congratulations! (Next Lottery in " .. configs.hours .. " hours.)")
        end
        doSendMagicEffect(getThingPos(playerwin), 12)
end

return true
end