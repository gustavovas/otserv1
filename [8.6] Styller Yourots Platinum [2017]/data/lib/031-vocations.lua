function isSorcerer(cid)
return (isInArray({1,5,9}, getPlayerVocation(cid)) == TRUE)
end

function isDruid(cid)
return (isInArray({2,6,10}, getPlayerVocation(cid)) == TRUE)
end

function isPaladin(cid)
return (isInArray({3,7,11}, getPlayerVocation(cid)) == TRUE)
end

function isKnight(cid)
return (isInArray({4,8,12}, getPlayerVocation(cid)) == TRUE)
end

function isRookie(cid)
return (isInArray({0}, getPlayerVocation(cid)) == TRUE)
end
