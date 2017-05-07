local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
	name = "Lobby",
	color = Vector(0,0,1.0),
	weapons = {}
}

teams[1] = {
	name = "Active",
	color = Vector(1.0,1.0,1.0),
	weapons = {"weapon_crowbar","weapon_pistol","weapon_shotgun",}
}

function ply:SetupTeam(n)
	if ( not teams[n] ) then return end

	self:SetTeam( n )
	self:SetPlayerColor( teams[n].color )
	self:SetHealth(100)
	self:SetMaxHealth(200)
	self:SetModel( "models/player/Group03/Male_0"..math.random(1,9)..".mdl" )
	self:SetCanZoom( false )

	self:GiveWeapons( n )
end

function ply:GiveWeapons( n )
	for k, weapon in pairs( teams[n].weapons ) do
		self:Give( weapon )
	end
end