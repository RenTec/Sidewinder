GM.Name = "Sidewinder"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
end

local insults = {
	"shitshark cockroach",
	"colon hogger",
	"idle-minded twat bender",
	"gloryhole rider",
	"unhuman turd bandit sniffer",
	"failed spunk lover",
	"waffle packer",
	"foolish lorry fondler",
	"semen tranny",
	"demonizing sperm handler",
	"dandy fuck barrel jacker",
	"dumb tit infidel",
	"animal-fondling wagon amputee",
	"raging sphincter felcher",
	"poop mange",
	"arse professor",
	"assbackward pirate experiment",
	"fuckfaced cum stain graduate",
	"cockmunching asswad hole",
	"clouted butt sod wanker",
	"long-titted cocksplurt basher"
}

team.SetUp(0,"lobby",Color(0,0,255))
team.SetUp(1,"active",Color(255,255,255))

function GM:StartCommand(ply, cmd)

	if CLIENT then
		local aw = ScrW()
		if gui.MouseX() >= (aw/2) then
			ax = 0
		else
			ax = 180
		end
		cmd:SetViewAngles(Angle(0,ax,0))
	end
end


local CMoveData = FindMetaTable( "CMoveData" )

function CMoveData:RemoveKeys( keys )
	-- Using bitwise operations to clear the key bits.
	local newbuttons = bit.band( self:GetButtons(), bit.bnot( keys ) )
	self:SetButtons( newbuttons )
end

local next_insult = 0
hook.Add( "SetupMove", "Disable Jumping", function( ply, mvd, cmd )
	if mvd:KeyDown( IN_JUMP ) then
		mvd:RemoveKeys( IN_JUMP )
		if SERVER then
			if next_insult > CurTime() then return true end
				next_insult = CurTime() + 5
			ply:Say(insults[math.random( 1, #insults)].."!")
		end
	end
end )