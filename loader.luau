local pid=game.PlaceId
if not config.type.hub then
    local kaitun=config.type.kaitun;local bfpid = {[4442272183]=true,[79091703265657]=true,[7449423635]=true,[100117331123089]=true,[114279672983750]=true,[113741252407134]=true,[2753915549]=true}
    if bfpid[pid] then
        if kaitun=="ttk"then loadstring(game:HttpGet(""))()
        elseif kaitun=="doughv2"then loadstring(game:HttpGet(""))()
        elseif kaitun=="cdk"then loadstring(game:HttpGet(""))()
        elseif kaitun=="fully"then loadstring(game:HttpGet(""))()
        elseif kaitun=="racev4"then loadstring(game:HttpGet(""))()end
    end
end
