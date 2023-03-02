; Controls and staggers deaggros for various classes. Currently configured for Rangers.
function main()
{
	declare Deaggro1 string "Evasive Maneuvers"
	declare Deaggro2 string "Miracle Shot"
	declare Deaggro3 string "Smoke Bomb"
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
			OgreBotAtom a_CastFromUplink ${Me.Name} ${Deaggro1} TRUE
			echo Deaggroing...
			wait 75
			If ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >50 || ${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Threat].Label} >50
			{
				while ${Me.CastingSpell}==True
				{
					wait 1
				}
				OgreBotAtom a_CastFromUplink ${Me.Name} ${Deaggro2} TRUE
				echo Deaggroing...
				wait 75
				If ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >50 || ${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Threat].Label} >50
				{
					while ${Me.CastingSpell}==True
					{
						wait 1
					}
					OgreBotAtom a_CastFromUplink ${Me.Name} ${Deaggro3} TRUE
					echo Deaggroing...
					wait 75
				}
			}
		}
		wait 5
	}
}
}
