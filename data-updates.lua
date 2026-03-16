local speed_limit = "300000" -- ~speed of ligth
local fall_off = "20000" -- higher means more gradual

local base_acc = "((thrust / (weight / 1)) / 60)"
local max_speed_acc_factor = "min(1,max(0, ((1/"..fall_off..") * speed * 60 * -1) + ((1/"..fall_off..") * ".. speed_limit ..")))"

data.raw["utility-constants"]["default"]["space_platform_acceleration_expression"] = base_acc .. "*" .. max_speed_acc_factor

local m = 1000000

-- General distance increas, so it should work with planet mods by default
for connection,_ in pairs(data.raw["space-connection"]) do
    local distance = data.raw["space-connection"][connection].length
    local factor = distance / 10000
    data.raw["space-connection"][connection].length = factor * 100 * m
end

-- Specific distances for the default planets
data.raw["space-connection"]["nauvis-vulcanus"].length = 150*m
data.raw["space-connection"]["nauvis-gleba"].length = 150*m
data.raw["space-connection"]["nauvis-fulgora"].length = 200*m
data.raw["space-connection"]["vulcanus-gleba"].length = 200*m
data.raw["space-connection"]["gleba-fulgora"].length = 200*m
data.raw["space-connection"]["gleba-aquilo"].length = 600*m
data.raw["space-connection"]["fulgora-aquilo"].length = 500*m
data.raw["space-connection"]["aquilo-solar-system-edge"].length = 1000*m
data.raw["space-connection"]["solar-system-edge-shattered-planet"].length = 2500*m

-- TODO: Specific distaances for some mods like Moluna

local asteroid_prob_factor = 0.003

for planet, _ in pairs(data.raw["planet"]) do
    data.raw["planet"][planet].asteroid_spawn_influence = 0
end

for connection, _ in pairs(data.raw["space-connection"]) do
    for i,_ in pairs(data.raw["space-connection"][connection].asteroid_spawn_definitions) do
        for j,_ in pairs(data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points) do
            probability = data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points[j].probability
            data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points[j].probability = probability * asteroid_prob_factor
            data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points[j].speed = 0.0000001
        end
    end
end


data.raw["fluid"]["thruster-fuel"].fuel_value = "1000kJ"
data.raw["fluid"]["thruster-oxidizer"].fuel_value = "1000kJ"

local asteroid_health_factor = 0.1
local asteroid_resistance_factor = 0.1

for type,_ in pairs(data.raw["asteroid"]) do
    data.raw["asteroid"][type].max_health = asteroid_health_factor * data.raw["asteroid"][type].max_health
    data.raw["asteroid"][type].resistances[1]["decrease"] = data.raw["asteroid"][type].resistances[1]["decrease"] * asteroid_resistance_factor
end

data.raw["ammo-turret"]["gun-turret"].preparing_speed = 0.4
data.raw["ammo-turret"]["gun-turret"].folding_speed = 0.4
data.raw["ammo-turret"]["rocket-turret"].preparing_speed = 0.4
data.raw["ammo-turret"]["rocket-turret"].folding_speed = 0.4

local space_rocket_item = table.deepcopy(data.raw["ammo"]["rocket"])
local explosive_space_rocket_item = table.deepcopy(data.raw["ammo"]["explosive-rocket"])

space_rocket_item.name = "space-rocket"
explosive_space_rocket_item.name = "explosive-space-rocket"

data:extend({space_rocket_item, explosive_space_rocket_item})

local space_rocket = table.deepcopy(data.raw["projectile"]["rocket"])
local explosive_space_rocket = table.deepcopy(data.raw["projectile"]["explosive-rocket"])

space_rocket.name = "space-rocket"
space_rocket.acceleration = 0.07
space_rocket.turn_speed = 0.03

explosive_space_rocket.name = "explosive-space-rocket"
explosive_space_rocket.acceleration = 0.07
explosive_space_rocket.turn_speed = 0.03

data:extend({space_rocket, explosive_space_rocket})

local space_rocket_recipe = table.deepcopy(data.raw["recipe"]["rocket"])
local explosive_space_rocket_recipe = table.deepcopy(data.raw["recipe"]["explosive-rocket"])

space_rocket_recipe.name = "space-rocket"
space_rocket_recipe.surface_conditions = {{property="gravity", max=0.1}}
space_rocket_recipe.results[1].name = "space-rocket"

explosive_space_rocket_recipe.name = "explosive-space-rocket"
explosive_space_rocket_recipe.surface_conditions = {{property="gravity", max=0.1}}
explosive_space_rocket_recipe.ingredients[1].name = "space-rocket"
explosive_space_rocket_recipe.results[1].name = "explosive-space-rocket"

data:extend({space_rocket_recipe, explosive_space_rocket_recipe})

data.raw["recipe"]["rocket"].surface_conditions = {{property="gravity", min=0.1}}
data.raw["recipe"]["explosive-rocket"].surface_conditions = {{property="gravity", min=0.1}}

table.insert(data.raw["technology"]["rocketry"].effects,
      {
        type = "unlock-recipe",
        recipe = "space-rocket"
      })

table.insert(data.raw["technology"]["explosive-rocketry"].effects,
      {
        type = "unlock-recipe",
        recipe = "explosive-space-rocket"
      })

