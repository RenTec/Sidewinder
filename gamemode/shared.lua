GM.Name = "Sidewinder"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

function GM:Initialize()
end

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

	if cmd:KeyDown( IN_FORWARD ) then -- IF W
		cmd:SetButtons( IN_JUMP )
	elseif cmd:KeyDown( IN_MOVERIGHT ) then -- IF D
		cmd:SetSideMove(0)
		cmd:SetForwardMove(200)
	elseif cmd:KeyDown( IN_MOVELEFT ) then -- IF A
		cmd:SetSideMove(0)
		cmd:SetForwardMove(-200)
	elseif cmd:KeyDown( IN_BACK ) then -- IF S
		cmd:SetButtons( IN_DUCK )
	elseif not cmd:KeyDown(0) then
		cmd:ClearMovement()
	end
end