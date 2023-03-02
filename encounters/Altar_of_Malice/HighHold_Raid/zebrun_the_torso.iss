; Script to defeat Zebrun the Torso
; Requires high noxious resistance to survive
; Ideally, bards should have deadly dance and characters have Sprint cost reduction AAs spent.
; Essentially a kiting fight to avoid one-shot phases
; Moves back and forth between two locations depending on phase.

function main()
{
	declare SpellNumber int local 0
	declare MobName string local "Zebrun the Torso"
	declare SpellName string local "Vile Build-up"
	declare Jousting bool global FALSE
	declare SpellID uint local 0
	Event[EQ2_onIncomingText]:AttachAtom[TorsoClear]
	irc !c Me -UO all checkbox_settings_movetoarea TRUE -cs all -CCS -6 -110 -78 -ccsw fighters -6.5 -110 -85.8
	while 1
	{
		while ${Me.InCombat}
		{
			if ${SpellID}==0 && ${Actor[${MobName}].Effect[${SpellName}].MainIconID} >0
			{
				SpellID:Set[${Actor[${MobName}].Effect[${SpellName}].MainIconID}]
			}
			SpellNumber:Set[0]
			while ${SpellNumber:Inc} <= 5 &&  ${Actor[${MobName}].Effect[${SpellNumber}](exists)}
			{
				if ${Actor[${MobName}].Effect[${SpellNumber}].MainIconID} == ${SpellID}
				{
					;For testing
					;echo ${Time} ${Actor[${MobName}].Effect[${SpellNumber}].Name} ${Actor[${MobName}].Effect[${SpellNumber}].CurrentIncrements}
					if ${Actor[${MobName}].Effect[${SpellNumber}].CurrentIncrements} == 8 && ${Jousting}==FALSE
					{
						echo Dino-Might!
						Jousting:Set[TRUE]
						wait 35
						call Torso1
					}
					wait 10
				}
			}
			wait 10
		}
		wait 10
	}
}



function Torso1()
{
	irc !c Me -cs all -cast all "Quick Tempo"  -PetOff -cast all "Soul Shackle" -cast all "Spirit Aegis" -cast all "Umbral Barrier"
	if ${Math.Distance[${Actor[${Me.ID}].Loc},-6,-110,-78]} >80
	{
		irc !c Me -CCS -6 -110 -78 -ccsw fighters -6.5 -110 -85.8
		wait 5
	}
	elseif ${Math.Distance[${Actor[${Me.ID}].Loc},-9,-110,29]} >80
	{
		irc !c Me -CCS -9 -110 29 -ccsw fighters -8.6 -110 37.6
		wait 5
	}
	eq2ex act end
	wait 10
	irc !c Me -cast all "Maximized Protection" -cast all "Soul Shackle" -cast all "Spirit Aegis" -cast all "Umbral Barrier"
	wait 20
	irc !c Me -cast all "Healstorm" -cast all "Winds of Healing" -cast all "Healing Barrage" -cast all "Salubrious Invocation" -cast all "Prophetic Ward" -cast all "Transcendence" -cast all "Champion's Interception" -cast all "Unholy Warding"
	wait 30
	irc !c Me -cast all "Redirection"
}

atom TorsoClear(string Text)
{
	if ${Text.Right[59].Equal["Zebrun the Torso is no longer able to slay players at will!"]}==TRUE
	{
		echo Kaboom!
		Jousting:Set[FALSE]
		relay all eq2ex pet attack
		relay all eq2ex pet autoassist
		eq2ex act end
		eq2ex burp
	}
}
