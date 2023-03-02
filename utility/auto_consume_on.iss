; turns autoconsume back on.
function main()
{
;stat pots autoconsume
oc !c -StatPotions_AutoConsume fighters TRUE "Thaumic Elixir of Fortitude"
oc !c -StatPotions_AutoConsume healers TRUE "Thaumic Elixir of Piety"
oc !c -StatPotions_AutoConsume mages TRUE "Thaumic Elixir of Intellect"
oc !c -StatPotions_AutoConsume scouts TRUE "Thaumic Elixir of Deftness"
wait 25
;food and drink autoconsume
oc !c -FoodDrink_AutoConsume all TRUE
wait 25
;scout block autoconsume
oc !c -Poison_AutoConsume all TRUE "Exemplar's Hemotoxin"
wait 25
oc !c -Poison_AutoConsume all TRUE "Expert Warding Ebb"
wait 25
oc !c -Poison_AutoConsume all TRUE "Expert Ignorant Bliss"
wait 25
oc !c -Poison_AutoConsume all TRUE "Expert Acidic Blast"
wait 25
oc !c -Poison_AutoConsume all TRUE "Expert Marked Target"
wait 25
}
