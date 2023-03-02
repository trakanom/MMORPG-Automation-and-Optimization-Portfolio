; prior to the Player Dungeon nerf, this script would level a character from 10 to max level inside 3-4 hours with a Mutagenic Burst/similar equipped tank.
; Order of ops:
; Zones into a specific player dungeon
; Turns on a preconfigured auto-hunt list
; Zones out when completed
; Collects the reward
; Repeat

function main()
{
	call Variables
	while 1
	{
		Event[EQ2_FinishedZoning]:AttachAtom[ZoningEvent]
		;start autohunt
		wait 30
		if ${Zone.Name.Equal[ASDASF XXIV: The Long Haul's Lair of Scale 4]}==TRUE
		{
			while ${Me.InCombat}==TRUE || ${Me.IsMoving}==TRUE
			{
				wait 25
			}
			if !${Me.InCombat} && !${Me.IsMoving} && ${Math.Distance[${Actor[${Me.ID}].Loc},${Actor[Dungeon Exit].Loc}]}<=10
			{
				echo Zoning in 15...
				wait 100
				if !${Me.InCombat}&&!${Me.IsMoving}
				{
					echo Zoning in 5...
					wait 50
					if !${Me.InCombat}&&!${Me.IsMoving}
					{
						echo Zoning!
						relay all Eq2Execute apply_verb ${Actor[Dungeon Exit].ID} Leave Dungeon
						timedcommand 10 relay all EQ2UIPage[playerhousing,saverating].Child[button,SaveRating.CancelButton]:LeftClick
						StateCounter:Set[TRUE]
					}
				}
			}
			else
			{
				wait 1
			}
		}
		elseif ${StateCounter}==FALSE && ${Zone.Name.Equal[ASDASF XXIV: The Long Haul's Lair of Scale 4]}==FALSE
		{
			call CollectRewards
		}
	}
}

function Variables()
{
	declare StateCounter bool script FALSE
}

atom ZoningEvent(string TimeInSeconds)
{
	if ${Zone.Name.Equal[ASDASF XXIV: The Long Haul's Lair of Scale 4]}==FALSE
	{
		call CollectRewards
	}
	elseif ${Zone.Name.Equal[ASDASF XXIV: The Long Haul's Lair of Scale 4]}==TRUE
	{
		call FreshZone
	}
}


function CollectRewards()
{
	echo CollectRewards
	StateCounter:Set[TRUE]
	timedcommand 100 relay all RewardWindow:Receive
	timedcommand 200 press =
	timedcommand 210 Mouse:SetBackgroundCursor[TRUE]
	timedcommand 210 Mouse:SetPosition[523,523]
	timedcommand 225 Mouse:LeftClick
}
function FreshZone()
{
	timedcommand 70 relay all OgreFollowOb:SetFollower[All,${Me.Name},3,100,FALSE]
	timedcommand 50 relay all OgreBotAtom a_QueueCommand DynamicAssist ${Me.Name} All
	timedcommand 50 execute run eq2ogrebot/Extras/AHMovement
}
