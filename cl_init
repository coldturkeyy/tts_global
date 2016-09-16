// maybe I trusted the client 2 much in the beginning

local accents = {
    "https://www.whateveryourapi.is" // Your API URL, for example https://www.voicerss.org, https://www.ivona.com, etc.
 
}
 
local wait = true
local channels = {}
 
 
local function playvoice(ply,text,accent,speed)
    sound.PlayURL(accent..text,"3d noplay",function(channel,errorid,errorname)
        if channel == nil || errorid != nil || errorname != nil then --peniscorp backup; google is upset
            if wait == false then
                wait = true
                timer.Simple(125,function() wait = false end)
                playvoice(ply,text,accent,speed)
            end
            return
        end
        channel:SetPos(LocalPlayer():GetPos(),Vector(0,0,0))
        channel:Set3DFadeDistance(300,9999999999)
        channel:SetPlaybackRate(math.Clamp(.5+speed,.5,2))
        channel:Play()
        table.insert(channels,{channel,ply})
    end)
end
 
hook.Add("Think","TTSThink",function()
    for k, v in pairs(channels) do
        if !v[1]:IsValid() then table.remove(channels,k) return end
        if v[2] == nil ||
        v[1]:GetState() != GMOD_CHANNEL_PLAYING ||
        v[1]:GetTime() >= v[1]:GetLength() then
            v[1]:Stop()
            table.remove(channels,k)
            return
        end
        v[1]:SetPos(v[2]:GetPos(),Vector(0,0,0))
    end
end)
 
 
net.Receive( "TTSYOUDUMB", function( len, ply )
    local text = net.ReadString()
    local dotts = true
    if dotts then
            local speed,accent,nick = 1, accents[1], LocalPlayer():Nick()
            local nlen = #nick
            local vowels, vow, notvow, vrat = {"a","e","i","o","u","y"}, 0, 0, 1
            for i = 1, nlen do
                    if table.HasValue(vowels,nick[i]) then vow = vow+1 else notvow = notvow+1 end
            end
            if vow == 0 then notvow = nlen end
            vrat = vow/notvow
            accent = accents[math.Clamp(vow,1,#accents)]
            speed = vrat
            playvoice(LocalPlayer(),text,accent,speed)
        end
end )
