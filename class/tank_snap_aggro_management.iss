
; The problem that this script addresses is that, in general, when configuring tank profiles they are for 1-group play. 
; So, the tanks want aggro to be on them all the time with few exceptions.
; In a raid, there are usually at LEAST 2 tanks. Without this script two tanks will constantly fight for aggro resulting in all cooldowns being burnt.
; This script monitors aggro for tanks and optimizes the rationing of hate position increasing abilities, or "snaps".
; If aggro is lost, it checks if the target of aggro is a tank or otherwise durable class.
; If they are not, it then intelligently executes taunts and snaps to build hate and take aggro back.
; Although this script was designed for berserkers and shadowknights, it can be adapted for any class, provided they had relevant skills.
function main()
{
	call InitializeVariables
	while 1
	{
		if ${Me.IsHated}==TRUE && ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Name].Label}].Type.Equal["NPC"]}
		{
			call IsItASquishy
			while ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Name].Label}].Type.Equal["NPC"]} && ${TargetCheck}==TRUE && ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Distance].Label} <= 5
			{
				if ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} <= 25 || ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >=96 && ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} <100
				{
					echo (${Time}) I should taunt here
					OgreBotAtom a_CastFromUplink ${Me.Name} "${QTaunt[1]}" TRUE
					wait 10
					if ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} <= 25 || ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} >=90
					{
						echo (${Time}) or here
						OgreBotAtom a_CastFromUplink ${Me.Name} "${QTaunt[2]}" TRUE
						wait 10
					}
				}
				for(abc:Set[1] ; ${abc} <= 4 && ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Threat].Label} <=99; abc:Inc[1])
				{
					if ${Recast[${abc},2].Equal[1]}
					{
						echo (${Time}) Lost aggro!  Casting ${Snaps[${abc}]}!
						OgreBotAtom a_CastFromUplink ${Me.Name} "${Snaps[${abc}]}" TRUE
						Recast[${abc},2]:Set[0]
						Recast[${abc},3]:Set[${Time.Timestamp}+${Recast[${abc},1]}]
						wait 12
						break
					}
				}
				for(abc:Set[1] ; ${abc} <= 4 ; abc:Inc[1])
				{
					if ${Time.Timestamp} >= ${Recast[${abc},3]} && ${Recast[${abc},2]} != 1
					{
						Recast[${abc},2]:Set[1]
						Recast[${abc},3]:Set[9999999999]
						Echo (${Time}) ${Snaps[${abc}]} is back up!
					}
				}
				wait 10
			}
			wait 10
		}
	}
}
function InitializeVariables()
{
	declare Snaps[4] string script
	declare Recast[4,3] int script
; Recast, Available, Time Available
	declare QTaunt[2] string script
	declare num int script
	declare abc int script
	declare mno int script
	declare xyz int script
	declare TargetCheck bool script
	call FighterList
	for(abc:Set[1] ; ${abc} <= 4 ; abc:Inc[1])
	{
		echo ${Snaps[${abc}]}
		for(xyz:Set[1] ; ${xyz} <= 3 ; xyz:Inc[1])
		{
			Echo ${Recast[${abc},${xyz}]}
		}
	}
			for(abc:Set[1] ; ${abc} <= 4 ; abc:Inc[1])
			{
				if ${Time.Timestamp} >= ${Recast[${abc},3]}
				{
					Recast[${abc},2]:Set[1]
					Recast[${abc},3]:Set[9999999999]
					Echo ${Snaps[${abc}]} is back up!
				}
			}
	
}
function FighterList()
{
	if ${Me.SubClass.Equal["berserker"]}
	{
		Snaps[1]:Set["Jeering Onslaught"]
		Recast[1,1]:Set[23]
		Snaps[2]:Set["Sneering Assault"]
		Recast[2,1]:Set[90]
		Snaps[3]:Set["Rescue"]
		Recast[3,1]:Set[150]
		Snaps[4]:Set["Cry of the Warrior"]
		Recast[4,1]:Set[150]
		QTaunt[1]:Set["Mock"]
		QTaunt[2]:Set["Enrage"]
	}
	if ${Me.SubClass.Equal["guardian"]}
	{
		Snaps[1]:Set["blank"]
		Recast[1]:Set["blank"]
		Snaps[2]:Set["blank"]
		Recast[2]:Set["blank"]
		Snaps[3]:Set["blank"]
		Recast[3]:Set["blank"]
		Snaps[4]:Set["blank"]
		Recast[4]:Set["blank"]		
		QTaunt[1]:Set["blank"]
		QTaunt[2]:Set["blank"]
	}
	if ${Me.SubClass.Equal["shadowknight"]}
	{
		Snaps[1]:Set["blank"]
		Recast[1]:Set["blank"]
		Snaps[2]:Set["Sneering Assault"]
		Recast[2]:Set[90]
		Snaps[3]:Set["Rescue"]
		Recast[3]:Set[150]
		Snaps[4]:Set["Touch of Death"]
		Recast[4]:Set[180]		
		QTaunt[1]:Set["blank"]
		QTaunt[2]:Set["blank"]
	}
	if ${Me.SubClass.Equal["monk"]}
	{
		Snaps[1]:Set["blank"]
		Recast[1]:Set["blank"]
		Snaps[2]:Set["blank"]
		Recast[2]:Set["blank"]
		Snaps[3]:Set["blank"]
		Recast[3]:Set["blank"]
		Snaps[4]:Set["blank"]
		Recast[4]:Set["blank"]		
		QTaunt[1]:Set["blank"]
		QTaunt[2]:Set["blank"]
	}
}
function IsItASquishy()
{
	if ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Class.Equal["berserker"]}
	{
		TargetCheck:Set[FALSE]
	}
	if ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Class.Equal["guardian"]}
	{
		TargetCheck:Set[FALSE]
	}
	if ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Class.Equal["monk"]}
	{
		TargetCheck:Set[FALSE]
	}
	if ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Class.Equal["bruiser"]}
	{
		TargetCheck:Set[FALSE]
	}
	if ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Class.Equal["paladin"]}
	{
		TargetCheck:Set[FALSE]
	}
	if ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Class.Equal["shadowknight"]}
	{
		TargetCheck:Set[FALSE]
	}
	else
	{
		TargetCheck:Set[TRUE]
	}
}	
