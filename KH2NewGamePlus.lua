--RAM Version
--Last Update: Patch 1.0.0.8 Fixes
--Todo: GoA portal color

LUAGUI_NAME = "KH2 New Game+"
LUAGUI_AUTH = "ZakTheRobot (adapted from Num's practice lua)"
LUAGUI_DESC = "Give all stuff at the beginning."

function _OnInit()
if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
	if ENGINE_VERSION < 4.1 then
		ConsolePrint('LuaBackend is Outdated. Things might not work properly.',2)
	end
	Platform = 1
	Now = 0x0714DB8 - 0x56454E
	Sve = 0x2A09C00 - 0x56450E
	BGM = 0x0AB8504 - 0x56450E
	Save = 0x09A7070 - 0x56450E
	Obj0 = 0x2A22B90 - 0x56450E
	Sys3 = 0x2A59DB0 - 0x56450E
	Btl0 = 0x2A74840 - 0x56450E
	Pause = 0x0AB9038 - 0x56450E
	React = 0x2A0E822 - 0x56450E
	Cntrl = 0x2A148A8 - 0x56450E
	Timer = 0x0AB9010 - 0x56450E
	Songs = 0x0B63534 - 0x56450E
	GScre = 0x0728E90 - 0x56454E
	GMdal = 0x0729024 - 0x56454E
	GKill = 0x0AF4906 - 0x56450E
	CamTyp = 0x0716A58 - 0x56454E
	CutNow = 0x0B62758 - 0x56450E
	CutLen = 0x0B62774 - 0x56450E
	CutSkp = 0x0B6275C - 0x56450E
	BtlTyp = 0x2A0EAC4 - 0x56450E
	BtlEnd = 0x2A0D3A0 - 0x56450E
	TxtBox = 0x074BC70 - 0x56454E
	DemCln = 0x2A0CF74 - 0x56450E
	MSNLoad  = 0x0BF08C0 - 0x56450E
	Slot1    = 0x2A20C58 - 0x56450E
	NextSlot = 0x278
	Point1   = 0x2A0D108 - 0x56450E
	NxtPoint = 0x50
	Gauge1   = 0x2A0D1F8 - 0x56450E
	NxtGauge = 0x48
	Menu1    = 0x2A0E7D0 - 0x56450E
	NextMenu = 0x8
end
Slot2  = Slot1 - NextSlot
Slot3  = Slot2 - NextSlot
end

function Events(M,B,E) --Check for Map, Btl, and Evt
	return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function BitOr(Address,Bit,Abs)
	if Abs and Platform == 1 then
		if ENGINE_VERSION < 5.0 then
			WriteByteA(Address,ReadByte(Address)|Bit)
		else
			WriteByte(Address,ReadByte(Address)|Bit,true)
		end
	else
		WriteByte(Address,ReadByte(Address)|Bit)
	end
	end

function BitNot(Address,Bit,Abs)
if Abs and Platform == 1 then
	if ENGINE_VERSION < 5.0 then
		WriteByteA(Address,ReadByte(Address)&~Bit)
	else
		WriteByte(Address,ReadByte(Address)&~Bit,true)
	end
else
	WriteByte(Address,ReadByte(Address)&~Bit)
end
end

function _OnFrame()
if true then --Define current values for common addresses
	World  = ReadByte(Now+0x00)
	Room   = ReadByte(Now+0x01)
	Place  = ReadShort(Now+0x00)
	Door   = ReadShort(Now+0x02)
	Map    = ReadShort(Now+0x04)
	Btl    = ReadShort(Now+0x06)
	Evt    = ReadShort(Now+0x08)
	PrevPlace = ReadShort(Now+0x30)
end
NewGame()
end

