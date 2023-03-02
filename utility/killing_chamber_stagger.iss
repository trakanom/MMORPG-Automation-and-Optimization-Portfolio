; staggers Killing Chamber clickies across groups. Fill in ItemName with "Item: YourItemsName"
function main()
{
	declare WhichGroup[4] string script 
	WhichGroup[1]:Set[SampleIRC1]
	WhichGroup[2]:Set[SampleIRC2]
	WhichGroup[3]:Set[SampleIRC3]
	WhichGroup[4]:Set[SampleIRC4]
	declare ItemName string script "Item:FILL ME IN"
	declare Num uint script 0
	declare CombatFinished bool script FALSE
	while ${Me.InCombat}==TRUE
	{
		  if ${CombatFinished}==TRUE
				CombatFinished:Set[FALSE]
		  irc !c ${Whichgroup[${Math.Calc[${Num:Inc[1]}%5]} -ccstack all "${ItemName}" TRUE
	}
	if ${Me.InCombat}==FALSE && ${CombatFinished}==FALSE
	{
		  irc !c all -ccstack all "Item:Name" FALSE
		  CombatFinished:Set[TRUE]
	}
}
