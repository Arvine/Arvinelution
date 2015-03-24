--Apa ini 
function c810000119.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c810000119.target)
	e1:SetOperation(c810000119.operation)
	c:RegisterEffect(e1)
end

function c810000119.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker()
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsOnField,tp,0,LOCATION_MZONE,1,nil) and 
		at:IsControler(tp) and at:IsSetCard(0x287) and at:IsOnField() and at:IsCanBeEffectTarget(e) end
	local sg=Duel.GetMatchingGroup(Card.IsOnField,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c810000119.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(Card.IsOnField,tp,0,LOCATION_MZONE,nil)
	if sg:GetCount()>0 then
		Duel.ChangePosition(sg,POS_FACEUP_DEFENCE,0,POS_FACEUP_ATTACK,0)
		local tc=sg:GetFirst()
		while tc do
			local atk=tc:GetAttack()
			local def=tc:GetDefence()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(atk/2)
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_SET_DEFENCE_FINAL)
			e2:SetValue(def/2)
			e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
			tc:RegisterEffect(e2)
			tc=tg:GetNext()
		end
	end
end