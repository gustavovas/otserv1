-- [( Script created by Matheus for TibiaKing.com )] --
function onThink(interval, lastExecution)
MENSAGEM = {
"War of Emperium todos os dias as 20 horas! Nao perca essa batalha!",
"Explore o mapa, esta cheio de quests novas.",
"A cada addon full, voce recebera beneficios.",
"Casamento -- !marriage info",
"Compre refinador e aumente o ataque de suas armas!",
"Itens Vips podem ser adquiridos na POI.",
"Para War System -- !infowar",
"Conquiste o Castle 5 vezes e ganhe uma Soft Boots.",
"Conheça o NPC Anderson em Blue City, ele promete levar voce a varias hunts.",
"Regenere sua stamina em 1 minuto a cada 5 minutos nos trainers.",
"Sendo VIP, voce pode comprar a Second Promotion!",
"Esta afim de mais exp? Case-se com uma pessoa e ambos receberao mais exp ao upar juntos.","Compre o AutoLoot no NPC Hagar. Use !autoloot",
}
doBroadcastMessage(MENSAGEM[math.random(1,#MENSAGEM)],22)
return TRUE
end
