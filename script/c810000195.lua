--Rebirth
function c810000195.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCost(c810000195.cost)
	e1:SetCondition(c810000195.condition)
	e1:SetTarget(c810000195.target)
	e1:SetOperation(c810000195.operation)
	c:RegisterEffect(e1)
end
c810000195.list={[83104731]=12652643,[810000181]=810000182,[810000182]=810000183}
function c810000195.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	return true
end
function c810000195.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()>=1 and tc:IsSetCard(0x7) and tc:IsPreviousPosition(POS_FACEUP) and tc:GetPreviousControler()==tp
end
function c810000195.filter1(c,e,tp)
	local code=c:GetCode()
	local tcode=c810000195.list[code]
	return tcode and Duel.IsExistingMatchingCard(c810000195.filter2,tp,LOCATION_EXTRA,0,1,nil,tcode,e,tp)
end
function c810000195.filter2(c,tcode,e,tp)
	return c:IsCode(tcode) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c810000195.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000195.filter1,tp,LOCATION_SZONE,0,1,nil,e,tp)
	end
	local rg=Duel.SelectMatchingCard(tp,c810000195.filter1,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	e:SetLabel(rg:GetFirst():GetCode())
	Duel.SendtoGrave(rg,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c810000195.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local code=e:GetLabel()
	local tcode=c810000195.list[code]
	local tc=Duel.GetFirstMatchingCard(c810000195.filter2,tp,LOCATION_EXTRA,0,nil,tcode,e,tp)
	if tc and Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP) then
		tc:CompleteProcedure()
	end
end
