--Red-Eyes Black Dragon Sword
function c170000193.initial_effect(c)
    --fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,74677422,c170000193.ffilter,1,true,true)
    --Equip Limit
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetValue(c170000193.eqlimit)
	c:RegisterEffect(e1)
    --Atk Boost
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c170000193.value)
	c:RegisterEffect(e2)
end        
function c170000193.eqlimit(e,c)
    return c:IsFaceup()
end
function c170000193.value(e,c)
	return Duel.GetMatchingGroupCount(c170000193.atkfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*500+1000
end
function c170000193.atkfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c170000193.ffilter(c)
	return c:IsCode(170000153) and c:IsType(TYPE_SPELL)
end