--Wicked God Dread Root
function c511000259.initial_effect(c)
	--Summon with 3 Tribute
	c:SetUniqueOnField(1,1,511000259)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000259.sumoncon)
	e1:SetOperation(c511000259.sumonop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c511000259.setcon)
	c:RegisterEffect(e2)
	--Cannot be Set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511000259.tgset)
	c:RegisterEffect(e3)
	--Summon Cannot be Negated
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e4)
	--Cannot be Special Summoned
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e5)
	--Cannot be Tributed by Opponent
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_UNRELEASABLE_SUM)
	e6:SetValue(1)
	c:RegisterEffect(e6)
    --Cannot Switch Controller
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e7)
	--unaffected
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(511000259,1))
	e8:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CANNOT_DISABLE)
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCountLimit(1)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetTarget(c511000259.untg)
	c:RegisterEffect(e8)
	--Cannot be Destroyed by Card Effect
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e9:SetValue(1)
	c:RegisterEffect(e9)
	--Cannot be Removed
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e10)
	--Cannot Send to Grave
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e11)
	--Cannot Return to Hand
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e12)
	--Cannot Return to Deck
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e13)
	--Unaffected by Trap Cards and non DIVINE Divine-Beast-Type monsters.
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_IMMUNE_EFFECT)
	e14:SetValue(c511000259.unaffectedval)
	c:RegisterEffect(e14)
	--Fear Dominates the Whole Field
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_FIELD)
	e15:SetCode(EFFECT_SET_ATTACK_FINAL)
	e15:SetRange(LOCATION_MZONE)
	e15:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e15:SetProperty(EFFECT_FLAG_REPEAT)
	e15:SetTarget(c511000259.feartg)
	e15:SetValue(c511000259.fearatkval)
	c:RegisterEffect(e15)
	local e16=e15:Clone()
	e16:SetCode(EFFECT_SET_DEFENCE_FINAL)
	e16:SetValue(c511000259.feardefval)
	c:RegisterEffect(e16)
end
function c511000259.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000259.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000259.setcon(e,c)
	if not c then return true end
	return false
end
function c511000259.tgset(e,c)
return c:IsRace(RACE_DEVINE)
end
function c511000259.unaffectedval(e,te)
	local c=te:GetHandler()
	return not te:IsActiveType(TYPE_SPELL) and not c:IsRace(RACE_DEVINE) and not c:IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000259.feartg(e,c)
	return c~=e:GetHandler() and not c:IsCode(511000259)
end
function c511000259.fearatkval(e,c)
	return c:GetAttack()/2
end
function c511000259.feardefval(e,c)
	return c:GetDefence()/2
end
function c511000259.untg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c511000259.efilter)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
	c:RegisterEffect(e2)
end
function c511000259.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
