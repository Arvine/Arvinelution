--Black Cat’s Glare
function c810000230.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c810000230.condition)
	e1:SetOperation(c810000230.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78474168,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c810000230.negcost)
	e2:SetTarget(c810000230.target)
	e2:SetOperation(c810000230.activate2)
	c:RegisterEffect(e2)
end
function c810000230.cfilter(c)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and ph==PHASE_BATTLE and c:IsFacedown()
end
function c810000230.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c810000230.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c810000230.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
function c810000230.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0xf4) and Duel.IsExistingTarget(c810000230.filter2,tp,LOCATION_MZONE,0,1,c)
end
function c810000230.filter2(c)
	return c:IsFaceup()
end
function c810000230.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c810000230.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c810000230.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp)
		and (c810000230.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c810000230.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g2=Duel.SelectTarget(tp,c810000230.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc1)
end
function c810000230.activate2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	Duel.ChangePosition(g,POS_FACEDOWN_DEFENCE)
end
