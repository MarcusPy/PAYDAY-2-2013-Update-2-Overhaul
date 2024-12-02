if RequiredScript == "lib/managers/crimenetmanager" then
    local old_init = CrimeNetGui.init
    local old_create_locations = CrimeNetGui._create_locations
    
	local old_get_job_location = CrimeNetGui._get_job_location
	local old_update_server_job = CrimeNetGui.update_server_job

    function CrimeNetGui:init( ws, fullscreeen_ws, node, ... )
        old_init(self, ws, fullscreeen_ws, node, ...)
        local map = self._map_panel:child("map")
        if _G.u2_core.settings.crimenet_visuals.crimenet_background_color.enabled then
            map:set_color(_G.u2_core.settings.crimenet_visuals.crimenet_background_color.color)
        end
    end

    function CrimeNetGui:_create_locations(...)
        old_create_locations(self, ...)
        if _G.u2_core.settings.crimenet_heists.crimenet_sorted_heist_blips then
            local newDots = {}
            local xx,yy = 12,10
            for i=1,xx do
                for j=1,yy do
                    local newX = 150 + 1642*i/xx
                    local newY = 150 + 680*(i % 2 == 0 and j or j - 0.5)/yy
                    if  (i >= 3) or ( j < 7 ) then
                        table.insert(newDots,{ newX, newY })
                    end
                end
            end
            self._locations[1][1].dots = newDots
        end
    end

    function CrimeNetGui:_get_job_location(data, ...)
        if _G.u2_core.settings.crimenet_heists.crimenet_sorted_heist_blips then
            local diff = (data and data.difficulty_id or 2) - 2
            local diffX = 240 + 240 * diff
            local locations = self:_get_contact_locations()
            local sorted = {}
            for k,dot in pairs(locations[1].dots) do
                if not dot[3] then
                    table.insert(sorted,dot)
                end
            end
            if #sorted > 0 then
                local abs = math.abs
                table.sort(sorted,function(a,b)
                    return abs(diffX-a[1]) < abs(diffX-b[1])
                end)
                local dot = sorted[1]
                local x,y = dot[1],dot[2]
                local tw = math.max(self._map_panel:child("map"):texture_width(), 1)
                local th = math.max(self._map_panel:child("map"):texture_height(), 1)
                x = math.round(x / tw * self._map_size_w)
                y = math.round(y / th * self._map_size_h)

                return x,y,dot
            end
        else
            return old_get_job_location(self, data, ...)
        end
    end

	function CrimeNetGui:update_server_job(data, i, ...)
		old_update_server_job(self, data, i, ...)
		local job_index = data.id or i
		local job = self._jobs[job_index]
        if _G.u2_core.settings.crimenet_heists.crimenet_risk_color then
            local colors = { Color.green, Color.yellow, Color.red }
		    job.side_panel:child("job_name"):set_color(colors[data.difficulty_id - 2] or Color.white)
        end
	end
end