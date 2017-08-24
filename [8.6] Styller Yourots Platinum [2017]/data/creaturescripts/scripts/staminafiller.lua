function onAttack(cid, target)

local storage = 19387
local tempo = 133 ----(numero de ataques em um minuto)
local minutes = 5
if isMonster(target) and getCreatureName(target):lower() == 'target' then
doPlayerSetStorageValue(cid, storage, getPlayerStorageValue(cid, storage)+1)
if getPlayerStorageValue(cid, storage) >= tempo then
doPlayerAddStamina(cid, minutes)
doPlayerSetStorageValue(cid, storage, 0)
end
end
return true
end