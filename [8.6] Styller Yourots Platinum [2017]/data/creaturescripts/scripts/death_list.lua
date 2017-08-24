function onDeath(cid, corpse, deathList)
local str = ""
        for _, pid in ipairs(deathList) do
                if isCreature(pid) == true then
str = str.."".. (str == "" and "" or ",") ..""..getCreatureName(pid)
                else
str = str.."".. (str == "" and "" or ",") .." a field item"
                end
        end
str = str.."."
death = str .. " ".. (getPlayerBlessing(cid, 5) and "[Blessed]" or getPlayerSlotItem(cid, 2).itemid == 2173 and "[AOL]" or "")
db.query("INSERT INTO `death_list` (`player_id`, `date`, `level`, `killer_name`) VALUES ('".. getPlayerGUID(cid).."', '".. os.time() .."', '".. getPlayerLevel(cid) .."', '".. death .."');")
return true
end