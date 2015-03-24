--Moonlight Cat Dancer
function c810000118.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x287),2,true)
	--multiatk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21954587,2))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c810000118.atkcon)
	e2:SetCost(c810000118.atkcost)
	e2:SetTarget(c810000118.atktg)
	e2:SetOperation(c810000118.atkop)
	c:RegisterEffect(e2)
end

function c810000118.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()~=1 and Duel.GetCurrentPhase()==PHASE_MAIN1
		and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_BP)
end
function c810000118.rfilter(c)
	return c:IsSetCard(0x287)
end
function c810000118.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c810000118.rfilter,1,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,c810000118.rfilter,1,1,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c810000118.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c810000118.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_MZONE,0)
	local attg=dam-1
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(attg*2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	local tg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local tc=tg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			tc=tg:GetNext()
		end
end