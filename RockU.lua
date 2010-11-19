
-- Slash Command
SLASH_ROCKU1 = "/rocku"
SlashCmdList["ROCKU"] = function (args) rocku_onSlash(args) end

local rocku_start = nil;
local rocku_enable = true;

function rocku_onEvent (self, event, ...)
	local unit, spellname, spellrank = ...;
	-- Is it the right Spellevent?
	if(rocku_enable and event == "UNIT_SPELLCAST_CHANNEL_START" and UnitInParty(unit) and spellname == GetSpellInfo(16914)) then -- 16914 = Hurricane
		-- check if clip is already playing
		if(rocku_start == nil or time() - rocku_start >= 24) then
			rocku_start = time();
			PlaySoundFile("Interface\\AddOns\\RockU\\rocku.mp3");
		end
	end
end

function rocku_onLoad (self)
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
	rocku_print("RockU Mod loaded!");
end

function rocku_onSlash(args)
	if(args == "enable") then
		rocku_enable = true;
		rocku_print("RockU Mod enabled!");
	elseif(args == "disable") then
		rocku_enable = false;
		rocku_print("RockU Mod disabled!");
	end
end

function rocku_print(arg)
	DEFAULT_CHAT_FRAME:AddMessage(arg)
end