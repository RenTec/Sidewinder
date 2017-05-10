function GM:DoPlayerDeath( ply, attacker, dmginfo )

	ply:CreateRagdoll()
	ply:AddDeaths( 1 )

	if ( attacker:IsValid() && attacker:IsPlayer() ) then
		if ( attacker == ply ) then
			--No self punishment... yet
		else
			attacker:AddFrags( 1 )
		end
	end 
end