; This script waits until combat starts, then swaps the character's ranged weapon out and back to debug the Finisher item effect.

function atexit()
{
	if ${Me.Class.Equal[predator]} || ${Me.Class.Equal[rogue]}
	{
		eq2ex gsay MY WEAPON BROKE
	}
}
function main()
{
	declare StateCounter bool script
	declare CurrentWeapon string Script
	while 1
	{
		if ${Me.InCombat}==TRUE && ${StateCounter}==FALSE
		{
			call CycleRangedSlot
			while ${Me.InCombat}==TRUE
			{
				wait 30
			}
			StateCounter:Set[FALSE]
		}
		wait 10
	}
}

function CycleRangedSlot()
{
	CurrentWeapon:Set["${Me.Equipment[Ranged].Name}"]
	wait 50
	Me.Inventory[Hullpiercer, Ship Destroyer]:Equip
	;Can modify ^ to be any temporary ranged item. v if no options.
	;Me.Equipment[Ranged]:UnEquip
	wait 30
	Me.Inventory[${CurrentWeapon}]:Equip
	StateCounter:Set[TRUE]
}
