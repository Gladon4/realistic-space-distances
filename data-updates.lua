local speed_limit = "300000" -- ~speed of ligth
local fall_off = "20000" -- higher means more gradual

local base_acc = "((thrust / (weight / 1)) / 60)"
local max_speed_acc_factor = "min(1,max(0, ((1/"..fall_off..") * speed * 60 * -1) + ((1/"..fall_off..") * ".. speed_limit ..")))"

data.raw["utility-constants"]["default"]["space_platform_acceleration_expression"] = base_acc .. "*" .. max_speed_acc_factor

local m = 100000

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

local asteroid_prob_factor = 0.005

for planet, _ in pairs(data.raw["planet"]) do
    data.raw["planet"][planet].asteroid_spawn_influence = 0
end

for connection, _ in pairs(data.raw["space-connection"]) do
    for i,k1 in pairs(data.raw["space-connection"][connection].asteroid_spawn_definitions) do
        for j,k2 in pairs(data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points) do
            probability = data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points[j].probability
            data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points[j].probability = probability * asteroid_prob_factor
            data.raw["space-connection"][connection].asteroid_spawn_definitions[i].spawn_points[j].speed = 0.0000001
        end
    end
end


data.raw["fluid"]["thruster-fuel"].fuel_value = "1000kJ"
data.raw["fluid"]["thruster-oxidizer"].fuel_value = "1000kJ"

local asteroid_health_factor = 0.1
local asteroid_resistance_factor = 0.025

for type,_ in pairs(data.raw["asteroid"]) do
    data.raw["asteroid"][type].max_health = asteroid_health_factor * data.raw["asteroid"][type].max_health
    data.raw["asteroid"][type].resistances[1]["decrease"] = data.raw["asteroid"][type].resistances[1]["decrease"] * asteroid_resistance_factor
end