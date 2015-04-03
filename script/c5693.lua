--Mirror Force Dragon
function c5693.initial_effect(c)
    --cannot spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--destroy all
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET) 
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c5693.con1)
	e1:SetTarget(c5693.tg)
	e1:SetOperation(c5693.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING) 
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c5693.con2)
	e2:SetTarget(c5693.tg)
	e2:SetOperation(c5693.op)
	c:RegisterEffect(e2)
end
function c5693.con1(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	return	Duel.GetAttacker():GetControler()~=tp and c:IsFaceup()
end
function c5693.filter(c,tp)
    return c:IsType(TYPE_MONSTER) and c:IsControler(tp)
end
function c5693.con2(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end 
	local cinfo=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return cinfo:IsExists(c5693.filter,1,nil,tp) and rp~=tp and c:IsFaceup()
end
function c5693.tg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end 
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c5693.op(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then 
	    Duel.Destroy(g,REASON_EFFECT)
	end
end