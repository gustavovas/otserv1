function onThink(interval, lastExecution)
if getGuildWinnerName() == "" and getGlobalStorageValue(frag_guild.start_frags) >= 1 then setGlobalStorageValue(frag_guild.start_frags, 0) end
return doBroadcastMessage("".. (getGuildWinnerName() == "" and "[Guild Frag System]\nA primeira guild que atingir "..frag_guild.FragsToWinAcess.." frags ganhara "..frag_guild.AcessTimeDays.." dias de acesso a areas exclusivas, para mais informações: !guildfrags" or "[Guild Frag System]\nAtualmente a Guild dominante: ["..getGuildWinnerName().."] e seu dominio termina em "..getAcessDate(getGuildWinnerName()).."") .."", 22)
end