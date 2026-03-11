-- Sets platform speed to 0 on arrival
-- Maybe there is a better way, but for not this works
script.on_event(defines.events.on_space_platform_changed_state, function(event)
    if event.platform.state == defines.space_platform_state.waiting_at_station then
        local platform = event.platform
        if not platform then return end

        platform.speed = 0
    end
end)

