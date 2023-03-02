function main()
{
	call InitializeVariables
	while 1
	{
		if ${Me.InCombat}==TRUE
		{
			if ${Me.SubClass.NotEqual["channeler"]}
			{
				break
			}
			if ${ChanStay}==FALSE && ${moved}==FALSE && ${Math.Distance[${Me.ToActor.Loc},${OgreBotCampSpotLoc}]} < 5
			{
				OgreBotAtom atom_OgreBotChangeCampSpot ${Math.Calc[${Me.X}+1*${Math.Sin[${Me.Heading}]}]} ${Me.Y} ${Math.Calc[${Me.Z}+1*${Math.Cos[${Me.Heading}]}]}
				moved:Set[TRUE]
			}
			if ${moved}==TRUE && ${Math.Distance[${Me.ToActor.Loc},${OgreBotCampSpotLoc}]} > 3
			{
				moved:Set[FALSE]
			}
			num:Set[${If[${GroupOrRaid.Equal["Group"]},0,1]}]
			for (${num}<=${limit} ; num:Inc[1])
			{
				call CharInfo
				call WhatDo 
			}
		}
		else
		{
			num:Set[${If[${GroupOrRaid.Equal["Group"]},0,1]}]
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Arrow" FALSE TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Vector of Life" FALSE TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Barrage" FALSE TRUE
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Channeled Resurrection" FALSE TRUE
			if ${moved}==TRUE && ${Math.Distance[${Me.ToActor.Loc},${OgreBotCampSpotLoc}]} > 5
			{
				moved:Set[FALSE]
			}	
			heals[1]:Set[0]
			heals[2]:Set[0]
			heals[3]:Set[0]
			res:Set[0]
			call RaidCheck
			wait 25
		}
	}
}

