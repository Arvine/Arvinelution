--旧神ノーデン
function c810000183.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c810000183.fscondition)
	e1:SetOperation(c810000183.fsoperation)
	c:RegisterEffect(e1)
	--extra att
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(2)
	c:RegisterEffect(e2)
	--actlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetOperation(c810000183.atkop)
	c:RegisterEffect(e3)
	--indestructable by effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetCondition(c810000184.incon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end

function c810000183.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c810000183.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end

function c810000183.ffilter1(c)
	return c:IsCode(810000181) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
end
function c810000183.ffilter2(c)
	return c:IsCode(810000182) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE)
end
function c810000183.fscondition(e,g,gc)
	if g==nil then return true end
	if gc then return false end
	return g:IsExists(c810000183.ffilter1,3,nil) or (g:IsExists(c810000183.ffilter1,1,nil) and g:IsExists(c810000183.ffilter2,1,nil))
end
function c810000183.fsoperation(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:Filter(Card.IsCode,nil,810000181)
	local g2=eg:Filter(Card.IsCode,nil,810000182)
	local ag=g1:Clone()
	ag:Merge(g2)
	local ct=3
	local mg=Group.CreateGroup()
	while ct>0 do
		if ct<2 then
			ag:Remove(Card.IsCode,nil,810000182)
		end
		local tc=ag:Select(tp,1,1,nil):GetFirst()
		if tc:GetCode()==810000181 then
			ag:RemoveCard(tc)
			ct=ct-1
		else
			ag:RemoveCard(tc)
			ct=ct-2
		end
		mg:AddCard(tc)
	end
	Duel.SetFusionMaterial(mg)
end

function c810000184.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c810000184.incon(e)
	return Duel.IsExistingMatchingCard(c810000184.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end