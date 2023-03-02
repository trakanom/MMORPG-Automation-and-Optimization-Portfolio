function main()
{
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chaos" FALSE TRUE
	while 1
	{
		while ${Me.InCombat}==TRUE && ${Me.Ability[Rampager's Resilience].TimeUntilReady} >= 0
		{
			if ${Me.Ability[Battle Frenzy].TimeUntilReady} >= 10
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chaos" TRUE TRUE
				wait 10
			}
			elseif ${Me.Ability[Battle Frenzy].TimeUntilReady} <= 10
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chaos" FALSE TRUE
				wait 10
			}
			if ${Me.Ability[Adrenaline].TimeUntilReady} <= 1 && ${Me.Maintained["Adrenaline"].Name.Equal["Adrenaline"]}==FALSE && ${Me.Maintained["Battle Frenzy"].Name.Equal["Battle Frenzy"]}==FALSE
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Adrenaline" TRUE TRUE
				wait 10
			}
			elseif ${Me.Maintained["Battle Frenzy"].Name.Equal["Battle Frenzy"]}==TRUE
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Adrenaline" FALSE TRUE
				wait 10
			}
		}
		if ${Me.InCombat}==FALSE
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chaos" FALSE TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Adrenaline" FALSE TRUE
			wait 10
		}
	}
}
