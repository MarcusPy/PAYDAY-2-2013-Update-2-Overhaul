if RequiredScript == "lib/tweak_data/narrativetweakdata" then
	local old_init = NarrativeTweakData.init
	function NarrativeTweakData:init()
		old_init(self)

		self.jobs.firestarter.jc = 70
		self.jobs.firestarter_prof.jc = 80
		self.jobs.alex.jc = 60
		self.jobs.alex_prof.jc = 70
		self.jobs.welcome_to_the_jungle_prof.jc = 80
		self.jobs.framing_frame.jc = 60
		self.jobs.framing_frame_prof.jc = 70
		self.jobs.watchdogs.jc = 50
		self.jobs.watchdogs_prof.jc = 60
		self.jobs.nightclub.jc = 30
		self.jobs.ukrainian_job_prof.jc = 30
		self.jobs.jewelry_store.jc 	= 30
		self.jobs.four_stores.jc = 10
		self.jobs.mallcrasher.jc = 20
		self.jobs.branchbank_prof.jc = 40
		self.jobs.branchbank_deposit.jc = 30
		self.jobs.branchbank_cash.jc = 30
		self.jobs.branchbank_gold_prof.jc = 40

	end
end