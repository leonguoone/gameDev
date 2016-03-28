
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),
        Asset( "ANIM", "anim/swilson.zip" ),
        Asset( "ANIM", "anim/ghost_swilson_build.zip" ),
}
local prefabs = {}
local start_inv = {
	-- Custom starting items
  -- 自动项目启动
	"tophat",
}

-- 初始化客户端及主机
-- This initializes for both clients and the host
local common_postinit = function(inst)
  -- 小地图图标
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "swilson.tex" )
end

local function updatestats(inst)
  --白天属性
  -- Attributes at day
	if TheWorld.state.phase == "day" then

		inst.Light:Enable(false)
		inst.components.health:SetMaxHealth(200)
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.5)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.5)
		inst.components.combat.damagemultiplier = 2.0
		inst.components.sanity.dapperness = TUNING.DAPPERNESS_SMALL * (-2) --Sanity lost during the day.

    --黄昏属性
    -- Attributes at dusk
	elseif TheWorld.state.phase == "dusk" then

		inst.Light:Enable(false)
		inst.components.health:SetMaxHealth(300)
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 2)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 2)
		inst.components.combat.damagemultiplier = 2.0
		inst.components.sanity.dapperness = TUNING.DAPPERNESS_SMALL * (-1) --Sanity lost during the day.
    inst.components.talker:Say("天行者，暗夜魔王！")
    -- inst.components.talker:Say("Day walker, night stalker！")

    -- 夜间属性
    -- Attributes at night
	elseif TheWorld.state.phase == "night" then

		inst.Light:Enable(true)
		inst.components.health:SetMaxHealth(500)
    inst.components.health:StartRegen(1, 1.00)  --1Hp, 1 seconds. 60hp/min.
    inst.components.sanity:StartRegen(1, 1.00)  --1sn, 1 seconds. 60sn/min.
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 2.5)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 2.5)
		inst.components.sanity.night_drain_mult = 0 --0 Sanity loss during the night
		inst.components.combat.damagemultiplier = 2.0
    inst.components.talker:Say("暗夜！降临！")
    -- inst.components.talker:Say("From blackest night, I come.")

    -- 满月！！！！
		if TheWorld.state.isfullmoon then

			inst.components.health:StartRegen(1, 1.00)  --1Hp, 1 seconds. 60hp/min.
			inst.components.sanity:StartRegen(1, 1.00)  --1sn, 1 seconds. 60sn/min.
			inst.components.combat.damagemultiplier = 4
			inst.components.health:SetMaxHealth(500)
			inst.components.sanity.night_drain_mult = -2 --2 Sanity gained during the night
      inst.components.talker:Say("狼人，我才是夜晚真正的野兽！")
			-- inst.components.talker:Say("Lycan, I am the true beast of the night.")

		end
	end

	inst.Light:SetRadius(10)
	inst.Light:SetFalloff(0.75)
	inst.Light:SetIntensity(.6)
	inst.Light:SetColour(235/255,12/255,12/255)
end

-- This initializes for the host only
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	-- Stats
	inst.components.health:SetMaxHealth(200)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(300)
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED * 1.5)
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED * 1.5)
	inst.components.combat.damagemultiplier = 2.0
	inst.components.sanity.dapperness = TUNING.DAPPERNESS_SMALL * (-2) --Sanity lost during the day.
	inst.components.sanity.night_drain_mult = 0 --0 Sanity loss during the night

	local light = inst.entity:AddLight()
	inst.Light:Enable(false)
	inst.Light:SetRadius(15)
	inst.Light:SetFalloff(0.75)
	inst.Light:SetIntensity(.6)
	inst.Light:SetColour(70/255,255/255,12/255)

	-- Watches for changes in the day/dusk/night
	inst:WatchWorldState("phase",updatestats)
	updatestats(inst)

end

return MakePlayerCharacter("swilson", prefabs, assets, common_postinit, master_postinit, start_inv)


-- end Night Stalker