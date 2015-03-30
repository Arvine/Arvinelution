--Fang of Critias
function c170000151.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c170000151.cost)
	e1:SetTarget(c170000151.target)
	e1:SetOperation(c170000151.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_CHANGE_TYPE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(TYPE_MONSTER)
	c:RegisterEffect(e2)
end
c170000151.list={[57728570]=170000150,[44095762]=170000154,[170000149]=170000155}
function c170000151.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c170000151.filter1(c,e,tp)
	local code=c:GetCode()
	local tcode=c170000151.list[code]
	return tcode and Duel.IsExistingMatchingCard(c170000151.filter2,tp,LOCATION_EXTRA,0,1,nil,tcode,e,tp)
end
function c170000151.filter2(c,tcode,e,tp)
	return c:IsCode(tcode) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c170000151.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c170000151.filter1,tp,LOCATION_SZONE,0,1,nil,e,tp)
	end
	local rg=Duel.SelectMatchingCard(tp,c170000151.filter1,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	e:SetLabel(rg:GetFirst():GetCode())
	Duel.SendtoGrave(rg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c170000151.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local code=e:GetLabel()
	local tcode=c170000151.list[code]
	local tc=Duel.GetFirstMatchingCard(c170000151.filter2,tp,LOCATION_EXTRA,0,nil,tcode,e,tp)
	if tc and Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP) then
		tc:CompleteProcedure()
	end
end