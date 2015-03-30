--Timaeus the Knight of Destiny
function c170000210.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c170000210.fscondition)
	e1:SetOperation(c170000210.fsoperation)
	c:RegisterEffect(e1)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(c170000210.splimit)
	c:RegisterEffect(e2)
	--ATK/DEF
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c170000210.atkop)
	c:RegisterEffect(e3)
	--Indestructible by Battle
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
c170000210.material_count=1
c170000210.material={170000202}
function c170000210.splimit(e,se,sp,st)
	return st==(SUMMON_TYPE_FUSION+170000202)
end
function c170000210.spfilter(c,mg)
	return (c:IsCode(170000202) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE))
		and mg:IsExists(Card.IsType,1,c,TYPE_MONSTER)
end
function c170000210.fscondition(e,mg,gc)
	if mg==nil then return false end
	if gc then return false end
	return mg:IsExists(c170000210.spfilter,1,nil,mg)
end
function c170000210.fsoperation(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c170000210.spfilter,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=eg:FilterSelect(tp,Card.IsType,1,63,g1:GetFirst(),TYPE_MONSTER)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c170000210.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	local s=0
	local s2=0
	local tc=g:GetFirst()
	while tc do
		local a=tc:GetAttack() 
		local d=tc:GetDefence()
		if a<0 then a=0 end
		if d<0 then d=0 end
		s=s+a
		s2=s2+d
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(s)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENCE)
	e2:SetValue(s2)
	c:RegisterEffect(e2)
end