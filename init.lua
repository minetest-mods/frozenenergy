local function update_timer(pos)
	local timer = minetest.get_node_timer(pos)
	timer:start(math.random(20)+10) -- 10-30 seconds
end

local function on_timer(pos)
	local radius = 1
	local water_nodes = minetest.find_nodes_in_area(
			{x=pos.x-radius, y=pos.y-radius, z=pos.z-radius},
					{x=pos.x+radius, y=pos.y+radius, z=pos.z+radius},
					{"group:water"})
	if water_nodes and #water_nodes>0 then
		minetest.set_node(water_nodes[math.random(#water_nodes)], {name = "default:ice"})
	end
	update_timer(pos)
end

minetest.register_node("frozenenergy:crystal", {
	description = "Frozen energy crystal",
	--drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"default_pine_needles.png^[colorize:blue:100^[noalpha^[colorize:white:90"},
	paramtype = "light",
	is_ground_content = false,
	liquids_pointable = true,
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
	on_timer = on_timer,
	on_construct = update_timer,
})

minetest.register_craft({
	output = "frozenenergy:crystal",
	recipe = {
		{"", "default:copper_ingot", ""},
		{"default:mese_crystal", "default:diamond", "default:mese_crystal"},
		{"", "default:copper_ingot", ""}
	}
})
