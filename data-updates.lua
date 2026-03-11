-- Space Age formula:
-- data.raw["utility-constants"]["default"]["space_platform_acceleration_expression"] =
-- "(thrust / (1 + weight / 10000000) - ((1500 * speed * speed + 1500 * abs(speed)) * (width * 0.5) + 10000) * sign(speed)) / weight / 60"


local speed_limit = "300000" -- ~speed of ligth
local fall_off = "20000" -- higher means more gradual

local base_acc = "((thrust / (weight / 1)) / 60)"
local max_speed_acc_factor = "min(1,max(0, ((1/"..fall_off..") * speed * 60 * -1) + ((1/"..fall_off..") * ".. speed_limit ..")))"

data.raw["utility-constants"]["default"]["space_platform_acceleration_expression"] = base_acc .. "*" .. max_speed_acc_factor

local m = 100000
data.raw["space-connection"]["nauvis-vulcanus"].length = 150*m
data.raw["space-connection"]["nauvis-gleba"].length = 150*m
data.raw["space-connection"]["nauvis-fulgora"].length = 200*m
data.raw["space-connection"]["vulcanus-gleba"].length = 200*m
data.raw["space-connection"]["gleba-fulgora"].length = 200*m
data.raw["space-connection"]["gleba-aquilo"].length = 600*m
data.raw["space-connection"]["fulgora-aquilo"].length = 500*m
data.raw["space-connection"]["aquilo-solar-system-edge"].length = 1000*m
data.raw["space-connection"]["solar-system-edge-shattered-planet"].length = 2500*m
