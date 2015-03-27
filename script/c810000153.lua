--The Fang of Critias
function c810000153.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c810000153.cost)
	e1:SetTarget(c810000153.target)
	e1:SetOperation(c810000153.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_ADD_CODE)
	e2:SetValue(10000052)
	c:RegisterEffect(e2)
end
c810000153.list={[44095762]=810000192}
function c810000153.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c810000153.filter1(c,e,tp)
	local code=c:GetCode()
	local tcode=c810000153.list[code]
	return tcode and Duel.IsExistingMatchingCard(c810000153.filter2,tp,LOCATION_EXTRA,0,1,nil,tcode,e,tp)
end
function c810000153.filter2(c,tcode)
	return c:IsCode(tcode)
end
function c810000153.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000153.filter1,tp,LOCATION_HAND+LOCATION_SZONE,0,1,nil,e,tp)
	end
	local g=Duel.GetMatchingGroup(c810000153.filter1,tp,LOCATION_HAND+LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c810000153.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetMatchingGroup(c810000153.filter1,tp,LOCATION_HAND+LOCATION_SZONE,0,nil,e,tp)
	local sg=g:Select(tp,1,1,nil)
	local rg=sg:GetFirst()
	local code=rg:GetCode()
	local tcode=c810000153.list[code]
	local tc=Duel.GetFirstMatchingCard(c810000153.filter2,tp,LOCATION_EXTRA,0,nil,tcode,e,tp)
	if tc then
		tc:SetMaterial(Group.FromCards(rg))
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end