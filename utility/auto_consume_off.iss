; saves money during AFKs or low-difficulty activities by turning off autoconsumption of consumable items.
function main()
{
;stat pots
oc !c -StatPotions_AutoConsume All FALSE
wait 25
;food and drink
oc !c -FoodDrink_AutoConsume all FALSE
wait 25
;scout block
oc !c -Poison_AutoConsume all FALSE "Exemplar's Hemotoxin"
wait 25
oc !c -Poison_AutoConsume all FALSE "Infused Savant's Warding Ebb"
wait 25
oc !c -Poison_AutoConsume all FALSE "Infused Savant's Essence of Turgur"
wait 25
}
