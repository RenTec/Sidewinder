AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "teamsetup.lua" )
AddCSLuaFile( "shared.lua" )

include( "teamsetup.lua" )
include("deathfx.lua")
include( "shared.lua" )

function GM:Initialize()
	util.AddNetworkString("DropWeapon")
end

function GM:PlayerSpawn( ply )
	ply:SetupTeam( 1 )
end

net.Receive( "DropWeapon", function( len, pl )
	if ( IsValid( pl ) and pl:IsPlayer() ) then
		pl:DropWeapon(net.ReadEntity())
	end
end )

util.AddNetworkString( "help" )

function GM:ShowHelp( ply )
	net.Start( "help" )
	net.Send( ply )
end

hook.Add("KeyPress", "DoubleJump", function(pl, k)
	if not pl or not pl:IsValid() or k~=2 then
		return
	end
		
	if not pl.Jumps or pl:IsOnGround() then
		pl.Jumps=0
	end
	
	if pl.Jumps==2 then return end
	
	pl.Jumps = pl.Jumps + 1
	if pl.Jumps==2 then
		local ang = pl:GetAngles()
		local forward, right = ang:Forward(), ang:Right()
		
		local vel = -1 * pl:GetVelocity() -- Nullify current velocity
		vel = vel + Vector(0, 0, 300) -- Add vertical force
		
		local spd = pl:GetMaxSpeed()
		
		if pl:KeyDown(IN_FORWARD) then
			vel = vel + forward * spd
		elseif pl:KeyDown(IN_BACK) then
			vel = vel - forward * spd
		end
		
		if pl:KeyDown(IN_MOVERIGHT) then
			vel = vel + right * spd
		elseif pl:KeyDown(IN_MOVELEFT) then
			vel = vel - right * spd
		end
		
		pl:SetVelocity(vel)
	end
end)