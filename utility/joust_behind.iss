; Sends all camped characters to a parameterized distance directly behind the user's current target. 
; Utilizes irc upllink to control raid members.
; Typical range is 15-25 meters.
function main(int joustrange)
{
	irc !c all -cs all -ccs ${Math.Calc[${Actor[${Target.ID}].X}+(${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${joustrange})*${Math.Sin[${Actor[${Target.ID}].Heading}]}]} ${Actor[${Target.ID}].Y} ${Math.Calc[${Actor[${Target.ID}].Z}+(${Actor[${Target.ID}].CollisionRadius}*${Actor[${Target.ID}].CollisionScale}+${joustrange})*${Math.Cos[${Actor[${Target.ID}].Heading}]}]}
}
