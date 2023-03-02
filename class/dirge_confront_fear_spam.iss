; Distributed a buff in a rotation to 3 targets
; Normally not possible as this spell doesn't appear in the maintained window
; Waits for combat in a group, raid, or contested zone
; Then begins a staggered rotation

function main()
{
	declare Target1 string script "SampleDPS1"
	declare Target2 string script "SampleDPS2"
	declare Target3 string script "SampleDPS3"
	while 1
	{
		while ${Zone.Name.Find["Guild Hall"](exists)}==TRUE || ${Zone.Name.Find["Heroic"](exists)}==TRUE || ${Zone.Name.Find["Raid]"](exists)}==TRUE || ${Zone.Name.Find["Contested"](exists)}==TRUE
		{
			;assassin
			relay is1 eq2ex gsay Need CF
			;relay all OgreBotAtom a_CastFromUplinkOnPlayer ${Me.Name} "Confront Fear" ${Target1}
			wait 225
			;illy
			relay is5 eq2ex gsay Need CF
			;relay all OgreBotAtom a_CastFromUplinkOnPlayer ${Me.Name} "Confront Fear" ${Target2}
			wait 225
			;dirge (Maybe should do shaman, idk)
			relay is4 eq2ex gsay Need CF
			;relay all OgreBotAtom a_CastFromUplinkOnPlayer ${Me.Name} "Confront Fear" ${Target3}
			wait 270
		}
		wait 20
	}
}
