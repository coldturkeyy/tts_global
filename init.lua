util.AddNetworkString("TTSYOUDUMB")
 
concommand.Add("speak123", function( ply, cmd, args )
    if ply:SteamID() ==  "STEAM_0:0:0" then // Change it to yours, or add a new check (or table for multiple ids).
        print(args[1])
        local newstring = table.concat( args, " " )
        print(ply)
        net.Start("TTSYOUDUMB")
        net.WriteString(newstring)
        net.Broadcast()
    end
end)
