--Insight Magician
function c810000214.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c810000214.thcon)
	e2:SetTarget(c810000214.thtg)
	e2:SetOperation(c810000214.thop)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(97268402,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e3:SetRange(LOCATION_HAND)
	e3:SetCost(c810000214.cost)
	e3:SetTarget(c810000214.target)
	e3:SetOperation(c810000214.operation)
	c:RegisterEffect(e3)
end
function c810000214.thcon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	return tc and (tc:IsSetCard(0x98) or tc:IsSetCard(0x9f))
end

function c810000214.thfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x98) and not c:IsCode(810000214)
end
function c810000214.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable(e) and Duel.IsExistingMatchingCard(c810000214.thfilter,tp,LOCATION_DECK,0,1,nil) end
	local g=Duel.GetMatchingGroup(c810000214.dfilter,tp,LOCATION_SZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c810000214.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c810000214.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then 
			local tc=g:GetFirst()
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	end
end

function c810000214.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c810000214.filter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and (c:IsHasEffect(EFFECT_CHANGE_LSCALE) or c:IsHasEffect(EFFECT_CHANGE_RSCALE))
end
function c810000214.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c810000214.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000214.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c810000214.filter,tp,LOCATION_SZONE,0,1,1,nil)
end
function c810000214.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		if tc:IsCode(94415058) then
			e1:SetValue(1)
		end
		if tc:IsCode(91420254) then
			e1:SetValue(5)
		end
		if tc:IsCode(20409757) then
			e1:SetValue(8)
		end
			if tc:IsCode(11609969) then
			e1:SetValue(10)
		end
			if tc:IsCode(74605254) then
			e1:SetValue(1)
		end
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		tc:RegisterEffect(e2)
	end
end