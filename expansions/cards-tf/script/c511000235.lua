--Obelisk the Tormentor
function c511000235.initial_effect(c)
	--Summon with 3 Tribute
	c:SetUniqueOnField(1,1,511000235)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c511000235.sumoncon)
	e1:SetOperation(c511000235.sumonop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	e2:SetCondition(c511000235.setcon)
	c:RegisterEffect(e2)
	--Cannot be Set
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511000235.tgset)
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
	e5:SetOperation(c511000235.sumsuc)
	c:RegisterEffect(e5)
 	--Race "Warrior"
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_ADD_RACE)
	e6:SetValue(RACE_WARRIOR)
	c:RegisterEffect(e6)
	--Cannot be Tributed by Opponent
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_UNRELEASABLE_SUM)
	e7:SetValue(c511000235.tgvalue)
	c:RegisterEffect(e7)
    --Cannot Switch Controller
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e8:SetRange(LOCATION_MZONE)
	e8:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e8)
	--Cannot be Target
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_SINGLE)
	e9:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e9:SetRange(LOCATION_MZONE)
	e9:SetValue(1)
	c:RegisterEffect(e9)
    --Cannot be Destroyed by Card Effect
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e10:SetRange(LOCATION_MZONE)
	e10:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e10:SetValue(1)
	c:RegisterEffect(e10)
	--Cannot be Removed
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e11)
	--Cannot Send to Grave
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_SINGLE)
	e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e12)
	--Cannot Return to Hand
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(e13)
	--Cannot Return to Deck
	local e14=Effect.CreateEffect(c)
	e14:SetType(EFFECT_TYPE_SINGLE)
	e14:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e14:SetRange(LOCATION_MZONE)
	e14:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e14)
	--If Special Summoned: Send to Grave
	local e15=Effect.CreateEffect(c)
	e15:SetDescription(aux.Stringid(511000235,0))
	e15:SetCategory(CATEGORY_TOGRAVE)
	e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e15:SetRange(LOCATION_MZONE)
	e15:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e15:SetCountLimit(1)
	e15:SetCode(EVENT_PHASE+PHASE_END)
	e15:SetCondition(c511000235.stgcon)
	e15:SetTarget(c511000235.stgtg)
	e15:SetOperation(c511000235.stgop)
	c:RegisterEffect(e15)
	--Change Battle Target when Special Summoned in Defense Position
	local e16=Effect.CreateEffect(c)
	e16:SetDescription(aux.Stringid(511000235,0))
	e16:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e16:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e16:SetCode(EVENT_BE_BATTLE_TARGET)
	e16:SetRange(LOCATION_MZONE)
	e16:SetCountLimit(1)
	e16:SetCondition(c511000235.cbtcon)
	e16:SetOperation(c511000235.cbtop)
	c:RegisterEffect(e16)
	--God Hand Crusher
	local e17=Effect.CreateEffect(c)
	e17:SetDescription(aux.Stringid(511000235,1))
	e17:SetCategory(CATEGORY_DESTROY)
	e17:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e17:SetCode(EVENT_FREE_CHAIN)
	e17:SetHintTiming(TIMING_DAMAGE_STEP)
	e17:SetRange(LOCATION_MZONE)
	e17:SetCountLimit(1)
	e17:SetCost(c511000235.godhandcost)
	e17:SetTarget(c511000235.godhandtg)
	e17:SetOperation(c511000235.godhandop)
	c:RegisterEffect(e17)
	--ATK/DEF effects are only applied until the End Phase
	local e19=Effect.CreateEffect(c)
	e19:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e19:SetProperty(EFFECT_FLAG_REPEAT)
	e19:SetRange(LOCATION_MZONE)
	e19:SetCode(EVENT_PHASE+PHASE_END)
	e19:SetCountLimit(1)
	e19:SetOperation(c511000235.atkdefresetop)
	c:RegisterEffect(e19)
end
function c511000235.sumoncon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end
function c511000235.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511000235.setcon(e,c)
	if not c then return true end
	return false
end
function c511000235.tgset(e,c)
return c:IsAttribute(ATTRIBUTE_DEVINE)
end
function c511000235.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_MZONE+LOCATION_SZONE,LOCATION_SZONE+LOCATION_HAND,LOCATION_HAND)
	e1:SetTarget(c511000235.triggertg)
	e1:SetReset(RESET_EVENT+EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e1)
end
function c511000235.triggertg(e,c)
	return not c:IsRace(RACE_DEVINE) and not c:IsCode(3136426) and not c:IsCode(82732705) and not c:IsCode(72302403) and not c:IsCode(44656491) and not c:IsCode(85101228) 
	and not c:IsCode(12923641) and not c:IsCode(93087299) and not c:IsCode(85742772) and not c:IsCode(50045299) and not c:IsCode(52503575) and not c:IsCode(23950192) 
	and not c:IsCode(82498947) and not c:IsCode(63519819) and not c:IsCode(80233946) and not c:IsCode(100000240) and not c:IsCode(83965310)
end
function c511000235.tgvalue(e,re,rp)
local c=e:GetHandler()
 return not c:IsControler(tp)
end
function c511000235.stgcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
end
function c511000235.stgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end
function c511000235.stgop(e,tp,eg,ep,ev,re,r,rp)
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
function c511000235.cbtcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=Duel.GetAttackTarget()
	return c~=bt and bt:IsControler(tp) and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsDefencePos()
end
function c511000235.cbtop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c511000235.godhandcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 and Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler()) and Duel.GetFlagEffect(tp,511000235)==0 end
	Duel.RegisterFlagEffect(tp,511000235,RESET_PHASE+PHASE_END,0,1)
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c511000235.godhandtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000235,3))
	if Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) then
		op=Duel.SelectOption(tp,aux.Stringid(511000235,1),aux.Stringid(511000235,2))
	else
		Duel.SelectOption(tp,aux.Stringid(76922029,2))
		op=1
	end
	e:SetLabel(op)
	if op==0 then
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,4000)
	end
end
function c511000235.godhandop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==0 then
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
		Duel.Damage(1-tp,4000,REASON_EFFECT)
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
		end
	else
		if c:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetValue(999999999)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
			e2:SetCondition(c511000235.energymaxdmgcon)
			e2:SetOperation(c511000235.energymaxdmgop)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e2)
		end
	end
end
function c511000235.energymaxdmgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() or e:GetHandler()==Duel.GetAttacker()
end
function c511000235.energymaxdmgop(e,tp,eg,ep,ev,re,r,rp)
local X=Duel.GetLP(1-tp)
Duel.ChangeBattleDamage(ep,X)
end
function c511000235.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(c:GetBaseAttack())
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_DEFENCE_FINAL)
	e2:SetValue(c:GetBaseDefence())
	c:RegisterEffect(e2)
end