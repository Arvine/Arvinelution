--Dragonpit Magician
function c810000218.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c810000218.descon)
	e2:SetCost(c810000218.descost)
	e2:SetTarget(c810000218.destg)
	e2:SetOperation(c810000218.desop)
	c:RegisterEffect(e2)
end

function c810000218.descon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,13-seq)
	return tc and tc:IsSetCard(0x98)
end
function c810000218.cfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsDiscardable() and c:IsAbleToGraveAsCost()
end
function c810000218.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c810000218.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c810000218.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c810000218.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c810000218.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c810000218.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000218.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c810000218.filter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c810000218.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end