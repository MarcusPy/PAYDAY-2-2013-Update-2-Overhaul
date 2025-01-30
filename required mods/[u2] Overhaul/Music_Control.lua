local orig = CoreMusicManager._check_music_switch
function CoreMusicManager:_check_music_switch()
	local setting = _G.u2_core.settings.gameplay.forced_music
	if setting ~= 1 then
		local tracks = {
			[2] = "track_01",
			[3] = "track_02",
			[4] = "track_03",
			[5] = "track_04",
			[6] = "track_05",
			[7] = "track_06",
			[8] = "track_07",
			[9] = "track_08"
		}
		--log(string.format("setting %d = %s", setting, tostring(tracks[setting])))
		Global.music_manager.source:set_switch( "music_randomizer", tracks[setting] )
		return
	end
	--log("off")
	orig(self)
end

-- can be used to play audio
--[[
function CoreMusicManager:post_event( name )
	--log( name )
	if Global.music_manager.current_event ~= name then
		Global.music_manager.source:post_event( name )
		Global.music_manager.current_event = name
	end
end
]]
