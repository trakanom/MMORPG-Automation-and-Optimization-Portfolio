; summons a repair bot, instructs raid to repair, then dismisses the bot.
function main()
{
	oc !c -useitem ${Me.Name} "Mechanized Platinum Repository of Reconstruction"
	wait 50
	oc !c -repair
	wait 100
	eq2ex cancel_maintained Mechanized Platinum Repository of Reconstruction
}
