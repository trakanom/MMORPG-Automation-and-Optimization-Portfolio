; Script for Brunhildre the Wench in F.S. Distillery: Beggars and Blighters [Raid]

function main()
{
	declare CurseName string script "Scabies"
	declare TimeLimit float script 10.0
	if ${Me.Archetype.Equal["fighter"]}==TRUE
	{
		eq2ex raid Wench start!
		irc !c me -ccstack all "Cure Curse" FALSE
	}
	while 1
	{
		while ${Me.InCombat}==TRUE
		{
			Me:InitializeEffects
			wait 10
			if ${Me.Effect[detrimental,${CurseName}](exists)}
			{
				while ${Me.Effect[detrimental,${CurseName}].Duration}>=${TimeLimit}
				{
					wait 5
					Me:InitializeEffects
					wait 10
				}
				if ${Me.Effect[detrimental,${CurseName}].Duration}<=${TimeLimit}
				{
					eq2ex raid I need a cure curse!
					eq2ex gsay I need a cure curse!
				}
			}
		}
	}
}
