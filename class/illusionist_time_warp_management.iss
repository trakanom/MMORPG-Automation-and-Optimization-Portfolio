; This script was similar to others in that it holds back a lot of high damage abilities that are more potent when comboed than by themselves.
; See:  RO, Assasian, etc.
function main()
{
	declare PoMStatus bool script FALSE
	declare TimeWarpUp bool global FALSE
	Event[EQ2_onIncomingText]:AttachAtom[OmgTW]
	while 1
	{
		while ${Me.InCombat}==TRUE
		{
			if ${Me.Ability[Time Warp].TimeUntilReady} >=20 && ${Me.Ability[Peace of Mind].IsReady}==TRUE && ${PoMStatus}==FALSE
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Peace of Mind" TRUE
				PoMStatus:Set[TRUE]
				wait 5
			}
			elseif ${Me.Ability[Time Warp].IsReady}==TRUE && ${PoMStatus}==TRUE
			{
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Peace of Mind" FALSE
				PoMStatus:Set[FALSE]
				wait 5
			}
			if ${Me.Maintained[Time Warp Preparation].Name.Equal[Time Warp Preparation]}==TRUE
			{
				call HoldMePlz
				while (${Me.Maintained[Time Warp Preparation].Duration}>1 || ${TimeWarpUp}==FALSE) && ${Me.InCombat}==TRUE
				{
					wait 5
				}
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Theorems" TRUE
				wait 5
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Unda Arcanus Spiritus" TRUE
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Arcane Bewilderment" TRUE
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chromatic Shower" TRUE
				OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Blinding Shock" TRUE
				TimeWarpUp:Set[FALSE]
			}
			wait 5
		}
		if (${PoMStatus}==TRUE || ${TimeWarpUp}==TRUE) && ${Me.InCombat}==FALSE
		{
			TimeWarpUp:Set[FALSE]
			PoMStatus:Set[FALSE]
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Theorems" TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Unda Arcanus Spiritus" TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Arcane Bewilderment" TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chromatic Shower" TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Blinding Shock" TRUE
			wait 5
		}
		wait 5
	}
}
function HoldMePlz()
{
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Blinding Shock" FALSE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Theorems" FALSE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Unda Arcanus Spiritus" FALSE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Arcane Bewilderment" FALSE
	OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Chromatic Shower" FALSE
}


atom OmgTW(string Text)
{
	if ${Text.Right[31].Equal[Time Warp is now ready for use!]}
	{
		TimeWarpUp:Set[TRUE]
		eq2ex fgsfds
		; prevents spam
	}
}

