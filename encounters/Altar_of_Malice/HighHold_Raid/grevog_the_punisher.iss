; Script to defeat Grevog the Punisher.
; Requires a non-fighter tank for flaweless kills due to tank-specific deathtouch mechanics.
; Jousts characters hit by the flaming cocktail to avoid the spread of effects
; Sets up the raid such that any non fighter can tank the boss after tank aggro is wiped. 
; Typically an assassin, dirge, or brigand ends up tanking.

function main()
{
	declare AggroStatus bool global FALSE
	if ${Me.Archetype.Equal[fighter]}==TRUE
	{
		eq2ex gsay Grevog start!
		eq2ex raid Grevog start!
		Event[EQ2_onIncomingText]:AttachAtom[Berserk]
	}
	call DeaggroFighters
	declare Testloc[3] float script
	OgreBotAtom SetBotPauseStatus FALSE
	declare TankDeathPhase bool global FALSE
	while 1
	{
		while ${Me.InCombat}==TRUE
		{
			Me:InitializeEffects
			wait 10
			if ${Me.Effect[detrimental,"Flaming Cocktail"](exists)}==TRUE
			{
				OgreBotAtom SetBotPauseStatus FALSE
				eq2ex raid Cocktail
				call Cocktail
			}
			elseif ${Me.Elemental}==-1
			{
				OgreBotAtom SetBotPauseStatus FALSE
				eq2ex raid CockTaileded
				call Cocktail
			}
			elseif ${AggroStatus}==FALSE && ${Actor[Grevog the Punisher].Target.Name.Equal[${Me.Name}]}==TRUE && ${Me.Archetype.NotEqual[fighter]}==TRUE
			{
				AggroStatus:Set[TRUE]
				irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 218 -110 -82.5
			}
			elseif ${AggroStatus}==TRUE && ${Actor[Grevog the Punisher].Target.Name.Equal[${Me.Name}]}==FALSE && ${Me.Archetype.NotEqual[fighter]}==TRUE
			{
				AggroStatus:Set[FALSE]
				irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 209 -110 -85.5
			}
			else
			{
				wait 5
			}
		}
		wait 5
	}
}


