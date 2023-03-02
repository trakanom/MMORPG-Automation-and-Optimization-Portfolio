; Handles mana management and jousting for the Bhoughbh Model XVII fight in Maldura: Bhoughbh's Folly [X2 Raid]

function main()
{
	declare Jousting bool script FALSE
	Event[EQ2_onIncomingText]:AttachAtom[Pulse]
	oc !c all -uo all checkbox_settings_movetoarea TRUE -cs all -ccs -162.21 -7.73 -72.85 -ccstack all "Manatap" TRUE
	EQ2EX GU Model XVII Start!
	while ${Me.InCombat}==FALSE
	{
		wait 10
	}
	oc !c all -ccs -143.59 -7.80 -99.21 -ccsw fighters -138.84 -7.51 -106.36
	while ${Actor[Bhoughbh Model XVII](exists)} && ${Actor[Bhoughbh Model XVII].Health}>0
	{
		if ${Jousting}==TRUE
		{
			oc !c all -cs all -ccs -162.21 -7.73 -72.85
			wait 130
			oc !c all -ccs -143.59 -7.80 -99.21 -ccsw fighters -138.84 -7.51 -106.36
			wait 20
			Jousting:Set[FALSE]
		}
		wait 20
	}
}

function atexit()
{
	oc !c all -letsgo all -uo fighters checkbox_settings_movetoarea FALSE -ccstack all "Manatap" FALSE
	EQ2EX GU Model XVII Start!
}


atom Pulse(string Text)
{
	if ${Text.Find[prepares to unleash a series of mighty static pulses](exists)}==TRUE
	{
		Jousting:Set[TRUE]
		eq2ex get out!
	}
}



