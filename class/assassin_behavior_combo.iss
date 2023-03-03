; Controls assassin ability priorities along with a tailored cast stack configuration file to maximize assassin DPS around Fatal Followup chains.
; Times temp buffs, DoT rotations, ability resets, temporal mimicry, and other such factors when determining behavior.
function main()
{
	echo (${Time}) ASSASSIN START
	call variables
	while 1
	{
		while ${Me.InCombat}==TRUE
		{
			if (${Me.Ability[Concealment].TimeUntilReady}<=14 || ${Me.Ability[In Plain Sight].TimeUntilReady}<=14) && (${Me.Ability[Stealth Assault].IsReady}||${Me.Ability[Stealth Assault].TimeUntilReady}}<5)
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Stealth Assault" FALSE TRUE
			}
			call refresh
			if ((${Me.Maintained["Impale VII"].Name.Equal["Impale VII"]} || ${Me.Maintained["Impale VIII"].Name.Equal["Impale VIII"]} || ${Me.Ability[Impale].IsReady}==FALSE) || (${Me.Ability["Gushing Wound"].TimeUntilReady}>0 || ${Me.Maintained["Gushing Wound VIII"].Name.Equal["Gushing Wound VIII"]} || ${Me.Maintained["Gushing Wound IX"].Name.Equal["Gushing Wound IX"]} || ${Me.Maintained["Bleedout"].Name.Equal["Bleedout"]})) || (((${Target.Type.Equal["NamedNPC"]} || ${Target.Type.Equal["NPC"]}) && ${Target.Health}<=90) || ((${Target.Target.Type.Equal["NamedNPC"]} || ${Target.Target.Type.Equal["NPC"]}) && ${Target.Target.Health}<=90))
			{
				if ${Me.Ability[In Plain Sight].IsReady}==TRUE && ${Me.Ability[Fatal Followup].TimeUntilReady}<=3 && (${Me.Ability[Fatal Followup].TimeUntilReady} >= ${Me.Ability[Stealth Assault].TimeUntilReady}) && (((${Target.Type.Equal["NamedNPC"]} || ${Target.Type.Equal["NPC"]}) && ${TargetDist}<=5) || ((${Target.Target.Type.Equal["NamedNPC"]} || ${Target.Target.Type.Equal["NPC"]}) && ${TargetTargetDist}<=5))
				{
					;if ${Me.Ability[Mortal Blade].TimeUntilReady}<=3
					;{
						;irc !c all -CastOn all "Temporal Mimicry" ${Me.Name}
						;wait 5
					;} 
					call StealthOn
					while ${Me.Ability[Fatal Followup].TimeUntilReady}<=3 && ${Me.InCombat}==TRUE && (((${Target.Type.Equal["NamedNPC"]} || ${Target.Type.Equal["NPC"]}) && ${TargetDist}<=5) || ((${Target.Target.Type.Equal["NamedNPC"]} || ${Target.Target.Type.Equal["NPC"]}) && ${TargetTargetDist}<=5))
					{
						wait 5
					}
					call StealthOff
				}
				wait 10
			}
			else
			{
				wait 10
			}
		}
		while ${Me.InCombat}==FALSE
		{
			wait 10
		}
	}
}
function StealthOn()
{
	;echo (${Time})  Wax on
	if ${Math.Calc[${Time.SecondsSinceMidnight}-${MimicryTime}]}>=85
	{
		MimicryTime:Set[${Time.SecondsSinceMidnight}]
		irc !c all -CastOn all "Temporal Mimicry" ${Me.Name}
		echo (${Time})#Mimicry!
	}
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Shadow" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Scale of Sontalak" TRUE TRUE
	;if ${Me.Equipment[Fabled Vyemm's Mutagenic Heart].TimeUntilReady}<=5
	;{
	;	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Fabled Vyemm's Mutagenic Heart" TRUE TRUE
	;}
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Dragon Claws" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Predator's Final Trick" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Assassinate" TRUE TRUE
	wait 10
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "In Plain Sight" TRUE TRUE
	if ${Me.Ability["Bleedout"].Name.Equal["Bleedout"]}==TRUE
	{
		OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Concealment" TRUE TRUE
	}
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Concealment" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Jugular Slice" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Eviscerate" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Mortal Blade" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Massacre" TRUE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Stealth Assault" TRUE TRUE
	wait 40
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Fatal Followup" TRUE TRUE
}
function StealthOff()
{
	;echo (${Time})  Wax off
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "In Plain Sight" FALSE TRUE
	if ${Me.Ability["Bleedout"].Name.Equal["Bleedout"]}==TRUE
	{
		OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Concealment" FALSE TRUE
	}
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Concealment" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Jugular Slice" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Eviscerate" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Mortal Blade" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Assassinate" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Massacre" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Fatal Followup" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Predator's Final Trick" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Shadow" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Dragon Claws" FALSE TRUE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Scale of Sontalak" FALSE TRUE
	;OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Fabled Vyemm's Mutagenic Heart" FALSE TRUE
}
function variables()
{
	declare TargetTargetDist float script
	declare TargetDist float script
	declare MimicryTime int script 0
	declare PFTtimer int script 0
	declare ItemTimer int script 0
}
function refresh()
{
	TargetDist:Set[${Math.Calc[${Target.Distance}-(${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${Me.ToActor.CollisionRadius}*${Me.ToActor.CollisionScale})]}]
	TargetTargetDist:Set[${Math.Calc[${Target.Target.Distance}-(${Actor[${Target.Target.ID}].CollisionRadius}*${Actor[${Target.Target.ID}].CollisionScale}+${Me.ToActor.CollisionRadius}*${Me.ToActor.CollisionScale})]}]
}
	
	
	
	
	
