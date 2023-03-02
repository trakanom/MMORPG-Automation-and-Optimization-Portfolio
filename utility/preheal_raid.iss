; loads up on prewards, HoTs, and has optional AoE avoidance.
function main()
{
	declare IRC1 string script "Sample_IRC_Handle1"
	declare IRC2 string script "Sample_IRC_Handle2"
	declare IRC3 string script "Sample_IRC_Handle3"
	declare IRC4 string script "Sample_IRC_Handle4"
	declare DPS1 string script "SampleDPS1"
	declare DPS2 string script "SampleDps2"
	declare DPS3 string script "SampleDPS3"
	declare DPS4 string script "SampleDPS4"
	declare Tank1 string script ${Me.Name}
	declare Tank2 string script "SampleOffTank2"
	declare Tank3 string script "SampleOffTank3"
	declare Tank4 string script "SampleOffTank4"
	irc !c ${IRC3} -caston All "Bolster" ${DPS3} -caston all "Ritual of Alacrity" ${DPS3} -caston all "Torpor" ${Tank3} -caston all "Oberon" ${Tank3} -caston all "Ancestral Ward" ${Tank3} -caston all "Photosynthesis" ${Tank3}
	irc !c ${IRC4} -caston All "Bolster" ${DPS4} -caston all "Ritual of Alacrity" ${DPS4} -caston all "Torpor" ${Tank4} -caston all "Oberon" ${Tank4} -caston all "Ancestral Ward" ${Tank4} -caston all "Photosynthesis" ${Tank4}
	oc !c Me -caston All "Bolster" ${DPS1} -caston all "Ritual of Alacrity" ${DPS1} -caston all "Torpor" ${Tank1} -caston all "Oberon" ${Tank1} -caston all "Ancestral Ward" ${Tank1} -caston all "Photosynthesis" ${Tank1}
	oc !c ${IRC2} -caston All "Bolster" ${DPS2} -caston all "Ritual of Alacrity" ${DPS2} -caston all "Torpor" ${Tank2} -caston all "Oberon" ${Tank2} -caston all "Ancestral Ward" ${Tank2} -caston all "Photosynthesis" ${Tank2}
	oc !c all -cast all "Flash of Brilliance" -cast all "Healstorm" -cast all "Umbral Barrier" -cast all "Umbral Warding" -cast all "Prophetic Ward" -cast all "Ward of the Untamed"
	oc !c all -cast all "Spirit Aegis" -cast all "Winds of Healing"
	;irc !c all -cast all "Bladedance"
	while ${Me.InCombat}==FALSE || ${Target.Distance} >10
	{
		wait 10
	}
	wait 15
	oc !c -cast all "Shadow" -cast all "Sandstorm"
	;-cast all "Victorious Concerto"
	;wait 40
	;oc !c Me -cast all "Bleedout"
}
