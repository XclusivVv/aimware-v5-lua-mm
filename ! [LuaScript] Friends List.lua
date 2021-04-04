-------------------------------------------
---------    Friends List v0.1    ---------
---------  Created By: Agentsix1  ---------
---------      Date: 2/15/2021    ---------
-------------------------------------------
--------- Tester(s):              ---------
--------- GameChampCrafted        ---------
-------------------------------------------
--
-- This is a product of the G&A Development Team
--
local _var_friends_a = { ",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",",",",
					",",",",",",",",",",",",",",",",",","-" }
local _var_default ="unused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a\nunused,n/a"
local _var_file = ""
local _var_launch = true
--
-- GUI
local _x_gaf_groupbox = 16
local _y_gaf_groupbox = 16
local _gui_ref_visuals = gui.Reference("Misc")
local _gui = gui.Tab(_gui_ref_visuals, "FL_gui", "Friend List")
local _gaf_groupbox = gui.Groupbox(_gui, "Friend List", _x_gaf_groupbox, _y_gaf_groupbox)
--
local _gaf_button_invite = gui.Button(_gaf_groupbox, "Invite", invite_friend)
_gaf_button_invite:SetPosX(448)
local _gaf_button_edit = gui.Button(_gaf_groupbox, "Edit", edit_friend)
_gaf_button_edit:SetPosX(448)
local _gaf_editbox_name = gui.Editbox(_gaf_groupbox, "FL_editbox_name", "Set Friend Name")
_gaf_editbox_name:SetPosX(448)
_gaf_editbox_name:SetWidth(128)
_gaf_editbox_name:SetInvisible(true)
local _gaf_editbox_code = gui.Editbox(_gaf_groupbox, "FL_editbox_code", "Set Friend Code")
_gaf_editbox_code:SetPosX(448)
_gaf_editbox_code:SetWidth(128)
_gaf_editbox_code:SetInvisible(true)
local _gaf_button_save = gui.Button(_gaf_groupbox, "Save", save_friend)
_gaf_button_save:SetPosX(448)
_gaf_button_save:SetInvisible(true)
local _gaf_button_delete = gui.Button(_gaf_groupbox, "Delete", delete_friend)
_gaf_button_delete:SetPosX(448)

local _gaf_listbox_friends = gui.Listbox(_gaf_groupbox, "FL_listbox", 400, " ")
_gaf_listbox_friends:SetWidth(432)
_gaf_listbox_friends:SetPosY(0)

--
--The Dirty Code
--
function invite_friend()
		
		send()
end
function send()
	local player = entities.GetLocalPlayer()
	if player ~= nil then
		return
	end
	local selectedId = _gaf_listbox_friends:GetValue()+1
	local code = getCode(selectedId)
	local name = getName(selectedId)
	panorama.RunScript([[
		invites.push("]]..code..[[");
		$.Msg(`Invite for ]]..name..": "..code..[[ has been added to list for invites`);
	]])
	
end
--
function save_friend()
	local selectedId = _gaf_listbox_friends:GetValue()+1
	setName(selectedId, _gaf_editbox_name:GetValue())
	setCode(selectedId, _gaf_editbox_code:GetValue())
	setFile()
	setOptions()
	_gaf_editbox_name:SetInvisible(true)
	_gaf_editbox_code:SetInvisible(true)
	_gaf_button_save:SetInvisible(true)
end
--
function edit_friend()
	_gaf_editbox_name:SetInvisible(false)
	_gaf_editbox_code:SetInvisible(false)
	_gaf_button_save:SetInvisible(false)
	local selectedId = _gaf_listbox_friends:GetValue()+1
	_gaf_editbox_name:SetValue(getName(selectedId))
	_gaf_editbox_code:SetValue(getCode(selectedId))
end
--
function delete_friend()
	local selectedId = _gaf_listbox_friends:GetValue()+1
	setName(selectedId, "unused")
	setCode(selectedId, "n/a")
	setFile()
	setOptions()
