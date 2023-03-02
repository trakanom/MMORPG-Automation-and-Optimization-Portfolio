; Script to manage curse cures for Farozth in Ssraeshza Temple: Echoes of Time (Raid)
; Looks for the specific ability applied to the tank and requests a curse cure from healers.
function main()
{
	declare CurseName string script "Scaled Vengeance"
	declare TimeLimit float script 20.0
	if ${Me.Archetype.Equal["fighter"]}==TRUE
	{
		eq2ex raid Farozth start!
		oc !c me -ccstack all "Cure Curse" FALSE
	}
	while 1
	{
		while ${Me.InCombat}==TRUE
		{
			Me:InitializeEffects
			wait 10
			if ${Me.Effect[detrimental,${CurseName}](exists)}
			{
				eq2ex raid I need a cure curse!
				eq2ex gsay I need a cure curse!
				wait 5
			}
		}
	}
	eq2ex gsay Farozth End!
}
