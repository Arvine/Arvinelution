--Enemy Controller (Anime)
function c511000604.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000604.target)
	e1:SetOperation(c511000604.activate)
	c:RegisterEffect(e1)
end
function c511000604.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil)
	local b=Duel.CheckLPCost(tp,1000) and Duel.CheckReleaseGroup(1-tp,nil,1,nil)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()~=tp end
	if chk==0 then return a or b end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511000604.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local op=0
	if tc:IsRelateToEffect(e) then
		if tc:IsDestructable() and Duel.CheckLPCost(tp,1000) and tc:IsReleasableByEffect() then
			op=Duel.SelectOption(tp,aux.Stringid(511000604,0),aux.Stringid(511000604,1))
		elseif tc:IsDestructable() then
			Duel.SelectOption(tp,aux.Stringid(511000604,0))
			op=0
		elseif Duel.CheckLPCost(tp,1000) and tc:IsReleasableByEffect() then
			Duel.SelectOption(tp,aux.Stringid(511000604,1))
			op=1
		end
		if op==0 then
			Duel.Destroy(tc,REASON_EFFECT)
		else
			Duel.PayLPCost(tp,1000)
			Duel.Release(tc,REASON_EFFECT)
		end
	end
end
