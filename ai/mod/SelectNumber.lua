--- OnSelectNumber ---
--
-- Called when AI has to declare a number. 
-- Example card(s): Reasoning
-- 
-- Parameters:
-- choices = table containing the valid choices
--
-- Return: index of the selected choice
function OnSelectNumber(choices)
  local result = nil
  local d = DeckCheck()
  if d and d.Number then
    result = d.Number(id,available)
  end
  if result~=nil then return result end
  -------------------------------------------
  -- The AI should always try to mill as many
  -- cards as possible with Card Trooper.
  -------------------------------------------
  if GlobalActivatedCardID == 85087012 -- Card Trooper
  or GlobalActivatedCardID == 83531441 -- Dante
  then
    GlobalActivatedCardID = nil
    if #AIDeck()>10 then
      return #choices
    else
      return 1
    end
  end

  -------------------------------------------
  -- Reset this variable if it gets this far.
  -------------------------------------------
  GlobalActivatedCardID = nil


  -- Example implementation: pick one of the available choices randomly
  return math.random(#choices)

end