function NewGame()
--Before New Game
if ReadShort(Btl0+0x31A6C) == 0 then --Vanilla Lion Sora Abilities
	WriteShort(Btl0+0x31A6C,0x820E) --Dash
	WriteShort(Btl0+0x31A6E,0x820D) --Running Tackle
	--Party EXP Requirement
	for Member = 0,12 do
		local EXPAddress = Btl0 + 0x25928 + Member*0x634
		for Level = 0,98 do
			WriteInt(EXPAddress + 0x10*Level,99999)
		end
	end
	--Form EXP Requirement
	for Form = 0,5 do
		local EXPAddress = Btl0 + 0x34470 + Form*0x38
		for Level = 0,5 do
			WriteInt(EXPAddress + 0x8*Level,99999)
		end
	end
end
if Place == 0x2002 and Events(0x01,Null,0x01) then --Station of Serenity Weapons
	ConsolePrint("Setting all new game plus stuff...")
	BitNot(Save+0x1CD2,0x80) --TT_SCENARIO_1_START (Show Gameplay Elements)
	--Starting Stats
	if true then --Sora
		WriteByte(Save+0x24F8,255) --AP
		WriteByte(Save+0x24F9,255) --Str
		WriteByte(Save+0x24FA,255) --Mag
		WriteByte(Save+0x24FB,255) --Def
		WriteByte(Save+0x24FF,99) --Level
		WriteByte(Save+0x2500,4)   --Armor Slot
		WriteByte(Save+0x2501,4)   --Accessory Slot
		WriteByte(Save+0x2502,8)   --Item Slot
		WriteShort(Save+0x2544,0x052) --Guard
		WriteShort(Save+0x2546,0x089) --Upper Slash
		WriteShort(Save+0x2548,0x10F) --Horizontal Slash
		WriteShort(Save+0x254A,0x10B) --Finishing Leap
		WriteShort(Save+0x254C,0x111) --Retaliating Slash
		WriteShort(Save+0x254E,0x106) --Slapshot
		WriteShort(Save+0x2550,0x107) --Dodge Slash
		WriteShort(Save+0x2552,0x22F) --Flash Step
		WriteShort(Save+0x2554,0x108) --Slide Dash
		WriteShort(Save+0x2556,0x232) --Vicinity Break
		WriteShort(Save+0x2558,0x109) --Guard Break
		WriteShort(Save+0x255A,0x10A) --Explosion
		WriteShort(Save+0x255C,0x10D) --Aerial Sweep
		WriteShort(Save+0x255E,0x230) --Aerial Dive
		WriteShort(Save+0x2560,0x10E) --Aerial Spiral
		WriteShort(Save+0x2562,0x110) --Aerial Finish
		WriteShort(Save+0x2564,0x231) --Magnet Burst
		WriteShort(Save+0x2566,0x10C) --Counterguard
		WriteShort(Save+0x2568,0x181) --Auto Valor
		WriteShort(Save+0x256A,0x182) --Auto Wisdom
		WriteShort(Save+0x256C,0x238) --Auto Limit
		WriteShort(Save+0x256E,0x183) --Auto Master
		WriteShort(Save+0x2570,0x184) --Auto Final
		WriteShort(Save+0x2572,0x185) --Auto Summon
		WriteShort(Save+0x2574,0x0C6) --Trinity Limit
		WriteShort(Save+0x2576,0x060) --High Jump LV3
		WriteShort(Save+0x2578,0x064) --Quick Run LV3
		WriteShort(Save+0x257A,0x236) --Dodge Roll LV3
		WriteShort(Save+0x257C,0x068) --Aerial Dodge LV3
		WriteShort(Save+0x257E,0x06C) --Glide LV3
		WriteShort(Save+0x2580,0x08A) --Scan
		WriteShort(Save+0x2582,0x09E) --Aerial Recovery
		WriteShort(Save+0x2584,0x21B) --Combo Master
		WriteShort(Save+0x2586,0x0A2) --Combo Plus
		WriteShort(Save+0x2588,0x0A2) --Combo Plus
		WriteShort(Save+0x258A,0x0A3) --Air Combo Plus
		WriteShort(Save+0x258C,0x0A3) --Air Combo Plus
		WriteShort(Save+0x258E,0x186) --Combo Boost
		WriteShort(Save+0x2590,0x187) --Air Combo Boost
		WriteShort(Save+0x2592,0x188) --Reaction Boost
		WriteShort(Save+0x2594,0x188) --Reaction Boost
		WriteShort(Save+0x2596,0x189) --Finishing Plus
		WriteShort(Save+0x2598,0x189) --Finishing Plus
		WriteShort(Save+0x259A,0x18A) --Negative Combo
		WriteShort(Save+0x259C,0x18B) --Berserk Charge
		WriteShort(Save+0x259E,0x18C) --Damage Drive
		WriteShort(Save+0x25A0,0x18D) --Drive Boost
		WriteShort(Save+0x25A2,0x18E) --Form Boost
		WriteShort(Save+0x25A4,0x18E) --Form Boost
		WriteShort(Save+0x25A6,0x18F) --Summon Boost
		WriteShort(Save+0x25A8,0x190) --Combination Boost
		WriteShort(Save+0x25AA,0x191) --Experience Boost
		WriteShort(Save+0x25AC,0x192) --Leaf Bracer
		WriteShort(Save+0x25AE,0x193) --Magic Lock-On
		WriteShort(Save+0x25B0,0x195) --Draw
		WriteShort(Save+0x25B2,0x195) --Draw
		WriteShort(Save+0x25B4,0x195) --Draw
		WriteShort(Save+0x25B6,0x196) --Jackpot
		WriteShort(Save+0x25B8,0x197) --Lucky Lucky
		WriteShort(Save+0x25BA,0x197) --Lucky Lucky
		WriteShort(Save+0x25BC,0x197) --Lucky Lucky
		WriteShort(Save+0x25BE,0x21C) --Drive Converter
		WriteShort(Save+0x25C0,0x198) --Fire Boost
		WriteShort(Save+0x25C2,0x199) --Blizzard Boost
		WriteShort(Save+0x25C4,0x19A) --Thunder Boost
		WriteShort(Save+0x25C6,0x19B) --Item Boost
		WriteShort(Save+0x25C8,0x19C) --MP Rage
		WriteShort(Save+0x25CA,0x19D) --MP Haste
		WriteShort(Save+0x25CC,0x1A5) --MP Hastera
		WriteShort(Save+0x25CE,0x19E) --Defender
		WriteShort(Save+0x25D0,0x21E) --Damage Control
		WriteShort(Save+0x25D2,0x19F) --Second Chance
		WriteShort(Save+0x25D4,0x1A0) --Once More
		WriteShort(Save+0x25D6,0x194) --No Experience
	end
	if true then --Donald
		WriteByte(Save+0x260C,100) --AP Boost
		WriteByte(Save+0x2614,2)   --Armor Slot
		WriteByte(Save+0x2615,3)   --Accessory Slot
		WriteByte(Save+0x2616,4)   --Item Slot
		WriteShort(Save+0x2658,0x0A5) --Donald Fire 
		WriteShort(Save+0x265A,0x0A6) --Donald Blizzard
		WriteShort(Save+0x265C,0x80A7)--Donald Thunder
		WriteShort(Save+0x265E,0x80A8)--Donald Cure
		WriteShort(Save+0x2660,0x0C7) --Fantasia
		WriteShort(Save+0x2662,0x0C8) --Flare Force
		WriteShort(Save+0x2664,0x195) --Draw
		WriteShort(Save+0x2666,0x196) --Jackpot
		WriteShort(Save+0x2668,0x197) --Lucky Lucky
		WriteShort(Save+0x266A,0x198) --Fire Boost
		WriteShort(Save+0x266C,0x199) --Blizzard Boost
		WriteShort(Save+0x266E,0x19A) --Thunder Boost
		WriteShort(Save+0x2670,0x19C) --MP Rage
		WriteShort(Save+0x2672,0x1A5) --MP Hastera
		WriteShort(Save+0x2674,0x1A1) --Auto Limit
		WriteShort(Save+0x2676,0x1A3) --Hyper Healing
		WriteShort(Save+0x2678,0x1A4) --Auto Healing
	end
	if true then --Goofy
		WriteByte(Save+0x2720,100) --AP Boost
		WriteByte(Save+0x2728,3)   --Armor Slot
		WriteByte(Save+0x2729,2)   --Accessory Slot
		WriteByte(Save+0x272A,6)   --Item Slot
		WriteShort(Save+0x276C,0x1A7) --Goofy Tornado
		WriteShort(Save+0x276E,0x81AD)--Goofy Bash
		WriteShort(Save+0x2770,0x1A9) --Goofy Turbo
		WriteShort(Save+0x2772,0x0C9) --Tornado Fusion
		WriteShort(Save+0x2774,0x0CA) --Teamwork
		WriteShort(Save+0x2776,0x195) --Draw
		WriteShort(Save+0x2778,0x196) --Jackpot
		WriteShort(Save+0x277A,0x197) --Lucky Lucky
		WriteShort(Save+0x277C,0x819B)--Item Boost
		WriteShort(Save+0x277E,0x19C) --MP Rage
		WriteShort(Save+0x2780,0x19E) --Defender
		WriteShort(Save+0x2782,0x21E) --Damage Control
		WriteShort(Save+0x2784,0x19F) --Second Chance
		WriteShort(Save+0x2786,0x1A0) --Once More
		WriteShort(Save+0x2788,0x1A1) --Auto Limit
		WriteShort(Save+0x278A,0x1A2) --Auto Change
		WriteShort(Save+0x278C,0x1A3) --Hyper Healing
		WriteShort(Save+0x278E,0x1A4) --Auto Healing
	end
	--Starting Items
	if true then --Magic, Forms, Summons
		BitOr(Save+0x36C0,0x5F) --Forms & Summons
		BitOr(Save+0x36C4,0x30) --Genie & Peter Pan
		BitOr(Save+0x36CA,0x08) --Limit Form
		WriteByte(Save+0x3594,3) --Fire
		WriteByte(Save+0x3595,3) --Blizzard
		WriteByte(Save+0x3596,3) --Thunder
		WriteByte(Save+0x3597,3) --Cure
		WriteByte(Save+0x35CF,3) --Magnet
		WriteByte(Save+0x35D0,3) --Reflect
	end
	if true then --Keyblades
		WriteByte(Save+0x35A2,1) --Oathkeeper
		WriteByte(Save+0x35A3,1) --Oblivion
		WriteByte(Save+0x367B,1) --Star Seeker
		WriteByte(Save+0x367C,1) --Hidden Dragon
		WriteByte(Save+0x367F,1) --Hero's Crest
		WriteByte(Save+0x3680,1) --Monochrome
		WriteByte(Save+0x3681,1) --Follow the Wind
		WriteByte(Save+0x3682,1) --Circle of Life
		WriteByte(Save+0x3683,1) --Photon Debugger
		WriteByte(Save+0x3684,1) --Gull Wing
		WriteByte(Save+0x3685,1) --Rumbling Rose
		WriteByte(Save+0x3686,1) --Guardian Soul
		WriteByte(Save+0x3687,1) --Wishing Lamp
		WriteByte(Save+0x3688,1) --Decisive Pumpkin
		WriteByte(Save+0x368A,1) --Sweet Memories
		WriteByte(Save+0x368B,1) --Mysterious Abyss
		WriteByte(Save+0x3689,1) --Sleeping Lion
		WriteByte(Save+0x368D,1) --Bond of Flame
		WriteByte(Save+0x3698,1) --Two Become One
		WriteByte(Save+0x368C,1) --Fatal Crest
		WriteByte(Save+0x368E,1) --Fenrir
		WriteByte(Save+0x368F,1) --Ultima Weapon
		WriteByte(Save+0x3699,1) --Winner's Proof
		WriteByte(Save+0x3651,1) --Struggle Sword
		WriteByte(Save+0x3690,1) --Struggle Wand
		WriteByte(Save+0x3691,1) --Struggle Hammer
	end
	if true then --Staves
		WriteByte(Save+0x35EF,1) --Hammer Staff
		WriteByte(Save+0x35F0,1) --Victory Bell
		WriteByte(Save+0x35F2,1) --Comet Staff
		WriteByte(Save+0x35F3,1) --Lord's Broom
		WriteByte(Save+0x35F4,1) --Wisdom Wand
		WriteByte(Save+0x35F1,1) --Meteor Staff
		WriteByte(Save+0x35F5,1) --Rising Dragon
		WriteByte(Save+0x35F7,1) --Shaman's Relic
		WriteByte(Save+0x36B6,1) --Shaman's Relic+
		WriteByte(Save+0x35F6,1) --Nobody Lance
		WriteByte(Save+0x369A,1) --Centurion
		WriteByte(Save+0x369B,1) --Centurion+
		WriteByte(Save+0x367D,1) --Save the Queen
		WriteByte(Save+0x3692,1) --Save the Queen+
		WriteByte(Save+0x369C,1) --Plain Mushroom
		WriteByte(Save+0x369D,1) --Plain Mushroom+
		WriteByte(Save+0x369E,1) --Precious Mushroom
		WriteByte(Save+0x369F,1) --Precious Mushroom+
		WriteByte(Save+0x36A0,1) --Premium Mushroom
	end
	if true then --Shields
		WriteByte(Save+0x35E6,1) --Adamant Shield
		WriteByte(Save+0x35E7,1) --Chain Gear
		WriteByte(Save+0x35E9,1) --Falling Star
		WriteByte(Save+0x35EA,1) --Dreamcloud
		WriteByte(Save+0x35EB,1) --Knight Defender
		WriteByte(Save+0x35E8,1) --Ogre Shield
		WriteByte(Save+0x35EC,1) --Genji Shield
		WriteByte(Save+0x35ED,1) --Akashic Record
		WriteByte(Save+0x36B7,1) --Akashic Record+
		WriteByte(Save+0x35EE,1) --Nobody Guard
		WriteByte(Save+0x36A1,1) --Frozen Pride
		WriteByte(Save+0x36A2,1) --Frozen Pride+
		WriteByte(Save+0x367E,1) --Save the King
		WriteByte(Save+0x3693,1) --Save the King+
		WriteByte(Save+0x36A3,1) --Joyous Mushroom
		WriteByte(Save+0x36A4,1) --Joyous Mushroom+
		WriteByte(Save+0x36A5,1) --Majestic Mushroom
		WriteByte(Save+0x36A6,1) --Majestic Mushroom+
		WriteByte(Save+0x36A7,1) --Ultimate Mushroom
	end
	if true then --Armor
		WriteByte(Save+0x35BC,69) --Elven Bandanna
		WriteByte(Save+0x35BD,69) --Divine Bandanna
		WriteByte(Save+0x35C7,69)  --Protect Belt
		WriteByte(Save+0x35CA,69)  --Gaia Belt
		WriteByte(Save+0x35BE,69) --Power Band
		WriteByte(Save+0x35C6,69) --Buster Band
		WriteByte(Save+0x35D1,69)  --Cosmic Belt
		WriteByte(Save+0x35D7,69) --Fire Bangle
		WriteByte(Save+0x35D8,69) --Fira Bangle
		WriteByte(Save+0x35D9,69) --Firaga Bangle
		WriteByte(Save+0x35DA,69) --Firagun Bangle
		WriteByte(Save+0x35DC,69) --Blizzard Armlet
		WriteByte(Save+0x35DD,69) --Blizzara Armlet
		WriteByte(Save+0x35DE,69) --Blizzaga Armlet
		WriteByte(Save+0x35DF,69) --Blizzagun Armlet
		WriteByte(Save+0x35E2,69) --Thunder Trinket
		WriteByte(Save+0x35E3,69) --Thundara Trinket
		WriteByte(Save+0x35E4,69) --Thundaga Trinket
		WriteByte(Save+0x35E5,69) --Thundagun Trinket
		WriteByte(Save+0x35D2,69) --Shock Charm
		WriteByte(Save+0x35D3,69) --Shock Charm+
		WriteByte(Save+0x35F9,69) --Shadow Anklet
		WriteByte(Save+0x35FB,69) --Dark Anklet
		WriteByte(Save+0x35FC,69) --Midnight Anklet
		WriteByte(Save+0x35FD,69) --Chaos Anklet
		WriteByte(Save+0x3603,69)  --Champion Belt
		WriteByte(Save+0x35FF,69) --Abas Chain
		WriteByte(Save+0x3600,69) --Aegis Chain
		WriteByte(Save+0x3601,69) --Acrisius
		WriteByte(Save+0x3605,69) --Acrisius+
		WriteByte(Save+0x3606,69)  --Cosmic Chain
		WriteByte(Save+0x3604,69) --Petite Ribbon
		WriteByte(Save+0x3602,69) --Ribbon
		WriteByte(Save+0x35D4,69)  --Grand Ribbon
	end
	if true then --Accessory
		WriteByte(Save+0x3587,69) --Ability Ring
		WriteByte(Save+0x3588,69) --Engineer's Ring
		WriteByte(Save+0x3589,69) --Technician's Ring
		WriteByte(Save+0x359F,69)  --Skill Ring
		WriteByte(Save+0x35A0,69)  --Skillful Ring
		WriteByte(Save+0x358A,69) --Expert's Ring
		WriteByte(Save+0x359B,69) --Master's Ring
		WriteByte(Save+0x35AD,69)  --Cosmic Ring
		WriteByte(Save+0x36B5,69)  --Executive's Ring
		WriteByte(Save+0x358B,69) --Sardonyx Ring
		WriteByte(Save+0x358C,69) --Tourmaline Ring
		WriteByte(Save+0x358D,69) --Aquamarine Ring
		WriteByte(Save+0x358E,69) --Garnet Ring
		WriteByte(Save+0x358F,69) --Diamond Ring
		WriteByte(Save+0x3590,69) --Silver Ring
		WriteByte(Save+0x3591,69) --Gold Ring
		WriteByte(Save+0x3592,69) --Platinum Ring
		WriteByte(Save+0x3593,69) --Mythril Ring
		WriteByte(Save+0x359A,69) --Orichalcum Ring
		WriteByte(Save+0x35A6,69) --Soldier Earring
		WriteByte(Save+0x35A7,69) --Fencer Earring
		WriteByte(Save+0x35A8,69) --Mage Earring
		WriteByte(Save+0x35AC,69) --Slayer Earring
		WriteByte(Save+0x35B0,69)  --Medal
		WriteByte(Save+0x359C,69) --Moon Amulet
		WriteByte(Save+0x359E,69) --Star Charm
		WriteByte(Save+0x35B1,69)  --Cosmic Arts
		WriteByte(Save+0x35B2,69) --Shadow Archive
		WriteByte(Save+0x35B7,69) --Shadow Archive+
		WriteByte(Save+0x35B9,69) --Full Bloom
		WriteByte(Save+0x35BB,69) --Full Bloom+
		WriteByte(Save+0x35BA,69) --Draw Ring
		WriteByte(Save+0x35B8,69) --Lucky Ring
	end
	--Tutorial Flags & Form Weapons
	-- BitOr(Save+0x36E8,0x01)  --Enable Item in Command Menu
	WriteShort(Save+0x32F4,0x1F4) --Valor Form equips Star Seeker
	WriteShort(Save+0x339C,0x1F4) --Master Form equips Hidden Dragon
	WriteShort(Save+0x33D4,0x1F4) --Final Form equips Two Become One
	WriteShort(Save+0x4270,0x1FF) --Pause Menu Tutorial Prompts Seen Flags
	WriteShort(Save+0x4274,0x1FF) --Status Form & Summon Seen Flags
	BitOr(Save+0x49F0,0x03) --Shop Tutorial Prompt Flags (1=Big Shops, 2=Small Shops)
	-- BitOr(Save+0x1CEA,0x01)  --TT_ROXAS_END (Play as Sora)
	-- BitOr(Save+0x1CEA,0x02)  --TT_SORA_OLD_END (Play as KH2 Sora)
	StartStuff()
