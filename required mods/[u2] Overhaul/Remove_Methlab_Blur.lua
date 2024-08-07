function ElementBlurZone:on_executed(instigator)
    if not self._values.enabled then
        return
    end

    ElementBlurZone.super.on_executed(self, instigator)
end