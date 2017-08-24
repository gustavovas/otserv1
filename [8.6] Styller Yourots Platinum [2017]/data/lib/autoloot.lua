info = {
	AutomaticDeposit = true,
	BlockMonsters = {},
	BlockItemsList = {2123,2515},
	Max_Slots = {free = 2, premium = 5},
	storages = {27000,28001,28002}
}
function getAutoLootTime(cid)
	return db.getResult("SELECT `loot_time` FROM `accounts` WHERE `id` = "..getPlayerAccountId(cid)):getDataInt("loot_time")
end
function setAutoLootTime(cid, time)
	return db.query("UPDATE `accounts` SET `loot_time` = "..time.." WHERE `id` = "..getPlayerAccountId(cid))
end
function getAutoLootDays(cid)
	local days = math.ceil((getAutoLootTime(cid) - os.time())/(86400))
	return days <= 0 and 0 or days
end
function addAutoLootDays(cid, days)
	local add = (days <= 0 and 1 or days)*86400
	local time = getAutoLootDays(cid) == 0 and (os.time() + add) or (getAutoLootTime(cid) + add)
	return setAutoLootTime(cid, time) 
end
function setPlayerStorageTable(cid, storage, tab)
	local tabstr = "&"
	for i,x in pairs(tab) do
		tabstr = tabstr .. i .. "," .. x .. ";"
	end
	setPlayerStorageValue(cid, storage, tabstr:sub(1, #tabstr-1))
end
function getPlayerStorageTable(cid, storage)
	local tabstr = getPlayerStorageValue(cid, storage)
	local tab = {}
	if type(tabstr) ~= "string" then
		return {}
	end
	if tabstr:sub(1,1) ~= "&" then
		return {}
	end
	local tabstr = tabstr:sub(2, #tabstr)
	local a = string.explode(tabstr, ";")
	for i,x in pairs(a) do
		local b = string.explode(x, ",")
		tab[tonumber(b[1]) or b[1]] = tonumber(b[2]) or b[2]
	end
	return tab
end
function isInTable(cid, item)
	for _,i in pairs(getPlayerStorageTable(cid, info.storages[1]))do
		if tonumber(i) == tonumber(item) then
			return true
		end
	end
	return false
end
function addItemTable(cid, item)
	local x = {}
	for i = 1,#getPlayerStorageTable(cid, info.storages[1]) do
		table.insert(x,getPlayerStorageTable(cid, info.storages[1])[i])
	end
	if x ~= 0 then
		table.insert(x,tonumber(item))
		setPlayerStorageTable(cid, info.storages[1], x)
	else
		setPlayerStorageTable(cid, info.storages[1], {item})
	end
end
function removeItemTable(cid, item)
	local x = {}
	for i = 1,#getPlayerStorageTable(cid, info.storages[1]) do
		table.insert(x,getPlayerStorageTable(cid, info.storages[1])[i])
	end
	for i,v in ipairs(x) do
		if tonumber(v) == tonumber(item) then
			table.remove(x,i)
		end
	end
	return setPlayerStorageTable(cid, info.storages[1], x)
end
function ShowItemsTabble(cid)
	local n,str = 0,"[+] Auto Loot Commands [+]\n\n!autoloot item name --> To add ou Remove item from list.\n!autoloot money --> To collect gold automatically.\n!autoloot clear --> To clear the list.\n\nTime: "..(getAutoLootTime(cid) > 0 and "you have ["..getAutoLootDays(cid).."] days --> ends in "..os.date("%d/%m/%y %X", getAutoLootTime(cid)).."." or "no have Auto Loot time.").."\nGold Collecting: "..(getPlayerStorageValue(cid, info.storages[2]) > 0 and "Activated" or "Disabled")..".\nBalance Total: ["..getPlayerBalance(cid).."] gp's.\nMaximum Slots: ["..#getPlayerStorageTable(cid, info.storages[1]).."/"..(vip.hasVip(cid) and info.Max_Slots.premium or info.Max_Slots.free).."]\n\n[+] Auto Loot Slots [+]\n\n"
	for i = 1,#getPlayerStorageTable(cid, info.storages[1]) do
		n = n + 1
		str = str.."Slot "..n.." - "..getItemNameById(getPlayerStorageTable(cid, info.storages[1])[i]).."\n"
	end
	return doPlayerPopupFYI(cid, str)
end
function getContainerItems(containeruid)
	local items = {}
	local containers = {}
	if type(getContainerSize(containeruid)) ~= "number" then
		return false
	end
	for slot = 0, getContainerSize(containeruid)-1 do
		local item = getContainerItem(containeruid, slot)
		if item.itemid == 0 then
			break
		end
		if isContainer(item.uid) then
			table.insert(containers, item.uid)
		end
		table.insert(items, item)
	end
	if #containers > 0 then
		for i,x in ipairs(getContainerItems(containers[1])) do
			table.insert(items, x)
		end
		table.remove(containers, 1)
	end
	return items
end
function getItemsInContainerById(container, itemid) -- Function By Kydrai
	local items = {}
	if isContainer(container) and getContainerSize(container) > 0 then
		for slot=0, (getContainerSize(container)-1) do
			local item = getContainerItem(container, slot)
			if isContainer(item.uid) then
				local itemsbag = getItemsInContainerById(item.uid, itemid)
				for i=0, #itemsbag do
					table.insert(items, itemsbag[i])
				end
			else
				if itemid == item.itemid then
					table.insert(items, item.uid)
				end
			end
		end
	end
	return items
end
function doPlayerAddItemStacking(cid, itemid, amount) -- revisado
	local item, _G = getItemsInContainerById(getPlayerSlotItem(cid, 3).uid, itemid), 0
	if #item > 0 then
		for _ ,x in pairs(item) do
			local ret = getThing(x)
			if ret.type < 100 then
				doTransformItem(ret.uid, itemid, ret.type+amount) 
				if ret.type+amount > 100 then
					doPlayerAddItem(cid, itemid, ret.type+amount-100)
				end
				break
			else
				_G = _G+1
			end
		end
		if _G == #item then
			doPlayerAddItem(cid, itemid, amount)
		end
	else
		return doPlayerAddItem(cid, itemid, amount)
	end
end
function AutomaticDeposit(cid,item,n)
	local deposit = item == tonumber(2160) and (n*10000) or tonumber(item) == 2152 and (n*100) or (n*1)
	return doPlayerDepositMoney(cid, deposit)
end
function corpseRetireItems(cid, pos)
	local check = false
	for i = 0, 255 do
		pos.stackpos = i
		tile = getTileThingByPos(pos)
		if tile.uid > 0 and isCorpse(tile.uid) then
			check = true break
		end
	end
	if check == true then
		local items = getContainerItems(tile.uid)
		for i,x in pairs(items) do
			if isInArray(getPlayerStorageTable(cid, info.storages[1]), tonumber(x.itemid)) or getPlayerStorageValue(cid, info.storages[2]) > 0 and isInArray({2148,2152,2160},tonumber(x.itemid)) then
				if isItemStackable(x.itemid) then
					doPlayerAddItemStacking(cid, x.itemid, x.type)
					if info.AutomaticDeposit == true and isInArray({2148,2152,2160}, tonumber(x.itemid)) then
						AutomaticDeposit(cid,x.itemid,x.type)
					end
				else
					doPlayerAddItem(cid, x.itemid)
				end
				doRemoveItem(x.uid)
			end
		end
	end
end