end
STTFixes()
TTFixes()
end

function StartStuff()
	WriteByte(Save+0x3580,99) --Potion
	WriteByte(Save+0x3581,99) --Hi-Potion
	WriteByte(Save+0x3582,99) --Ether
	WriteByte(Save+0x3583,99) --Elixir
	WriteByte(Save+0x3584,99) --Mega-Potion
	WriteByte(Save+0x3585,99) --Mega-Ether
	WriteByte(Save+0x3586,99) --Megalixir
	WriteByte(Slot1+0x184,140) -- MP
	WriteByte(Slot1+0x004,120) -- HP
	WriteByte(Slot1+0x1B2,9) -- Max Drive
	WriteByte(Slot1+0x1B1,9) -- Current Drive
	WriteByte(Save+0x32F6,7) -- valor level 7
	WriteByte(Save+0x332E,7) -- wisdom 7
	WriteByte(Save+0x3366,7) -- limit 7
	WriteByte(Save+0x339E,7) -- master 7
	WriteByte(Save+0x33D6,7) -- final 7
	WriteByte(Save+0x3526,7) -- summons 7
	WriteByte(Slot2+0x004,90) -- Donald
	WriteByte(Slot3+0x004,116) -- Goofy

	--Form Movement
	local ValorLv = ReadByte(Save+0x32F6)
	local WisdmLv = ReadByte(Save+0x332E)
	local LimitLv = ReadByte(Save+0x3366)
	local MastrLv = ReadByte(Save+0x339E)
	local FinalLv = ReadByte(Save+0x33D6)
	if ValorLv == 1 or ValorLv == 2 then WriteShort(Save+0x32FC,0x805E)
	elseif ValorLv == 3 or ValorLv == 4 then WriteShort(Save+0x32FC,0x805F)
	elseif ValorLv == 5 or ValorLv == 6 then WriteShort(Save+0x32FC,0x8060)
	elseif ValorLv == 7 then WriteShort(Save+0x32FC,0x8061) end
	if WisdmLv == 1 or WisdmLv == 2 then WriteShort(Save+0x3334,0x8062)
	elseif WisdmLv == 3 or WisdmLv == 4 then WriteShort(Save+0x3334,0x8063)
	elseif WisdmLv == 5 or WisdmLv == 6 then WriteShort(Save+0x3334,0x8064)
	elseif WisdmLv == 7 then WriteShort(Save+0x3334,0x8065) end
	if LimitLv == 1 or LimitLv == 2 then WriteShort(Save+0x336C,0x8234)
	elseif LimitLv == 3 or LimitLv == 4 then WriteShort(Save+0x336C,0x8235)
	elseif LimitLv == 5 or LimitLv == 6 then WriteShort(Save+0x336C,0x8236)
	elseif LimitLv == 7 then WriteShort(Save+0x336C,0x8237) end
	if MastrLv == 1 or MastrLv == 2 then WriteShort(Save+0x33A4,0x8066)
	elseif MastrLv == 3 or MastrLv == 4 then WriteShort(Save+0x33A4,0x8067)
	elseif MastrLv == 5 or MastrLv == 6 then WriteShort(Save+0x33A4,0x8068)
	elseif MastrLv == 7 then WriteShort(Save+0x33A4,0x8069) end
	if FinalLv == 1 or FinalLv == 2 then WriteShort(Save+0x33DC,0x806A)
	elseif FinalLv == 3 or FinalLv == 4 then WriteShort(Save+0x33DC,0x806B)
	elseif FinalLv == 5 or FinalLv == 6 then WriteShort(Save+0x33DC,0x806C)
	elseif FinalLv == 7 then WriteShort(Save+0x33DC,0x806D) end
