--Beckon to Darkness
function c511000418.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000418.target)
	e1:SetOperation(c511000418.activate)
	c:RegisterEffect(e1)
end
function c511000418.filter(c)
	return c:IsFaceup() and c:IsAbleToGrave()
end
function c511000418.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000418.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000418.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511000418.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000418.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc:IsFaceup() then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end