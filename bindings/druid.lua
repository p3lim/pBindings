if(select(2, UnitClass('player')) ~= 'DRUID') then return end

local _, bindings = ...

pBindings:RegisterKeyBindings('Feral', bindings.base, {
	's|Rejuvenation',
	's|Healing Touch',
	's|Mark of the Wild',
	's|Symbiosis',
	's|Revive',

	BUTTON3 = 's|Prowl',

	cat = {
		's|Rake',
		's|Shred',
		's|Swipe',
		's|Mangle',
		's|Trash',

		Q = 'm|/cast Tiger\'s Fury\n/cast Berserk',
		E = 's|Tiger\'s Fury',
		F = 's|Savage Roar',

		BUTTON3 = 's|Prowl',
		BUTTON4 = 's|Rip',
		BUTTON5 = 's|Ferocious Bite',
	},

	bear = {
		's|Lacerate',
		's|Maul',
		's|Thrash',
		's|Mangle',
		's|Swipe',

		Q = 's|Berserk',
		E = 's|Might of Ursoc',
		F = 's|Frenzied Regeneration',

		BUTTON4 = 's|Growl',
	},

	shift = {
		's|Innervate',
		's|Dash',
		's|Tranquility',
		's|Stampeding Roar',
		's|Mighty Bash',

		Q = 's|Barkskin',
		E = 's|Renewal',
		F = 's|Rebirth',

		BUTTON3 = 's|Shadowmeld',
		BUTTON4 = 's|Faerie Fire',
		BUTTON5 = 's|Skull Bash',
	},

	ctrl = {
		's|Bear Form',
		's|Cat Form',
		'm|/cast [swimming] Aquatic Form; [flyable] Swift Flight Form; Travel Form',
		's|Travel Form',
	},
})
