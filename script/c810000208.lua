--DDD
function c810000208.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c810000208.condition)
	e1:SetCost(c810000208.cost)
	e1:SetOperation(c810000208.activate)
	c:RegisterEffect(e1)
end
function c810000208.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c810000208.cfilter(c)
	return c:IsSetCard(0x10af) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c810000208.filter2(c)
	return c:IsSetCard(0xaf) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand() and c:GetLevel()<=4
end
function c810000208.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000208.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c26412047.cfilter,tp,LOCATION_GRAVE,0,nil)
	local tg=g:GetMaxGroup(Card.GetAttack)
	if tg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=tg:Select(tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.Remove(sg,POS_FACEUP,REASON_COST)
	else
		Duel.Remove(tg,POS_FACEUP,REASON_COST)
	end
end
function c810000208.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local g1=Duel.GetMatchingGroup(c810000208.filter2,tp,LOCATION_DECK,0,nil)
	if g1:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tg1=g1:Select(tp,1,1,nil)
		Duel.SendtoHand(tg1,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tg1)
	end
end