atom Berserk(string Text)
{
	if ${Me.Archetype.Equal[fighter]}==TRUE
	{
		if ${Text.Right[98].Equal["Grevog the Punisher goes berserk! BEWARE,  while berserk he can kill fighters with a single touch!"]}==TRUE
		{
				TankDeathPhase:Set[TRUE]
				call SnapsOff
				irc !c Me -CastOn all "Sever Hate" ${Me.Name}
				eq2ex berserk on
				if ${Me.Class.Equal["brawler"]}==TRUE && ${Actor[Grevog the Punisher].Target.Name.Equal[${Me.Name}]}==TRUE
				{
					irc !c Me -cast ${Me.Name} "Feign Death"
				}
				else
				{
					irc !c Me -ccsw ${Me.Name} 210 -110 -69
				}
				press `
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue
				eq2ex autoattack 0
				
		}
		if ${Text.Right[41].Equal["Grevog the Punisher is no longer berserk!"]}==TRUE
		{
			TankDeathPhase:Set[FALSE]
			if ${Me.Class.Equal["brawler"]}==TRUE
			{
				press x
			}
			OgreBotAtom SetBotPauseStatus FALSE
			call SnapsOn
			eq2ex berserk off
			irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 218 -110 -82.5
		}
	}
}

function DeaggroFighters()
{
	if ${Me.Archetype.Equal["fighter"]}==TRUE
	{
		irc !c Me -CCStack all "Sever Hate" FALSE
		irc !c Me -CCStack all "Sentinel Strike" FALSE -CCStack all "Shout" FALSE -CCStack all "Provoke" FALSE -CCStack all "Plant" FALSE
		irc !c Me -CCStack all "Peaceful Link" FALSE -CCStack all "Evasive Maneuvers" FALSE -CCStack all "Arcane Bewilderment" FALSE -CCStack all "Befuddle" FALSE -ccstack all "Paralyzing Strike" FALSE -ccstack all "Miracle Shot" FALSE
		wait 10
		;irc !c Me -CCStack all "Taunting Assault" FALSE -CCStack all "Taunting Blow" FALSE -CCStack all "Rescue" FALSE -CCStack all "Cry of the Warrior" FALSE -CCStack all "Insolence" FALSE -CCStack all "Jeering Onslaught" FALSE -CCStack all "Sneering Assault" FALSE
		wait 10
		irc !c Me  -CCStack all "Hyran's Seething Sonata" FALSE -CCStack all "Enraging Demeanor" FALSE -cancelmaintained "Peaceful Link" 
		wait 10
		irc !c Me -CancelMaintained "Hyran's Seething Sonata" -CancelMaintained "Armored" -CancelMaintained "Enraging Demeanor" -cancelmaintained "Peaceful Link" -UO all checkbox_settings_movetoarea TRUE 
		wait 10
		irc !c Me -cs all -ccs 209 -110 -85.5 -ccsw fighters 218 -110 -82.5 -cancelmaintained "Peaceful Link" 
		;wait 100
	}
}
function Cocktail()
{
	irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 186 -110 -101
	wait 10
	while ${Me.IsMoving}==TRUE && (${Me.Effect[detrimental,"Flaming Cocktail"](exists)}==TRUE || ${Me.Elemental}==-1)
	{
		if (${Math.Distance[${Me.X},${Me.Y},${Me.Z},189,-109,-102]} <=5) && (${Me.Effect[detrimental,"Flaming Cocktail"](exists)}==TRUE || ${Me.Elemental}==-1)
		{
			wait 5
			Testloc[1]:Set[${Me.X}]
			Testloc[2]:Set[${Me.Y}]
			Testloc[3]:Set[${Me.Z}]
			if ${Math.Distance[${Testloc[1]},${Testloc[2]},${Testloc[3]},189,-109,-102]} <2 && ${Me.IsMoving}==TRUE && (${Me.Effect[detrimental,"Flaming Cocktail"](exists)}==TRUE || ${Me.Elemental}==-1)
			{
				eq2ex shout omg stuck, get me out!
				press space
				wait 5
			}
		}
		else
		{
			wait 5
		}
	}
	Me:InitializeEffects
	wait 10
	if (${Me.Effect[detrimental,"Flaming Cocktail"](exists)}!=TRUE || ${Me.Elemental}!=-1)
	{
		if ${Actor[Grevog the Punisher].Target.Name.Equal[${Me.Name}]}==TRUE || (${Me.Archetype.Equal["fighter"]}==TRUE && ${TankDeathPhase}==FALSE)
		{
			irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 218 -110 -82.5
		}
		elseif (${Me.Archetype.Equal["fighter"]}==TRUE && ${TankDeathPhase}==TRUE)
		{
			irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 210 -110 -69
		}
		else
		{
			irc !c Me -cs ${Me.Name} -ccsw ${Me.Name} 209 -110 -85.5
		}
	}
}
function SnapsOff()
{
	if ${Me.Archetype.Equal["fighter"]}==TRUE
	{
		irc !c Me -ccstack ${Me.Name} "Sneering Assault" FALSE -ccstack ${Me.Name} "Rescue" FALSE -ccstack ${Me.Name} "Item: Malice of Lanys" FALSE -uo ${Me.Name} checkbox_settings_disablecaststack TRUE -uo ${Me.Name} checkbox_settings_meleeattack FALSE -uo ${Me.Name} checkbox_settings_rangedattack FALSE
		if ${Me.SubClass.Equal["monk"]}==TRUE
		{
			irc !c Me -ccstack ${Me.Name} "Provoking Stance" FALSE -ccstack ${Me.Name} "Peel" FALSE -ccstack ${Me.Name} "Hidden Opening" FALSE -ccstack ${Me.Name} "Mantis Leap" FALSE 
		}
		if ${Me.SubClass.Equal["berserker"]}==TRUE
		{
			irc !c Me -ccstack ${Me.Name} "Jeering Onslaught" FALSE -ccstack ${Me.Name} "Insolence" FALSE -ccstack ${Me.Name} "Cry of the Warrior" FALSE
		}
		if ${Me.SubClass.Equal["Guardian"]}==TRUE
		{
			irc !c Me -ccstack ${Me.Name} "Plant" FALSE -ccstack ${Me.Name} "Cry of the Warrior" FALSE
		}
	}
}



function SnapsOn()
{
	if ${Me.Archetype.Equal["fighter"]}==TRUE
	{
		irc !c Me -ccstack ${Me.Name} "Sneering Assault" TRUE -ccstack ${Me.Name} "Rescue" TRUE -ccstack ${Me.Name} "Item: Malice of Lanys" TRUE -uo ${Me.Name} checkbox_settings_disablecaststack FALSE -uo ${Me.Name} checkbox_settings_meleeattack TRUE -uo ${Me.Name} checkbox_settings_rangedattack TRUE
		if ${Me.SubClass.Equal["monk"]}==TRUE
		{
			irc !c Me -ccstack ${Me.Name} "Provoking Stance" TRUE -ccstack ${Me.Name} "Peel" TRUE -ccstack ${Me.Name} "Hidden Opening" TRUE -ccstack ${Me.Name} "Mantis Leap" TRUE 
		}
		if ${Me.SubClass.Equal["berserker"]}==TRUE
		{
			irc !c Me -ccstack ${Me.Name} "Jeering Onslaught" TRUE -ccstack ${Me.Name} "Insolence" TRUE -ccstack ${Me.Name} "Cry of the Warrior" TRUE
		}
		if ${Me.SubClass.Equal["Guardian"]}==TRUE
		{
			irc !c Me -ccstack ${Me.Name} "Plant" TRUE -ccstack ${Me.Name} "Cry of the Warrior" TRUE
		}
	}
}
	
