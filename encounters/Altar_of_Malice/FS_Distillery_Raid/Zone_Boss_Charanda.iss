; Script to manage AoE reactions for Charandra in F.S. Distillery: Beggars and Blighters [Raid]
; Crouches the when poison gas is in the room
; Stands everyone up to prevent retaliation fail condition
function main()
{
Event[EQ2_onIncomingText]:AttachAtom[DoStuff]
	while 1
	{
		wait 10
	}
}


 atom DoStuff(string Text)
 {
    if ${Text.Right[100].Equal["noxious gas cloud burns your lungs, there must be some way to get below the noxious gas!"]}
	{
		relay all press z
		echo ${Time} Crouching!
	}
	
	
	if ${Text.Right[100].Equal["The noxious gas cloud dissipates and Charanda begins looking around the room to see who is left! Don't give away your strategy!"]}
	{
		relay all press z
		echo ${Time} Standing!
	}
 }
