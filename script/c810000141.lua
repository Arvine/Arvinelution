--Destruction Magician
function c810000141.initial_effect(c)
  --pendulum summon
  aux.AddPendulumProcedure(c)
  --Activate
  local e1=Effect.CreateEffect(c)
  e1:SetType(EFFECT_TYPE_ACTIVATE)
  e1:SetCode(EVENT_FREE_CHAIN)
  c:RegisterEffect(e1)
  --convert Rank to Level
  local e2=Effect.CreateEffect(c)
  e2:SetType(EFFECT_TYPE_IGNITION)
  e2:SetRange(LOCATION_PZONE)
  e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
  e2:SetCountLimit(1)
  e2:SetTarget(c810000141.target)
  e2:SetOperation(c810000141.activate)
  c:RegisterEffect(e2)
end

function c810000141.filter(c,e,tp)
  return c:IsType(TYPE_XYZ)
end
function c810000141.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
  if chkc then return chkc:IsLocation(LOCATION_MZONE) and c810000141.filter(chkc,tp) end
  if chk==0 then return Duel.IsExistingTarget(c810000141.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
  Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
  Duel.SelectTarget(tp,c810000141.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
end
function c810000141.activate(e,tp,eg,ep,ev,re,r,rp)
  local tc=Duel.GetFirstTarget()
  if tc:IsRelateToEffect(e) and tc:IsFaceup() then
    local g=Duel.GetMatchingGroup(c810000141.filter2,tp,LOCATION_MZONE,0,nil)
    local lc=g:GetFirst()
    local lv=tc:GetRank()
		local e2=Effect.CreateEffect(e:GetHandler())
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetCode(EFFECT_CHANGE_RANK)
    e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
    e2:SetValue(lv)
    tc:RegisterEffect(e2)
  end
end