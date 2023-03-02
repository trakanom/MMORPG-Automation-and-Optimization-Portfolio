; This script calculates relative (x,y,z) positions for 12 different characters.  These spots are variable with respect to the target, its hitbox size, the direction it is facing.
; The relative spacing is hard coded in response to the complexity of this fight. The format of each raid group was pre-determined.
function main()
{
	call InitializeVariables
	call spacing
}
function InitializeVariables()
{
	declare Raid[12,3] float script
	declare Num uint script
}
function spacing()
{
	Raid[12,1]:Set[${Math.Calc[ ${Target.X}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Sin[${Target.Heading}-${Math.Acos[(2.6+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}-${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})]}-90]}]} ]
	Raid[12,2]:Set[${Target.Y}]
	Raid[12,3]:Set[${Math.Calc[ ${Target.Z}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Cos[${Target.Heading}-${Math.Acos[(2.6+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}-${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})]}-90]}]}]
	Raid[6,1]:Set[${Math.Calc[ ${Target.X}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Sin[${Target.Heading}+${Math.Acos[(2.6+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})]}-90]}]} ]
	Raid[6,2]:Set[${Target.Y}]
	Raid[6,3]:Set[${Math.Calc[ ${Target.Z}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Cos[${Target.Heading}+${Math.Acos[(2.6+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})]}-90]}]}]
	wait 1
	Num:Set[8]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[12,1]}-(5.6+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})*${Math.Sin[${Target.Heading}]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[12,3]}-(5.6+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})*${Math.Cos[${Target.Heading}]}]}]
	wait 1
	Num:Set[9]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[8,1]}-(10+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[8].ID}].CollisionRadius}*${Actor[${Me.Raid[8].ID}].CollisionScale})*${Math.Sin[${Target.Heading}-125]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[8,3]}-(10+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[8].ID}].CollisionRadius}*${Actor[${Me.Raid[8].ID}].CollisionScale})*${Math.Cos[${Target.Heading}-125]}]}]	
	wait 1
	Num:Set[10]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[12,1]}-(12+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})*${Math.Sin[${Target.Heading}-45]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[12,3]}-(12+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[12].ID}].CollisionRadius}*${Actor[${Me.Raid[12].ID}].CollisionScale})*${Math.Cos[${Target.Heading}-45]}]}]	
	wait 1
	Num:Set[11]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[8,1]}-(13+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[8].ID}].CollisionRadius}*${Actor[${Me.Raid[8].ID}].CollisionScale})*${Math.Sin[${Target.Heading}-100]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[8,3]}-(13+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[8].ID}].CollisionRadius}*${Actor[${Me.Raid[8].ID}].CollisionScale})*${Math.Cos[${Target.Heading}-100]}]}]
	Raid[6,1]:Set[${Math.Calc[ ${Target.X}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Sin[${Target.Heading}-${Math.Acos[(2.6+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}-${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})]}+90]}]} ]
	Raid[6,2]:Set[${Target.Y}]
	Raid[6,3]:Set[${Math.Calc[ ${Target.Z}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Cos[${Target.Heading}-${Math.Acos[(2.6+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}-${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})]}+90]}]}]
	Raid[6,1]:Set[${Math.Calc[ ${Target.X}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Sin[${Target.Heading}+${Math.Acos[(2.6+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})]}+90]}]} ]
	Raid[6,2]:Set[${Target.Y}]
	Raid[6,3]:Set[${Math.Calc[ ${Target.Z}-(10+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale})*${Math.Cos[${Target.Heading}+${Math.Acos[(2.6+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})/(9+${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})]}+90]}]}]
	wait 1
	Num:Set[2]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[6,1]}-(5.6+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})*${Math.Sin[${Target.Heading}]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[6,3]}-(5.6+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})*${Math.Cos[${Target.Heading}]}]}]
	wait 1
	Num:Set[3]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[2,1]}-(10+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[2].ID}].CollisionRadius}*${Actor[${Me.Raid[2].ID}].CollisionScale})*${Math.Sin[${Target.Heading}+125]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[2,3]}-(10+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[2].ID}].CollisionRadius}*${Actor[${Me.Raid[2].ID}].CollisionScale})*${Math.Cos[${Target.Heading}+125]}]}]	
	wait 1
	Num:Set[4]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[6,1]}-(12+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})*${Math.Sin[${Target.Heading}+45]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[6,3]}-(12+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[6].ID}].CollisionRadius}*${Actor[${Me.Raid[6].ID}].CollisionScale})*${Math.Cos[${Target.Heading}+45]}]}]	
	wait 1
	Num:Set[5]
	Raid[${Num},1]:Set[${Math.Calc[${Raid[2,1]}-(13+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[2].ID}].CollisionRadius}*${Actor[${Me.Raid[2].ID}].CollisionScale})*${Math.Sin[${Target.Heading}+100]}]}]
	Raid[${Num},2]:Set[${Target.Y}]
	Raid[${Num},3]:Set[${Math.Calc[${Raid[2,3]}-(13+${Actor[${Me.Raid[${Num}].ID}].CollisionRadius}*${Actor[${Me.Raid[${Num}].ID}].CollisionScale}+${Actor[${Me.Raid[2].ID}].CollisionRadius}*${Actor[${Me.Raid[2].ID}].CollisionScale})*${Math.Cos[${Target.Heading}+100]}]}]
	wait 1
	irc !c all -cs all
	irc !c all -ccsw ${Me.Raid[12].Name} ${Raid[12,1]} ${Raid[12,2]} ${Raid[12,3]} -ccsw ${Me.Raid[8].Name} ${Raid[8,1]} ${Raid[8,2]} ${Raid[8,3]} -ccsw ${Me.Raid[9].Name} ${Raid[9,1]} ${Raid[9,2]} ${Raid[9,3]} -ccsw ${Me.Raid[10].Name} ${Raid[10,1]} ${Raid[10,2]} ${Raid[10,3]} -ccsw ${Me.Raid[11].Name} ${Raid[11,1]} ${Raid[11,2]} ${Raid[11,3]}
	irc !c all -ccsw ${Me.Raid[2].Name} ${Raid[2,1]} ${Raid[2,2]} ${Raid[2,3]} -ccsw ${Me.Raid[3].Name} ${Raid[3,1]} ${Raid[3,2]} ${Raid[3,3]} -ccsw ${Me.Raid[4].Name} ${Raid[4,1]} ${Raid[4,2]} ${Raid[4,3]} -ccsw ${Me.Raid[5].Name} ${Raid[5,1]} ${Raid[5,2]} ${Raid[5,3]} -ccsw ${Me.Raid[6].Name} ${Raid[6,1]} ${Raid[6,2]} ${Raid[6,3]} 
}
