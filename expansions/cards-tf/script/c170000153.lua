--Claw of Hermos
function c170000153.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c170000153.cost)
	e1:SetTarget(c170000153.target)
	e1:SetOperation(c170000153.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_CHANGE_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(TYPE_MONSTER)
	c:RegisterEffect(e2)
end	
c170000153.list={[25652259]=170000194,[74677422]=170000193,[110000110]=170000196,[30860696]=170000197,[71625222]=140000131}
function c170000153.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c170000153.filter1(c,tp)
	local code=c:GetCode()
	local tcode=c170000153.list[code]
	return tcode and Duel.IsExistingMatchingCard(c170000153.filter2,tp,LOCATION_EXTRA,0,1,nil,tcode,tp,c)
end
function c170000153.filter2(c,tcode,tp,z)
	return c:IsCode(tcode) and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,z)
end
function c170000153.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
        if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() and chkc:IsControler(tp) end
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.CheckReleaseGroup(tp,c170000153.filter1,1,nil,tp)
	end
    local rg=Duel.SelectMatchingCard(tp,c170000153.filter1,tp,LOCATION_MZONE,0,1,1,nil,tp)
	e:SetLabel(rg:GetFirst():GetCode())
	Duel.SendtoGrave(rg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
    local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c170000153.activate(e,tp,eg,ep,ev,re,r,rp)
    local et=Duel.GetFirstTarget()
	local code=e:GetLabel()
	local tcode=c170000153.list[code]
	local tc=Duel.GetFirstMatchingCard(c170000153.filter2,tp,LOCATION_EXTRA,0,nil,tcode,tp)
    Duel.Equip(tp,tc,et)
end