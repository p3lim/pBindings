local ADDON = ...
local TEXTURE = [=[Interface\ChatFrame\ChatFrameBackground]=]
local BACKDROP = {
	bgFile = TEXTURE, insets = {top = -1, bottom = -1, left = -1, right = -1}
}

local function UpdateRange(button, elapsed)
	if((button.rangeTimer or 1) > 0.2) then
		if(IsActionInRange(button.action) == 0) then
			button.icon:SetVertexColor(1, 0, 0)
		else
			button.icon:SetVertexColor(1, 1, 1)
		end

		button.rangeTimer = 0
	else
		button.rangeTimer = button.rangeTimer + elapsed
	end
end

local function UpdateButton(button)
	local texture = GetActionTexture(button.action)
	if(texture) then
		button.icon:SetTexture(texture)

		button:SetAlpha(1)
		button:EnableMouse(true)
	else
		button:SetAlpha(0)
		button:EnableMouse(false)
	end
end

function pBindings:ACTIONBAR_UPDATE_COOLDOWN()
	if(not oBindings1:IsShown()) then return end

	for index = 1, 9 do
		local button = _G['oBindings' .. index]
		if(GetActionInfo(button.action)) then
			local _, spell = GetActionInfo(button.action)
			local start, duration = GetSpellCooldown(spell)
			button.cooldown:SetCooldown(start, duration)
		end
	end
end

pBindings:HookScript('OnEvent', function(self, event, addon)
	if(event ~= 'ADDON_LOADED' or addon ~= ADDON) then return end
	self:RegisterEvent('ACTIONBAR_UPDATE_COOLDOWN')

	local _STATE = oBindings1:GetParent()
	RegisterStateDriver(_STATE, 'visibility', '[bonusbar:5] show; hide')

	local lastValue
	_STATE:HookScript('OnAttributeChanged', function(self, attribute, value)
		if(attribute == 'statehidden' and value ~= lastValue) then
			for index = 1, 9 do
				UpdateButton(_G['oBindings' .. index])
			end

			lastValue = value
		end
	end)

	for index = 1, 9 do
		local button = _G['oBindings' .. index]
		button:SetSize(26, 26)
		button:SetBackdrop(BACKDROP)
		button:SetBackdropColor(0, 0, 0)

		button:SetScript('OnLeave', GameTooltip_Hide)
		button:SetScript('OnEnter', ActionButton_SetTooltip)
		button:HookScript('OnEnter', function() button:SetBackdropColor(0, 4/6, 1) end)
		button:HookScript('OnLeave', function() button:SetBackdropColor(0, 0, 0) end)
		button:HookScript('OnUpdate', UpdateRange)

		button:SetPushedTexture(TEXTURE)
		button:GetPushedTexture():SetVertexColor(0, 0, 0, 1/3)

		local icon = button:CreateTexture(nil, 'BORDER')
		icon:SetAllPoints()
		icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		button.icon = icon

		local cooldown = CreateFrame('Cooldown', nil, button)
		cooldown:SetAllPoints()
		button.cooldown = cooldown

		if(index == 1) then
			button:SetPoint('BOTTOM', UIParent, -133, 100)
		else
			button:SetPoint('LEFT', _G['oBindings' .. index - 1], 'RIGHT', 4, 0)
		end

		button.action = string.match(button:GetAttribute('ob-possess-attribute'), 'action,(%d+)')
	end
end)
