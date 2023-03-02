; Script to interrupt specific spells that a raidmob casts.
; Parameterizable, although without a dictionary structure it's a bit clunky.

function main()
{
	variable int melon
	call InitializeVariables
	for(melon:Set[0] ; ${melon}>=0 ; melon:Inc[1])
	{
		call CastCheck
		if ${IsCasting} == TRUE
		{
			for(num:Set[1];${num}<=3 && ${IsCasting} == TRUE;num:Inc)
			{
				if ${Spells[${num}].NotEqual["REPLACE"]}
				{
					echo (${Time})-Cast detected, interrupting with ${Spells[${num}]}!
					while ${Me.CastingSpell}==True
					{
						if ${Me.Class.Equal["enchanter"]} || ${Me.Class.Equal["bard"]} || ${Me.Class.Equal["warrior"]}
						{
							eq2ex clearabilityqueue
							eq2ex cancel_spellcast
							wait 1
							;eq2ex useability ${Spells[${num}]}
							;wait 15
						}
						else
						{
							wait 1
						}
					}
					eq2ex clearabilityqueue
					eq2ex cancel_spellcast
					wait 1
					;OgreBotAtom a_CastFromUplink ${Me.Name} ${Spells[${num}]} TRUE
					eq2ex useability ${Spells[${num}]}
					if ${Me.Class.Equal["enchanter"]} || ${Me.Class.Equal["bard"]}
						eq2ex gsay Interrupting ${MobName}'s ${aename}!
					wait 15
				}
				wait 1
				call CastCheck
			}
		}
		else
		{
			wait 1
		}
		if ${melon}%5==0	
		{
			call TargetData
		}
	}
}
function:bool TargetData()
{
	MobName:Set["<Insert 1 coin to continue>"]
	aename:Set["<Call now for a good time!>"]
	MainType:Set[${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Name].Label}].Type}]
	ImpType:Set[${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Type}]
	MainName:Set[${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Name].Label}]
	ImpName:Set[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}]

	wait 1
	if ${ImpType.Equal["NPC"]} || ${ImpType.Equal["NamedNPC"]}
	{
		MobName:Set[${ImpName}]
		Logical:Set[FALSE]		
	}
	if ${ImpType.Equal["PC"]}
	{
		MobName:Set[${MainName}]
		Logical:Set[TRUE]
	}
	wait 1
	if ${MobName.Equal["Fitzpitzle"]}
	{
		aename:Set["Discombobulation"]
	}
	if ${MobName.Equal["Grendish"]}
	{
		aename:Set["Frigid Exhale"]
	}	
	if ${MobName.Equal["a psychotic book minion"]}
	{
		aename:Set["Illiteracy"]
	}
	if ${MobName.Equal["an astral book minion"]}
	{
		aename:Set["Burning Knowledge"]
	}
	if ${MobName.Equal["Keplin"]}
	{
		aename:Set["Touch of Tomes"]
	}
	if ${MobName.Equal["Prime Inquisitor Darkthrall"]}
	{
		aename:Set["Carrion Plague"]
	}
	if ${Target.Name.Equal["an Allu'thoa augur"]}
	{
		aename:Set["Ashen Cleansing"]
	}
	if ${MobName.Equal["an Allu'thoa lavacrafter"]}
	{
		aename:Set["Magma Napalm"]
	}
	if ${MobName.Equal["an Allu'thoa lookout"]}
	{
		aename:Set["Ashen Cleansing"]
	}
	if ${MobName.Equal["Vexven Mucktail"]}
	{
		aename:Set["Consume Mana"]
	}
	if ${MobName.Equal["a fanatical zealot"]}
	{
		aename:Set["Inquisition"]
	}
	if ${MobName.Equal["Bzzkill the Honeymonger"]}
	{
		aename:Set["Stormrider's Call"]
	}
	else
	{
		aename:Set["Carrion Plague"]
	}
}
function:bool CastCheck()
{

	if ${Logical}
	{
		IsCasting:Set[${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Casting].Label.Equal[${aename}]}]
	}
	else
	{
		IsCasting:Set[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Casting].Label.Equal[${aename}]}]
	}
}
function:bool MyClass()
{

	if ${Me.SubClass.Equal["berserker"]}==TRUE
	{
		Spells[1]:Set["Mock"]
		Spells[2]:Set["Head Crush"]
		Spells[3]:Set["Mock"]
	}
	if ${Me.SubClass.Equal["guardian"]}==TRUE
	{
		Spells[1]:Set["Provoke"]
		Spells[2]:Set["Provoke"]
		Spells[3]:Set["Provoke"]
	}
	if ${Me.SubClass.Equal["monk"]}==TRUE
	{
		Spells[1]:Set["Challenge"]
		Spells[2]:Set["Challenge"]
		Spells[3]:Set["Challenge"]
	}
	if ${Me.SubClass.Equal["shadowknight"]}==TRUE
	{
		Spells[1]:Set["Blasphemy"]
		Spells[2]:Set["Blasphemy"]
		Spells[3]:Set["Blasphemy"]
	}
	if ${Me.SubClass.Equal["ranger"]}==TRUE || ${Me.SubClass.Equal["assassin"]}==TRUE
	{
		Spells[1]:Set["REPLACE"]
		Spells[2]:Set["Hilt Strike"]
		Spells[3]:Set["Hilt Strike"]
	}
	if ${Me.SubClass.Equal["brigand"]}==TRUE
	{
		Spells[1]:Set["Bum Rush"]
		Spells[2]:Set["Hilt Strike"]
		Spells[3]:Set["Bum Rush"]
	}
	if ${Me.SubClass.Equal["illusionist"]}==TRUE
	{
		Spells[1]:Set["Spellblade's Counter"]
		Spells[2]:Set["Chromatic Storm"]
		Spells[3]:Set["REPLACE"]
	}
	if ${Me.SubClass.Equal["coercer"]}==TRUE
	{
		Spells[1]:Set["Hemorrhage"]
		Spells[2]:Set["Spellblade's Counter"]
		Spells[3]:Set["Hemorrhage"]
	}
	if ${Me.SubClass.Equal["warden"]}==TRUE
	{
		Spells[1]:Set["REPLACE"]
		Spells[2]:Set["Undergrowth"]
		Spells[3]:Set["REPLACE"]
	}
	if ${Me.SubClass.Equal["channeler"]}==TRUE
	{
		Spells[1]:Set["REPLACE"]
		Spells[2]:Set["Shadow Bind"]
		Spells[3]:Set["REPLACE"]
	}
	if ${Me.SubClass.Equal["dirge"]}==TRUE
	{
		Spells[1]:Set["Tarven's Crippling Crescendo"]
		Spells[2]:Set["Hilt Strike"]
		Spells[3]:Set["Hymn of Horror"]
	}
	oc My spells to interrupt are ${Spells[1]}, ${Spells[2]}, and ${Spells[3]}.
}
function InitializeVariables()
{
	declare Spells[3] string script
	declare IsCasting bool script
	declare MainType string script ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Name].Label}].Type}
	declare ImpType string script ${Actor[${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}].Type}
	declare MainName string script ${EQ2DataSourceContainer[GameData].GetDynamicData[Target.Name].Label}
	declare ImpName string script ${EQ2DataSourceContainer[GameData].GetDynamicData[ImpliedTarget.Name].Label}
	declare MobName string script "<Insert 1 coin to continue>"
	declare aename string script "<Call now for a good time!>"
	declare Logical bool script
	call MyClass
	declare num int script
}
