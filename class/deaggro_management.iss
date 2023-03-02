; Controls and staggers deaggros for various classes. Currently configured for Rangers.
function main()
{
	while 1
	{
		if ${Me.InCombat}==TRUE
		{
		If ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >50 || ${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Threat].Label} >50
		{
			while ${Me.CastingSpell}==True
			{
				wait 1
			}
			OgreBotAtom a_CastFromUplink ${Me.Name} "Evasive Maneuvers" TRUE
			echo Deaggroing...
			wait 75
			If ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >50 || ${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Threat].Label} >50
			{
				while ${Me.CastingSpell}==True
				{
					wait 1
				}
				OgreBotAtom a_CastFromUplink ${Me.Name} "Miracle Shot" TRUE
				echo Deaggroing...
				wait 75
				If ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >50 || ${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Threat].Label} >50
				{
					while ${Me.CastingSpell}==True
					{
						wait 1
					}
					OgreBotAtom a_CastFromUplink ${Me.Name} "Smoke Bomb" TRUE
					echo Deaggroing...
					wait 75
				}
			}
		}
		wait 5
	}
}
}