end


function STTFixes()
	if ReadByte(Save+0x1CFF) == 13 then --STT Removals
		if Events(0x5B,0x5B,0x5B) or Events(0xC0,0xC0,0xC0) then --Mail Delivery softlock fix
			WriteString(Obj0+0x15030,'F_TT010_ROXAS.mset\0')
		else --Let Limit Form use skateboard
			WriteString(Obj0+0x15030,'F_TT010.mset\0')
		end
		local Equip = ReadShort(Save+0x24F0) --Currently equipped Keyblade
		local Store = ReadShort(Save+0x1CF9) --Last equipped Keyblade
		local Struggle
		if ReadByte(Save+0x1CF8) == 1 then
			Struggle = 0x180 --Struggle Sword
		elseif ReadByte(Save+0x1CF8) == 2 then
			Struggle = 0x1F5 --Struggle Wand
		elseif ReadByte(Save+0x1CF8) == 3 then
			Struggle = 0x1F6 --Struggle Hammer
		elseif not(Place == 0x0402 and Events(0x4C,0x4C,0x4C)) then --No Struggle Weapon Chosen
			WriteByte(Save+0x1CF8,math.random(3))
		end
		if Place == 0x0402 and Events(0x4C,0x4C,0x4C) then --Sandlot Weapons
			if not(Equip == 0x180 or Equip == 0x1F5 or Equip == 0x1F6) then
				WriteByte(Save+0x1CF8,0) --Reset Struggle Weapon Flag
			elseif ReadByte(Save+0x1CF8) == 0 then
				if Equip == 0x180 then --Struggle Sword
					WriteByte(Save+0x3651,ReadByte(Save+0x3651)+1)
					WriteByte(Save+0x1CF8,1)
				elseif Equip == 0x1F5 then --Struggle Wand
					WriteByte(Save+0x3690,ReadByte(Save+0x3690)+1)
					WriteByte(Save+0x1CF8,2)
				elseif Equip == 0x1F6 then --Struggle Hammer
					WriteByte(Save+0x3691,ReadByte(Save+0x3691)+1)
					WriteByte(Save+0x1CF8,3)
				end
			end
		elseif Place == 0x0402 and (Events(0x4D,0x4D,0x4D) or Events(0x4E,0x4E,0x4E) or Events(0x4F,0x4F,0x4F)) then --Tutorial Fights
			WriteShort(Save+0x24F0,Struggle)
		elseif Place == 0x0502 and (Events(0x54,0x54,0x54) or Events(0x55,0x55,0x55) or Events(0x58,0x58,0x58)) then --Struggle Fights
			WriteShort(Save+0x24F0,Struggle)
		elseif Place == 0x0502 and ReadShort(Now+0x32) ~= Door and (Door == 0x33 or Door == 0x35) then --Losing to Seifer or Vivi
			WriteShort(Save+0x24F0,Store)
		elseif Place == 0x0E02 and Events(0x7F,0x7F,0x7F) then --The Old Mansion Dusk
			WriteShort(Save+0x24F0,Struggle)
		elseif Place == 0x1402 then --Axel II (Oblivion is Equipped & Unequipped Automatically)
		elseif Equip ~= Store then
			if ReadByte(Cntrl) == 0 then
				WriteShort(Save+0x1CF9,Equip) --Change Stored Keyblade
			elseif Store > 0 then
				WriteShort(Save+0x24F0,Store) --Change Equipped Keyblade
			end
		end
	else
		WriteShort(Save+0x1CF9,0) --Remove stored Keyblade
	end
end

function TTFixes()
	if World == 0x02 then
		if Place == 0x1302 then
			ConsolePrint("right place")
			if Events(0x88,0x88,0x88) then
				ConsolePrint("TT1 entry")
				BitOr(Save+0x1CEA,0x02)  --TT_SORA_OLD_END (Play as KH2 Sora)
			end
		end
	end
end