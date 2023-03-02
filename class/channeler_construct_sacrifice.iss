; allows the channeler to ration their construct's health when using Construct's Sacrifice for more dps.
; Checks if amount of damage construct receives is tolerable to healing parameters before beginning.

function main()
{
	echo start
	declare Check string "Abcd"
	while 1
	{
		if ${Me.InCombat} == True
		{
			wait 15
			if ${Me.Pet[0].Health} >= 80
			{
				wait 15
				if ${Me.Pet[0].Health} >= 80
				{
					wait 15
					Check:Set[${Me.Maintained["Construct's Sacrifice"]}]
					if ${Check.NotEqual["Construct's Sacrifice"]} && ${Me.Pet[0].Health} >= 80
					{
						echo Checks passed, Casting sacrifice!
						while ${Me.CastingSpell}==True
						{
							wait 1
						}
						OgreBotAtom a_CastFromUplink ${Me.Name} "Construct's Sacrifice" TRUE
						wait 30
					}
					else
					{
						continue
						echo Too much damage, skipping sacrifice!
						wait 10
					}
				}
			}
		}
	}	
}
