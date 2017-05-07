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