; Utilizes an item with growing damage and growing caster health requirements, similar to an exponentially increasing Lifeburn.
; Calculates the incoming damage and determines in the next tick would kill the caster. Cancels the maintained ability if so.
; Useful script for maximizing the damage of lower damage classes, such as healers and utility, while balancing survival.

function main()
{
	;#Don't #Kill #Me #Eye !
	echo bertox start
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Shralok Totem of Diseased Blessings" TRUE
	declare check string "abcd"
	declare DoIBertox int globalkeep 1
	declare hpcheck float script
	declare canceled bool script
	declare CancelCount int globalkeep 0
	declare DeathCount int globalkeep 0
	while 1
	{
		if ${Me.InCombat}==TRUE && ${DoIBertox}==1
		{
			check:Set[${Me.Maintained["Bertoxxulous' Blessing III"]}]
			wait 1
			if ${check.Equal["Bertoxxulous' Blessing III"]}
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Shralok Totem of Diseased Blessings" FALSE
				canceled:Set[FALSE]
				echo -(${Time}) LIFEBURN!!
				for(hpcheck:Set[1]; ${hpcheck}<=90 && ${canceled}==FALSE && ${check.Equal["Bertoxxulous' Blessing III"]} ; hpcheck:Inc[1])
				{
					wait 8
					if (${hpcheck}%5)==0
					{
						echo (${Time}) ${Math.Calc[100*(${Me.Health}/${Me.MaxHealth})]}% hp, ${Math.Calc[(5+${hpcheck})]}% next tick
					}
					if ${Me.Health}<0
					{
						DeathCount:Inc[1]
					}
					if (${Me.Health}/${Me.MaxHealth}) <= ((0.05+ 0.01*${hpcheck})*(1-0.28)-.01)
					{
						CancelCount:Inc[1]
						eq2ex cancel_maintained Bertoxxulous' Blessing III
						canceled:Set[TRUE]
					}
					else
					{
						wait 2
					}
					if ${Me.Health}<0
					{
						DeathCount:Inc[1]
						echo !!!{${Time}) I died.
					}
					if ${canceled}==TRUE
					{
						echo !!!(${Time}) I have ${Math.Calc[100*(${Me.Health}/${Me.MaxHealth})]}% hp, but I will take ${Math.Calc[(5+${hpcheck})]}% damage next tick and it will kill me.  Canceled ${CancelCount} times and have died ${DeathCount} times during Bertoxxulous' Blessing III
						wait 1
					}
					check:Set[${Me.Maintained["Bertoxxulous' Blessing III"]}]
					if ${Me.InCombat}==FALSE
					{
						eq2ex cancel_maintained Bertoxxulous' Blessing III
					}
				}
			}
			else
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Shralok Totem of Diseased Blessings" TRUE
				wait 1
			}
		}
		if ${DoIBertox}==0
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Item:Shralok Totem of Diseased Blessings" FALSE
			wait 100
		}
		if ${Me.InCombat}==FALSE
		{
			eq2ex cancel_maintained Bertoxxulous' Blessing III
		}
		wait 2
	}
}
