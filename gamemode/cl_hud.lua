local crosshair_style = Material( "sprites/hud/v_crosshair2" ) -- Calling Material() every frame is quite expensive
local crosshair_color = Color(255,255,255)

local hud_hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudCrosshair = true,
	CHudDamageIndicator = true,
	--CHudSecondaryAmmo = true,
	--CHudWeaponSelection = true,
}

surface.CreateFont( "sw_hud_nick", {
	font = "Arial",
	extended = true,
	size = 25,
	outline = true,
} )

surface.CreateFont( "sw_hud_frags", {
	font = "DermaDefaultBold",
	size = 20,
} )

hook.Add( "HUDShouldDraw", "HideHUD", function( name )

	if ( hud_hide[ name ] ) then
		return false
	end
end )

function GM:HUDDrawTargetID()
end

local Avatar = vgui.Create( "AvatarImage", Panel )
Avatar:SetSize( 64, 64 )
Avatar:SetPos( 4, 4 )

hook.Add("HUDPaint","sidewinder_hud",function ()
Avatar:SetPlayer( LocalPlayer(), 64 )
	local ply = LocalPlayer()
	local health = ply:Health()
	local cx, cy = gui.MousePos()

	surface.SetFont("sw_hud_nick")
	surface.SetTextPos(80,5)
	surface.SetTextColor(255,255,255,255)
	surface.DrawText(ply:Nick())
	draw.RoundedBox(4,80,33,health,15,Color(200,0,0,255))
	surface.SetDrawColor(0,0,0,255)
	surface.DrawOutlinedRect(79,32,102,17)
	surface.DrawOutlinedRect(80,33,100,15)
	surface.SetFont("sw_hud_frags")
	surface.SetTextPos(80,50)
	surface.SetTextColor(255,0,0,255)
	surface.DrawText("Kills: "..ply:Frags())

	if crosshair_color == nil then
		surface.SetDrawColor( Color(255,255,255) )
	else
		surface.SetDrawColor( crosshair_color )
	end
	surface.SetMaterial( crosshair_style )
	surface.DrawTexturedRect( cx-16, cy-16, 32, 32 )
end)

local aimframe = vgui.Create( "DPanel" )
	aimframe:SetSize(ScrW(),ScrH())
	aimframe:SetVisible(true)
	aimframe:SetCursor("blank")
	function aimframe:Paint(w,h)
	end

local function F1_Menu()
	if ( !frame ) then
		local frame = vgui.Create( "DFrame" )
			frame:SetSize(ScrW()/2,ScrH()/1.5)
			frame:SetTitle("Sidewinder Help and Options")
			frame:ShowCloseButton(true)
			frame:SetVisible(true)
			frame:Center()
			frame:SetDraggable(false)
			frame:SetScreenLock(true)
			frame:MakePopup()
			frame:SetDeleteOnClose(true)

		local FOVSlider = vgui.Create( "DNumSlider", frame )
			FOVSlider:SetPos( 10, 30 )
			FOVSlider:SetSize( 300, 15 )
			FOVSlider:SetText( "Player camera FOV" )
			FOVSlider:SetMin( 60 )
			FOVSlider:SetMax( 110 )
			FOVSlider:SetDecimals( 0 )
			FOVSlider:SetConVar("sw_cam_fov")

		local DermaNumSlider = vgui.Create( "DNumSlider", frame )
			DermaNumSlider:SetPos( 10, 50 )
			DermaNumSlider:SetSize( 300, 15 )
			DermaNumSlider:SetText( "Player camera distance" )
			DermaNumSlider:SetMin( 100 )
			DermaNumSlider:SetMax( 400 )
			DermaNumSlider:SetDecimals( 0 )
			DermaNumSlider:SetConVar("sw_cam_dist")

		local Mixer = vgui.Create( "DColorMixer", frame )
			Mixer:SetPos(10,70)
			Mixer:SetPalette( false ) 		--Show/hide the palette			DEF:true
			Mixer:SetAlphaBar( false ) 		--Show/hide the alpha bar		DEF:true
			Mixer:SetWangs( true )			--Show/hide the R G B A indicators 	DEF:true
			Mixer:SetColor( crosshair_color )	--Set the default color

		local DermaButton = vgui.Create( "DButton", frame )
			DermaButton:SetText( "Set crosshair color" )
			DermaButton:SetPos( 10, 300 )
			DermaButton:SetSize( 250, 30 )
			DermaButton.DoClick = function()
				crosshair_color = Mixer:GetColor()
			end

		local CheckBoxThing = vgui.Create( "DCheckBoxLabel", frame )
			CheckBoxThing:SetPos( 300,30 )
			CheckBoxThing:SetText( "Toggle floaty names" )
			CheckBoxThing:SetConVar( "sw_floaty_names" )
			CheckBoxThing:SetValue( 0 )
			CheckBoxThing:SizeToContents()
	end
end

function HoveringNames()

	a = GetConVar("sw_floaty_names")
	if a:GetInt() == 1 then
		for _, target in pairs(player.GetAll()) do
			if target:Alive() and target != LocalPlayer() then
			
				local targetPos = target:GetPos() + Vector(0,0,84)
				local targetDistance = math.floor((LocalPlayer():GetPos():Distance( targetPos ))/40)
				local targetScreenpos = targetPos:ToScreen()
				surface.SetFont( "Trebuchet18" )
				local name = target:Nick()
				local width, height = surface.GetTextSize( name )
				draw.RoundedBox(4,tonumber(targetScreenpos.x)-(width/1.5), tonumber(targetScreenpos.y),width*1.3,height,Color(0,10,0,100))
				draw.SimpleText(name, "Trebuchet18", tonumber(targetScreenpos.x), tonumber(targetScreenpos.y), Color(30,255,200), TEXT_ALIGN_CENTER)
				
			end
		end
	end
end
hook.Add("HUDPaint", "HoveringNames", HoveringNames)

net.Receive("help",F1_Menu())