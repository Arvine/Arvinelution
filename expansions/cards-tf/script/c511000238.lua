--Slifer the Sky Dragon
function c511000238.initial_effect(c)
	--Summon with 3 Tribute
	c:SetUniqueOnField(1,1,511000238)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000238.sumoncon)
	e1:SetOperation(c511000238.sumonop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c511000238.setcon)
	c:RegisterEffect(e2)
	--Cannot be Set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511000238.tgset)
	c:RegisterEffect(e3)
	--Summon Cannot be Negated
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e4)
	--Summon Success: Effects of non-DIVINE monsters Cannot be Activated
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetOperation(c511000238.sumsuc)
	c:RegisterEffect(e5)
	--Race "Dragon"
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_ADD_RACE)
	e6:SetValue(RACE_DRAGON)
	c:RegisterEffect(e6)
	--Original ATK/DEF
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_SET_BASE_ATTACK)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetValue(c511000238.atkdef)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_SET_BASE_DEFENCE)
	c:RegisterEffect(e8)
	--Cannot be Tributed by Opponent
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCode(EFFECT_UNRELEASABLE_SUM)
	e9:SetValue(c511000238.tgvalue)
	c:RegisterEffect(e9)
    --Cannot Switch Controller
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e10)
	--Cannot be Target
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(1)
	c:RegisterEffect(e11)
    --Cannot be Destroyed by Card Effect
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e12:SetValue(1)
	c:RegisterEffect(e12)
	--Cannot be Removed
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e13)
	--Cannot Send to Grave
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e14)
	--Cannot Return to Hand
	local e15=Effect.CreateEffect(c)
	e15:SetType(EFFECT_TYPE_SINGLE)
	e15:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e15:SetRange(LOCATION_MZONE)
	e15:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e15)
	--Cannot Return to Deck
	local e16=Effect.CreateEffect(c)
	e16:SetType(EFFECT_TYPE_SINGLE)
	e16:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e16:SetRange(LOCATION_MZONE)
	e16:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e16)
	--If Special Summoned: Send to Grave
	local e17=Effect.CreateEffect(c)
	e17:SetDescription(aux.Stringid(511000238,0))
	e17:SetCategory(CATEGORY_TOGRAVE)
	e17:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e17:SetRange(LOCATION_MZONE)
	e17:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e17:SetCountLimit(1)
	e17:SetCode(EVENT_PHASE+PHASE_END)
	e17:SetCondition(c511000238.stgcon)
	e17:SetTarget(c511000238.stgtg)
	e17:SetOperation(c511000238.stgop)
	c:RegisterEffect(e17)
	--Change Battle Target when Special Summoned in Defense Position
	local e18=Effect.CreateEffect(c)
	e18:SetDescription(aux.Stringid(511000238,0))
	e18:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e18:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e18:SetCode(EVENT_BE_BATTLE_TARGET)
	e18:SetRange(LOCATION_MZONE)
	e18:SetCountLimit(1)
	e18:SetCondition(c511000238.cbtcon)
	e18:SetOperation(c511000238.cbtop)
	c:RegisterEffect(e18)
	--Lightning Blast
	local e19=Effect.CreateEffect(c)
	e19:SetDescription(aux.Stringid(511000238,0))
	e19:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e19:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e19:SetRange(LOCATION_MZONE)
	e19:SetCode(EVENT_SUMMON_SUCCESS)
	e19:SetCondition(c511000238.lightningblastcon)
	e19:SetTarget(c511000238.lightningblasttg)
	e19:SetOperation(c511000238.lightningblastop)
	c:RegisterEffect(e19)
	local e20=e19:Clone()
	e20:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e20)
	local e21=e20:Clone()
    e21:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    c:RegisterEffect(e21)
	--ATK/DEF effects are only applied until the End Phase
	local e21=Effect.CreateEffect(c)
	e21:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e21:SetProperty(EFFECT_FLAG_REPEAT)
	e21:SetRange(LOCATION_MZONE)
	e21:SetCode(EVENT_PHASE+PHASE_END)
	e21:SetCountLimit(1)
	e21:SetOperation(c511000238.atkdefresetop)
	c:RegisterEffect(e21)
end
function c511000238.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000238.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000238.setcon(e,c)
	if not c then return true end
	return false
end
function c511000238.tgset(e,c)
return c:IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000238.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_MZONE+LOCATION_SZONE,LOCATION_SZONE+LOCATION_HAND,LOCATION_HAND)
	e1:SetTarget(c511000238.triggertg)
	e1:SetReset(RESET_EVENT+EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e1)
end
function c511000238.triggertg(e,c)
	return not c:IsRace(RACE_DEVINE) and not c:IsCode(3136426) and not c:IsCode(82732705) and not c:IsCode(72302403) and not c:IsCode(44656491) and not c:IsCode(85101228) 
	and not c:IsCode(12923641) and not c:IsCode(93087299) and not c:IsCode(85742772) and not c:IsCode(50045299) and not c:IsCode(52503575) and not c:IsCode(23950192) 
	and not c:IsCode(82498947) and not c:IsCode(63519819) and not c:IsCode(80233946) and not c:IsCode(100000240) and not c:IsCode(83965310)
end
function c511000238.adval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*1000
end
function c511000238.tgvalue(e,re,rp)
local c=e:GetHandler()
 return not c:IsControler(tp)
end
function c511000238.stgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511000238.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c511000238.stgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
		Duel.BreakEffect()
		Duel.SendtoGrave(c,REASON_EFFECT)
	end
end
function c511000238.cbtcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=Duel.GetAttackTarget()
	return c~=bt and bt:IsControler(tp) and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsDefencePos()
end
function c511000238.cbtop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c511000238.lightningblastfilter(c,e,tp)
	return c:IsControler(tp) and c:IsPosition(POS_FACEUP_ATTACK) or c:IsControler(tp) and c:IsPosition(POS_FACEUP_DEFENCE) and (not e or c:IsRelateToEffect(e))
end
function c511000238.lightningblastcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000238.lightningblastfilter,1,nil,nil,1-tp)
end
function c511000238.lightningblasttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetCard(eg)
end
function c511000238.lightningblastop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000238.lightningblastfilter,nil,e,1-tp)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc:IsPosition(POS_FACEUP_ATTACK) then
	while tc do
		local preatk=tc:GetAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-2000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		if preatk~=0 and tc:GetAttack()==0 then dg:AddCard(tc) end
		tc=g:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT)
	end
	local g=eg:Filter(c511000238.lightningblastfilter,nil,e,1-tp)
	local dg=Group.CreateGroup()
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc:IsPosition(POS_FACEUP_DEFENCE) then
	while tc do
		local preatk=tc:GetDefence()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENCE)
		e1:SetValue(-2000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		if preatk~=0 and tc:GetDefence()==0 then dg:AddCard(tc) end
		tc=g:GetNext()
	end
	Duel.Destroy(dg,REASON_EFFECT)
end
end
function c511000238.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(c511000238.atkdef)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENCE)
	c:RegisterEffect(e2)
end
function c511000238.atkdef(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_HAND,0)*1000
end