function onThink(interval, lastExecution)
  -- Configura��es
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[Styller War - OT:   
Rank Frags: !rankfrags
Cast: !cast on
Exp: !expinfo
Inimigos Online: !warmembers
Guild Broadcast: /guild
Coloque seus itens a venda no NPC Diesel!
]]
}

  -- Fim de Configura��es

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end
