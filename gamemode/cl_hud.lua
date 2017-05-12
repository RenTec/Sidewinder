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

	if ( !base ) then
	
	local base = vgui.Create( "DFrame" )
		base:SetTitle("Sidewinder Help and Options")
		base:SetSize(ScrW()/1.5,ScrH()/1.1)
		base:SetDraggable(false)
		base:Center()
		base:MakePopup()

	local sheet = vgui.Create( "DPropertySheet", base )
		sheet:Dock( FILL )

	local panel1 = vgui.Create( "DPanel", sheet )
		panel1.Paint = function( self, w, h ) draw.RoundedBox( 2, 0, 0, w, h, Color(100, 100, 100) ) end
		sheet:AddSheet( "About", panel1, "icon16/information.png" )

	local panel2 = vgui.Create( "DPanel", sheet )
		panel2.Paint = function( self, w, h ) draw.RoundedBox( 2, 0, 0, w, h, Color(100, 100, 100) ) end
		sheet:AddSheet( "Controls", panel2, "icon16/keyboard.png" )

	local panel3 = vgui.Create( "DPanel", sheet )
		panel3.Paint = function( self, w, h ) draw.RoundedBox( 2, 0, 0, w, h, Color(100, 100, 100) ) end
		sheet:AddSheet( "Camera Options", panel3, "icon16/camera.png" )

	local panel4 = vgui.Create( "DPanel", sheet )
		panel4.Paint = function( self, w, h ) draw.RoundedBox( 2, 0, 0, w, h, Color(100, 100, 100) ) end
		sheet:AddSheet( "Sound Options", panel4, "icon16/sound.png" )

----------------------------
-------- About Page --------
----------------------------

	local About_HTML = vgui.Create( "HTML" , panel1 )
		About_HTML:Dock( FILL )
		About_HTML:OpenURL("http://dev.mirai.red/homepage/") -- Placeholder

----------------------------
------ Controls Sheet ------
----------------------------

	local ControlList = vgui.Create( "DListView", panel2 )
		ControlList:Dock(TOP)
		ControlList:SetSize(0,300)

		ControlList:AddColumn( "Control" )
		ControlList:AddColumn( "Function" )

		ControlList:AddLine( "Pressing W", "Make your player jump." )
		ControlList:AddLine( "Double Tap W", "Make your player double jump!" )
		ControlList:AddLine( "Holding A", "Make your player move left." )
		ControlList:AddLine( "Double Tap A", "Make your player dash left." )
		ControlList:AddLine( "Holding S", "Make your player crouch." )
		ControlList:AddLine( "Pressing D", "Make your player move right." )
		ControlList:AddLine( "Double Tap D", "Make your player dash right." )
		ControlList:AddLine( "Pressing Space", "Make your player taunt other players!" )
		ControlList:AddLine( "Mouse X-Axis", "Make your player face a certain 2D direction." )
		ControlList:AddLine( "Mouse Y-Axis", "Make your player aim in an up/down direction." )
		ControlList:AddLine( "Left Click", "Make your player use a weapon." )
		ControlList:AddLine( "Right Click", "Make your player use a weapons secondary feature." )
		ControlList:AddLine( "Pressing F", "Make your player drop an equipped item." )
		ControlList:AddLine( "F1", "Open the 'Help and Options' panel you see here!" )
		ControlList:AddLine( "F2", "DDOS the FBI" )

	local Mixer = vgui.Create( "DColorMixer", panel2 )
		Mixer:SetPos(10,310)
		Mixer:SetPalette( false ) 		--Show/hide the palette			DEF:true
		Mixer:SetAlphaBar( false ) 		--Show/hide the alpha bar		DEF:true
		Mixer:SetWangs( true )			--Show/hide the R G B A indicators 	DEF:true
		Mixer:SetColor( crosshair_color )	--Set the default color

	local DermaButton = vgui.Create( "DButton", panel2 )
		DermaButton:SetText( "Set crosshair color" )
		DermaButton:SetPos( 10, 545 )
		DermaButton:SetSize( 200, 30 )
		DermaButton.DoClick = function()
			crosshair_color = Mixer:GetColor()
		end

----------------------------
------ Camera Options ------
----------------------------

	local FOVSlider = vgui.Create( "DNumSlider", panel3 )
		FOVSlider:SetPos( 10, 5 )
		FOVSlider:SetSize( 300, 15 )
		FOVSlider:SetText( "Player camera FOV" )
		FOVSlider:SetMin( 60 )
		FOVSlider:SetMax( 110 )
		FOVSlider:SetDecimals( 0 )
		FOVSlider:SetConVar("sw_cam_fov")

	local DermaNumSlider = vgui.Create( "DNumSlider", panel3 )
		DermaNumSlider:SetPos( 10, 20 )
		DermaNumSlider:SetSize( 300, 15 )
		DermaNumSlider:SetText( "Player camera distance" )
		DermaNumSlider:SetMin( 100 )
		DermaNumSlider:SetMax( 400 )
		DermaNumSlider:SetDecimals( 0 )
		DermaNumSlider:SetConVar("sw_cam_dist")

	local CheckBoxThing = vgui.Create( "DCheckBoxLabel", panel3 )
		CheckBoxThing:SetPos( 10,40 )
		CheckBoxThing:SetText( "Toggle floaty names" )
		CheckBoxThing:SetConVar( "sw_floaty_names" )
		CheckBoxThing:SizeToContents()

----------------------------
------ Sound Options -------
----------------------------

	local DLabel = vgui.Create( "DLabel", panel4 )
		DLabel:SetPos( 5, 5 )
		DLabel:SetSize(500,0)
		DLabel:SetAutoStretchVertical(true)
		DLabel:SetText( "Coming Soon! Here you will be able to stream music right to your client!" )

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

net.Receive("help",function()
	F1_Menu()
end)