function InitializeVariables()
{
	declare num int script 0
	declare GroupOrRaid string script "Bop"
	declare limit int script ${If[${GroupOrRaid.Equal["Group"]},5,24]}
	declare MyHitBox float script ${Math.Calc[${Me.ToActor.CollisionRadius} * ${Me.ToActor.CollisionScale}]}
	declare PlayerHitBox float script 0
	declare CharName string script "0"
	declare CharID uint script ${Target.ID}
	declare CharHP int script 0
	declare CharDist float script 0
	declare CharBox float script 0
	declare CharMobDist float script 0
	declare MobTarget uint script 0
	declare TTTTBox float script 0
	declare Front bool script FALSE
	declare Important bool script FALSE
	declare moved bool script FALSE
	declare ChanStay bool globalkeep
	call CharInfo
	call RaidCheck
	call QuadCheck
	ChanStay:Set[TRUE]
	
	;for calc of angle
	declare delX float script 
	declare delZ float script 
	declare delLoc float script 1
	declare Angle float script
	
	;counts to reset on each loop
	declare heals[3] float script 0
	;heals[1] raw number, heals[2] heal weight, heals[3] vector check
	declare res int script 0
	declare healraw int script 0
}
function CharInfo()
{
	if ${GroupOrRaid.Equal["Group"]}
	{
		CharName:Set[${Me.Group[${num}].Name}]
		CharID:Set[${Me.Group[${num}].ID}]
	}
	elseif ${GroupOrRaid.Equal["Raid"]}
	{
		CharName:Set[${Me.Raid[${num}].Name}]
		CharID:Set[${Me.Raid[${num}].ID}]
	}
	CharHP:Set[${Actor[${CharID}].Health}]
	CharBox:Set[${Math.Calc[${Actor[${CharID}].CollisionRadius}*${Actor[${CharID}].CollisionScale}]}]
	CharDist:Set[${Math.Calc[${Actor[${CharID}].Distance2D}-(${MyHitBox}+${CharBox})]}]
	If ${CharDist}<0
	{
		CharDist:Set[0]
	}
	If ${Target.Type.Equal["PC"]} && ${Target.Target.Type.Equal["NPC"]}
	{
		MobTarget:Set[${Target.Target.Target.ID}]
	}
	Elseif ${Target.Target.Type.Equal["PC"]} && ${Target.Type.Equal["NPC"]}
	{
		MobTarget:Set[${Target.Target.ID}]
	}
	TTTTBox:Set[${Math.Calc[${Actor[${MobTarget}].CollisionRadius}*${Actor[${MobTarget}].CollisionScale}]}]
	CharMobDist:Set[${Math.Calc[${Math.Distance[${Actor[${CharID}].Loc},${Actor[${MobTarget}].Loc}]}-(${CharBox}+${TTTTBox})]}]
	call QuadCheck
	call ImportantPersons
	call Tally
}
function RaidCheck()
{
	if ${Me.Group[1].RaidGroupNum}>=1
	{
		GroupOrRaid:Set["Raid"]
		limit:Set[24]
	}
	elseif ${Me.Group[1].RaidGroupNum}==NULL
	{
		GroupOrRaid:Set["Group"]
		limit:Set[5]
	}
}	
function QuadCheck()
{
	delLoc:Set[ ${If[${Actor[${CharID}].Distance2D}<=0,1,${Actor[${CharID}].Distance2D}]} ]
	delX:Set[ ${Math.Calc[(${Actor[${CharID}].Loc.X}-${Actor[${Me.ID}].Loc.X})/${delLoc}]} ]
	delZ:Set[ ${Math.Calc[(${Actor[${CharID}].Loc.Z}-${Actor[${Me.ID}].Loc.Z})/${delLoc}]} ]
	Angle:Set[ ${Math.Atan[${delZ}*1/${If[${delX.Equal[0]},1,${delX}]}]}]
	;to determine quadrant and subsequent angle relative to 0 degrees North:
	;Since arctan only returns values from -90 to 90 degrees and heading returns values of 0 to 360, need to set them in the same domain: 0 to 360
	if ${delX}<0
	{
		Angle:Set[90-${Angle}]
	}
	if ${delX}>0
	{
		Angle:Set[270-${Angle}]
	}
	;checking if difference in heading is less than 90 degrees
	if ${Math.Abs[${Me.Heading}-${Angle}]}<90
	{
		Front:Set[TRUE]
	}
	;uh-oh, what if we have a heading somewhere to the north-west and the target is slightly north-east?!  That would make this not work!
	elseif ${Math.Abs[${Me.Heading}-${Angle}]}>90
	{
		; Heading[270,360] is North through West; Heading[0,90] is North through East
		if (${Me.Heading} >=270 || ${Angle} >=270) && (${Me.Heading} <=90 || ${Angle} <=90)
		{
			if  ${Math.Abs[360-${Math.Abs[${Angle}-${Me.Heading}]}]}<=90
			{
				Front:Set[TRUE]
			}
			;I guess it didn't matter if it got this far.
			else
			{
				Front:Set[FALSE]
			}
		}
		;Making sure all value is falsified in all cases
		else
		{
			Front:Set[FALSE]
		}
	}
	else
	{
		Front:Set[FALSE]
	}
}
function Tally()
{
	If ${CharHP}<0
	{
		If ${CharDist}<=5.00
		{
			res:Inc[1]
			If ${Important}
			{
				res:Inc[1]
			}
			echo rescount ${res} 
		}
	}
	elseif ${CharHP}<=85 && ((${CharDist} <= 17.5 && ${Front}==TRUE) || ${CharMobDist} <= 15.00)
	{
		heals[1]:Inc[1]
		if ${CharHP}<=25
		{
			heals[2]:Inc[5]
		}
		if ${CharHP}<=40
		{
			heals[2]:Inc[2.5]
		}
		elseif ${CharHP}<=60
		{
			heals[2]:Inc[2]
		}
		elseif ${CharHP}<=75
		{
			heals[2]:Inc[1.4]
		}
		else
		{
			heals[2]:Inc[1.2]
		}
		If ${CharDist} <= 17.5 && ${Front}==TRUE
		{
			heals[3]:Inc[1]
			If ${Important}==TRUE
			{
				heals[3]:Inc[1]
			}
		}
		If ${Important}==TRUE && ${CharHP}<=75
		{
			heals[2]:Set[${heals[2]+2]
		}
	}
}
function WhatDo()
{
	if ${res}>=3 && ${Me.Ability[Channeled Resurrection].IsReady}==TRUE
	{
		OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Channeled Resurrection" TRUE TRUE
		wait 1
		res:Set[0]
		num:Set[${limit}]
	}
	if ${heals[2]}>=4.5
	{
		if ${heals[2]}>=8 && ${Me.Ability[Healing Barrage].IsReady}==TRUE && ${heals[1]}<=8
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Barrage" TRUE TRUE
			wait 20
		}
		elseif ${heals[3]}>=3 &&  ${Me.Ability[Healing Barrage].IsReady}==FALSE && ${Me.Ability[Vector of Life IV].IsReady}==TRUE
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Vector of Life" TRUE TRUE
			wait 20
		}
		else
		{
			If ${Me.Ability[Healing Barrage].IsReady}
			{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Barrage" TRUE TRUE
			}
			If ${Me.Ability[Vector of Life IV].IsReady} && ${heals[3]}>=3
			{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Vector of Life" TRUE TRUE
			}
			If ${Me.Ability[Healing Arrow IX].IsReady}==TRUE && ${Me.Ability[Healing Barrage].IsReady}==FALSE
			{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Arrow" TRUE TRUE
			}
			wait 20
		}
		;making function stop and restart at this point
		num:Set[${limit}]
	}
	if ${num}==${limit}
	{
		heals[1]:Set[0]
		heals[2]:Set[0]
		heals[3]:Set[0]
		res:Set[0]
		if ${Me.Ability[Healing Arrow IX].IsReady}==FALSE
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Arrow" FALSE TRUE
		}
		if ${Me.Ability[Vector of Life IV].IsReady}==FALSE
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Vector of Life" FALSE TRUE
		}
		if ${Me.Ability[Healing Barrage].IsReady}==FALSE
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Healing Barrage" FALSE TRUE
		}
		if ${Me.Ability[Channeled Resurrection].IsReady}==FALSE
		{
			OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Channeled Resurrection" FALSE TRUE
		}
	}
}
	
	
function:bool ImportantPersons()
{
	If ${Actor[${CharID}].Class.Equal["warden"]}
	{
		Important:Set[TRUE]
	}
	Elseif ${Actor[${CharID}].Class.Equal["dirge"]}
	{
		Important:Set[TRUE]
	}
	Elseif ${Actor[${CharID}].Class.Equal["channeler"]}
	{
		Important:Set[TRUE]
	}
	else
	{
		Important:Set[FALSE]
	}
}
	
