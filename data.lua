require ("util")

local back_thruster = table.deepcopy(data.raw["thruster"]["thruster"])

back_thruster.name = "back-thruster"
back_thruster.icon = "__realistic-space-distances__/graphics/icons/reverse-thruster.png"

back_thruster.min_performance = {fluid_volume = 0.1, fluid_usage = 0.1, effectivity = -1}
back_thruster.max_performance = {fluid_volume = 0.8, fluid_usage = 2, effectivity = -0.51}

back_thruster.collision_box = {{-1.7, -2.2}, {1.7, 2.2}}
back_thruster.selection_box = {{-2, -5.5}, {2, 2.5}}

back_thruster.tile_buildability_rules =
    {
      {area = {{-1.8, -2.3}, {1.8, 2.3}}, required_tiles = {layers={ground_tile=true}}, colliding_tiles = {layers={empty_space=true}}, remove_on_collision = true},
      {area = {{-1.8, -90.3}, {1.8, -2.7}}, required_tiles = {layers={empty_space=true}}, remove_on_collision = true},
    }

back_thruster.graphics_set =
    {
      animation = util.sprite_load("__realistic-space-distances__/graphics/entity/thruster/thruster",
                  {
                    animation_speed = 0.5,
                    frame_count = 64,
                    scale = 0.5,
                    shift = {0,0}
                  }),

      integration_patch_render_layer = "floor",
      integration_patch = util.sprite_load("__realistic-space-distances__/graphics/entity/thruster/thruster-bckg",
                          {
                            scale = 0.5,
                            shift = {0,0}
                          }),

      working_visualisations =
      {
        {
          always_draw = true,
          name = "pipe-1",
          enabled_by_name = true,
          animation =
          {
            filename = "__space-age__/graphics/entity/thruster/thruster-pipe-connection-1.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 95),
            scale = 0.5
          }
        },
        {
          always_draw = true,
          name = "pipe-2",
          enabled_by_name = true,
          animation =
          {
            filename = "__space-age__/graphics/entity/thruster/thruster-pipe-connection-2.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 96),
            scale = 0.5
          }
        },
        {
          always_draw = true,
          name = "pipe-3",
          enabled_by_name = true,
          animation =
          {
            filename = "__space-age__/graphics/entity/thruster/thruster-pipe-connection-3.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 96),
            scale = 0.5
          }
        },
        {
          always_draw = true,
          name = "pipe-4",
          enabled_by_name = true,
          animation =
          {
            filename = "__space-age__/graphics/entity/thruster/thruster-pipe-connection-4.png",
            width = 384,
            height = 832,
            shift = util.by_pixel(0, 95),
            scale = 0.5
          }
        },

        {
          -- effect = "flicker",
			    fadeout = true,
			    animation = util.sprite_load("__space-age__/graphics/entity/thruster/thruster-light",
				              {
				                animation_speed = 0.5,
				                frame_count = 64,
				                blend_mode = "additive",
				                draw_as_glow = true,
				                scale = 0.5,
				                shift = {0,3}
				              }),
        },
      },
      flame_effect =
      {
        filename = "__space-age__/graphics/entity/thruster/thruster-flame.png",
        width = 384,
        height = 832
      },
      flame_position = {0, 5.5},
      flame_half_height = 0,
      flame_effect_height = 1000 / 32,
      flame_effect_width = 384 / 64,
      flame_effect_offset = 50 / 32,
    }

data:extend({back_thruster})