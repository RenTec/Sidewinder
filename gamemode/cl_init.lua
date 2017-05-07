include( "shared.lua" )
include( "cl_hud.lua" )

local view_distance = CreateClientConVar("sw_cam_dist",300,true,false,"Distance of camera from player")
local view_fov = CreateClientConVar("sw_cam_fov",80,true,false,"Set the player camera FOV")
local view_names = CreateClientConVar("sw_floaty_names",0,true,false,"Show players names over their heads.")

gui.EnableScreenClicker(true)

-- CREDIT TO "CayonKanade" FOR DROPNEXT LOGIC FUNCTION
local dropnext = 0
hook.Add("Think","drop_weapons",function ()

	if IsValid(LocalPlayer()) and IsValid(LocalPlayer():GetActiveWeapon()) then
		if input.IsKeyDown( KEY_F ) then
			if dropnext > CurTime() then return true end
			dropnext = CurTime() + 0.5
			net.Start("DropWeapon")
			net.WriteEntity( LocalPlayer():GetActiveWeapon() ) 
			net.SendToServer()
		end
	end
end)

local function MyCalcView( ply, pos, angles, fov )

	local view = {}

	view.origin = pos - Vector(0,view_distance:GetInt(),-30)
	view.angles = Angle(0,90,0)
	view.fov = view_fov:GetInt()
	view.drawviewer = true

	return view
end

hook.Add( "CalcView", "MyCalcView", MyCalcView )