; This script monitors fluctuating stats through a multi-minute benchmark fight.
; This creates a file similar to a CSV that can be imported into pandas, cleaned, and analyzed.
; Combined with previously detailed efficiency and cast stack optimizing spreadsheets and Advanced Combat Tracker parse data, this brought my data closer to real fight conditions.
function main()
{
	declare Starting int script
	declare num int script
	eq2ex act end
	declare mainstat string script 
	timedcommand 10 OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_debug_chaintab FALSE
	timedcommand 15 OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_debug_announce FALSE
	timedcommand 20 OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_debug_whatisthebotdoing FALSE
	timedcommand 25 OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_debug_castingdetails FALSE
	timedcommand 30 OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_debug_castingextras FALSE
	timedcommand 35 OgreBotAtom aExecuteAtom ${Me.Name} a_UplinkControllerFunctionAutoType checkbox_debug_casting FALSE
	if ${Me.Archetype.Equal["scout"]}
	{
		mainstat:Set[Agility]
	}
	elseif ${Me.Archetype.Equal["fighter"]}
	{
		mainstat:Set[Strength]
	}
	elseif ${Me.Archetype.Equal["mage"]}
	{
		mainstat:Set[Intelligence]
	}
	elseif ${Me.Archetype.Equal["priest"]}
	{
		mainstat:Set[Wisdom]
	}
	wait 35
	while 1
	{
		if ${Me.InCombat}==TRUE
		{
			log ${Time.Timestamp}-${Me.Name}.txt
			wait 10
			echo ${Target.Name} ${Target.Target.Name} ${Time.Year}/${Time.Month}/${Time.Day} ${Time}
			Starting:Set[${Time.SecondsSinceMidnight}]
			echo Time#${mainstat}#Cb#Pot#Wdb#Dps#Flurry#SDA#MA#Haste${If[${Me.Archetype.Equal["fighter"]},"#ShieldEff#","#"]}Stamina
			while ${Me.InCombat}==TRUE
			{
				echo ${Math.Calc[${Time.SecondsSinceMidnight}-${Starting}]}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.${mainstat}].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Crit_Bonus].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Potency].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Weapon_Damage_Bonus].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.DPS].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Flurry].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.SpellDoubleAttack].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Double_Atk_Percent].Label}#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Haste].Label}#${If[${Me.Archetype.Equal["fighter"]},#${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Shield_Effectiveness].Label}#,"#"]}${EQ2DataSourceContainer[GameData].GetDynamicData[Stats.Stamina].Label}
				wait 10
				;if ${Math.Calc[${Time.SecondsSinceMidnight}-${Starting}]}>=1800
				;{
				;	eq2ex act end
				;	log off
				;	wait 1
				;	log ${Time.Timestamp}-${Me.Name}.txt
				;	Starting:Set[${Time.SecondsSinceMidnight}]
				;	wait 10
				;	echo ${Target.Name} ${Target.Target.Name} ${Time.Year}/${Time.Month}/${Time.Day} ${Time}
				;	echo Time#Agi#Cb#Pot#Wdb#Dps#Flurry#SDA#MA#Haste
				;}
			}
			log off
		}
		else
		{
			wait 10
		}
	}
}














