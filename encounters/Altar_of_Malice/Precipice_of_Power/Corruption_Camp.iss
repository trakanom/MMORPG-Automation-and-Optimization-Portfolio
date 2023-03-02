; allows a character sitting in Precipice of Power [Contested] to alert players when the contested mob Dread Armoloch of Corruption is up.
; Drops extremely valuable items
; Script is useful for monopolizing spawns

function main()
{
	declare Timer bool script FALSE
	declare WhoToNotify1 string "PlayerName"
	declare WhoToNotify2 string "PlayerName"
	while 1
	{
		if ${Actor[Dread Armoloch of Corruption].Name.Equal["Dread Armoloch of Corruption"]} && ${Timer}==FALSE
		{
			eq2ex raid Corruption up now!  ${Time}
			eq2ex gu Corruption up now!  ${Time}
			eq2ex tell ${WhoToNotify1} Corruption up now!  ${Time}
			eq2ex tell ${WhoToNotify2} Corruption up now!  ${Time}
			Timer:Set[TRUE]
		}
		else
		{
			wait 10
		}
	}
}
