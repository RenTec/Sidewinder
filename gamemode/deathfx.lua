hook.Add("PlayerDeath","DoPlayerDeath",function(victim,inflictor,attacker)
	victim:SetVelocity(Vector(0,0,500)*1000)
end)