--Full Armor Gravitation
function c110000114.initial_effect(c)
        --Activate
        local e1=Effect.CreateEffect(c)
        e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOGRAVE)
        e1:SetType(EFFECT_TYPE_ACTIVATE)
	    e1:SetCode(EVENT_FREE_CHAIN)
        e1:SetCondition(c110000114.con)
        e1:SetOperation(c110000114.op)
        c:RegisterEffect(e1)
end
function c110000114.con(e,tp,eg,ep,ev,re,r,rp)
        return Duel.IsExistingMatchingCard(c110000114.cfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>9
end
function c110000114.cfilter(c)
        return c:IsCode(110000104) and c:IsFaceup()
end
function c110000114.filter(x)
        return x:IsSetCard(0x3A2E) and x:IsType(TYPE_MONSTER) and x:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c110000114.op(e,tp,eg,ep,ev,re,r,rp)
        local dcount=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
        local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
        local g=Duel.GetDecktopGroup(tp,10)
        local tc=g:GetFirst()
        local dlist=Group.CreateGroup()
        local count=10
        local sumcount=0
        Duel.ConfirmDecktop(tp,10)
        if ft>0 then
            while count>0 do
                if tc:IsSetCard(0x3A2E)  then
                    dlist:AddCard(tc)
                end
                count=count-1
                tc=g:GetNext()
            end
            local sg
            if dlist:GetCount()>0 then
                Duel.DisableShuffleCheck()
                Duel.BreakEffect()
                Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
                sg=dlist:Select(tp,ft,ft,nil)
                Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
                Duel.SpecialSummonComplete()
                if dlist:GetCount()>ft then
                    sumcount=ft
                    else
                    sumcount=dlist:GetCount()
                end
            end
        end
        Duel.DiscardDeck(tp,10-sumcount,REASON_EFFECT)
end