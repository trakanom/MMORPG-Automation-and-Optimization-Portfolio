; Manages stacks of Sharpened Fangs on Farozth in Ssraeshza Temple: Echoes of Time (Raid).
; 3 mages (typically enchanters) will cycle through dispel magic.

function main()
{
	;\#FFFF00${PlayerName} attempted to dispel Farozth Ssravizh triggering a toxic spray to all nearby allies!
	eq2ex raid Smash da beetles, smashum
	declare uint whichchanter 1
	irc !c all -ccstack all "Absorb Magic" FALSE
	declare string Mage1 "SampleMage"
	declare string Mage2 "SampleMage"
	declare string Mage3 "SampleMage"
	while ${Me.Archetype.Equal[mage]}==TRUE
	{
		while ${Me.InCombat}==TRUE
		{
			Me:InitializeEffects
			Actor[Farozth Ssravizh]:InitializeEffects
			wait 10
			if ${Actor[Farozth Ssravizh].Effect[Sharpened Fangs](exists)}
			{	
				irc !c all -cast ${If[${Math.Calc[${whichchanter}%3]}==1,${Mage1},${If[${Math.Calc[${whichchanter}%3]}==2,${Mage2},${If[${Math.Calc[${whichchanter}%3]}==0,${Mage3},"WHAT"]}]}]} "Absorb Magic"
				whichchanter:Inc[1]
				wait 10
			}
			wait 5
		}
		wait 5
	}
	echo Y u do dis??
}