end
--
function main()
	if _var_launch then
		loadFile()
		setOptions()
		_var_launch = false
		panorama.RunScript([[ var invites = []; var temp_invites = [];]])	
	end
	if code == "n/a" then
		return
	end
	local player = entities.GetLocalPlayer()
	if player ~= nil then
		return
	end
	panorama.RunScript([[
		if (invites.length > 0) {
			for (i = 0; i < invites.length; i++) {
				var xuid = FriendsListAPI.GetXuidFromFriendCode(invites[i]);
				if (FriendsListAPI.IsFriendInvited(xuid)) {
					FriendsListAPI.ActionInviteFriend(xuid, '');
					$.Msg(`Invited user with invite code: ` + invites[i]);
				} else {
					temp_invites.push(invites[i]);
					FriendsListAPI.ActionInviteFriend(xuid, '');
					$.Msg(`Invited user with invite code: ` + invites[i]);
				}
				
			}
			invites = temp_invites;
			temp_invites = [];
		}
	
	]])
end

function changeFriendInfo( txt, id )
	_var_friends_a[id] = txt
end

function loadFile()
	local f = file.Open( "friends.txt", "a" )
	if f:Size() == 0 then
	f:Write(_var_default)
	end
	f:Close()
	local f = file.Open( "friends.txt", "r" )
	local read_file = f:Read()
	f:Close()
	local i = 1
	local readfile = ""
	for s in read_file:gmatch("[^\r\n]+") do
		_var_friends_a[i] = s
		if readfile == "" then
			readfile = s
		else
			readfile = readfile .. "\n" .. s
		end
		i = i + 1
	end
	repeat
		_var_friends_a[i] = "-"
		i = i + 1
	until (i > 51)
	_var_file = readfile
end

function saveFile()
	local f = file.Open( "friends.txt", "w" );
	f:Write( _var_file )
	f:Close();
end

function updateFile()
	local readfile = ""
	local i = 1
	repeat
		if readfile == "" then
			readfile = _var_friends_a[i]
		else
			readfile = readfile .. "\n" .. _var_friends_a[i]
		end
		i = i + 1
	until (i > 51)
	_var_file = readfile
end

function getCode( id )
	local code = split(_var_friends_a[id], ",")[2]
	if code == nil then
		return "n/a"
	else
		return code
	end
	
	
end

function getName( id )
	local name = split(_var_friends_a[id], ",")[1]
	if name == nil then
		return "unused"
	else
		return name
	end
end

function setName( id, name )
	local code = getCode(id)
	_var_friends_a[id] = name .. "," .. code
end

function setCode( id, code )
	local name = getName(id)
	_var_friends_a[id] = name .. "," .. code
end

function setFile()
	local i = 1
	local file = ""
	repeat
		if file == "" then
			file = getName(i) .. "," .. getCode(i)
		else
			file = file .. "\n" .. getName(i) .. "," .. getCode(i)
		end
		 
		i = i + 1
	until (i > 51)
	_var_file = file
	saveFile()
	loadFile()
end

function setOptions()
	_gaf_listbox_friends:SetOptions(
		getName(1),getName(2),getName(3),getName(4),getName(5),getName(6),getName(7),getName(8),getName(9),
		getName(10),getName(11),getName(12),getName(13),getName(14),getName(15),getName(16),getName(17),getName(18),getName(19),
		getName(20),getName(21),getName(22),getName(23),getName(24),getName(25),getName(26),getName(27),getName(28),getName(29),
		getName(30),getName(31),getName(32),getName(33),getName(34),getName(35),getName(36),getName(37),getName(38),getName(39),
		getName(40),getName(41),getName(42),getName(43),getName(44),getName(45),getName(46),getName(47),getName(48),getName(49),
		getName(50),getName(51))
end

function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
    return elements
end

callbacks.Register("Draw", "Friend_List", main)