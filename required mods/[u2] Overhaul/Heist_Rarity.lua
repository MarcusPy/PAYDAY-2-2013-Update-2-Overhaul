if RequiredScript == "lib/tweak_data/narrativetweakdata" then
	local old_init = NarrativeTweakData.init
	function NarrativeTweakData:init()
		old_init(self)

		self.STARS[ 1 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 2 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 3 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 4 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 5 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 6 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 7 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 8 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 9 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }
		self.STARS[ 10 ] = { jcs = { 100, 90, 80, 70, 60, 50, 40, 30, 20, 10 } }

		self._jobs_index = { 
			"welcome_to_the_jungle",
			"welcome_to_the_jungle_prof",
			"framing_frame",
			"framing_frame_prof",
			"watchdogs",
			"watchdogs_prof",
			"alex",
			"alex_prof",
			"firestarter",
			"firestarter_prof",
			"ukrainian_job",
			"jewelry_store",
			"four_stores",
			"nightclub",
			"mallcrasher",
			"branchbank_deposit",
			"branchbank_cash",
			"branchbank_gold",
			"branchbank"
		}
	end
end