if _G.u2_core.settings.misc.remove_meth_blur then
    function ElementBlurZone:on_executed(instigator)
        if not self._values.enabled then
            return
        end

        ElementBlurZone.super.on_executed(self, instigator)
    end
end