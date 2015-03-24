--Box
function c810000144.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c810000144.condition)
	e1:SetTarget(c810000144.target)
	e1:SetOperation(c810000144.operation)
	c:RegisterEffect(e1)
end
function c810000144.cfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp and c:IsPreviousPosition(POS_FACEUP)
		and c:IsSetCard(0x2d3) 
end
function c810000144.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c810000144.cfilter,1,nil,tp)
end
function c810000144.spfilter(c,e,tp)
	return c:IsSetCard(0x2d3) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c810000144.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and chkc:GetControler()~=tp and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c810000144.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if not Duel.GetControl(tc,tp,PHASE_END,1) then
			if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
				Duel.Destroy(tc,REASON_EFFECT)
			end
			return
		end
	end
	local g=Duel.SelectMatchingCard(tp,c95026693.spfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,1-tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(c810000144.ctlop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabel(tp)
		tc:RegisterEffect(e1,true)
	end
end

function c810000144.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler()
	local p=e:GetLabel()
	if tc:GetControler()~=p and not Duel.GetControl(tc,p) and not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end