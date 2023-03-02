;Skottun, the Iron Forged Construct
	;80%
	;60%
	;40%
	;20%?
;Dhael, the Iron Forged Construct
	;75%
	;55%
	;35%
	;15%?
;Must be tanked at least 30m apart
;Health within 5% of each other
;Damage immunity at above percentages. Need to move mob in path of beam, between dome and door.
	;^\\#FFFF00A beam of focused energy is sent toward the Underfoot door!
	;^\\#00FF00Overloaded with the Underfoot magic, Brell's protection is removed from Skottun, the Iron Forged Construct!
	;^\\#00FF00Overloaded with the Underfoot magic, Brell's protection is removed from Dhael, the Iron Forged Construct!
;After immunity is removed, immediately move back, else immunity is reapplied
	;^\\#FF6600Exposed to the Underfoot magic, Skottun, the Iron Forged Construct becomes protected by Brell!
	;^\\#FF6600Exposed to the Underfoot magic, Dhael, the Iron Forged Construct becomes protected by Brell!
;^\\#FFFF00(\w+) becomes energized for a short time by the energy coming from the nearby Underfoot door! They may be able to interact with something to help the situation!
	;Character picked, must run down below and click switch for beam.
	;Respective named needs to be in place before before beam is fired.

;Raid Gaypile	65.28 87.86 237.20
;Skottun Tankspot1 85.96 87.86 231.45
;Skottun Tankspot2 107.45 87.86 231.39 HEALERS MOVE TO TANKSPOT 1
;Dhael Tankspot1 44.83 87.86 241.55
;Dhael Tankspot2 26.80 87.86 252.41

;Dhael Prebeam 81.59 87.86 269.29
;Skottun Prebeam 64.39 87.86 273.15
;Healers Prebeam 70.43 87.86 257.54 \\ 66.34 87.86 241.64
;Beam Spot Shared 71.44 87.86 262.80

;East steps1	28.83 87.86 223.77
;East steps2	37.67 80.42 189.72
;West steps1	94.52 87.86 212.56
;West steps2	75.35 80.42 178.37
;Shared steps3	53.76 80.42 186.30
;Shared steps4	61.51 88.13 219.18	APPLY VERB HERE



;Set up at center for priests, mages, scouts Loc: REPLACE
;Tanks offset by 15m towards their named.
;Tank groups stay on their respective mobs except in case of large hp difference (Construct of Malice/PK autotarget list, perhaps)
;Skottun dragged to beam area around 80%[81% perhaps](? Not sure if immunity is applied without anyone hitting beam)
;at 80%, Skottun dragged far right, no dps past 70% until Dhael unimmuned.
;



; Probably need slave script for beam running. Core of script below.
; If ${Text.Find[${Me.Name} becomes energized for a short time by the energy coming from the nearby Underfoot door! They may be able to interact with something to help the situation!](exists)}==TRUE
;	run movement shit

;	if ${Math.Distance[${Actor[${WhichMob}].X},${BeamX}]}<=ARBITRARY_RANGE_CHECK_REPLACE
;		(ASSUMING BEAM IS ALL ALONG THE AXIS)
;		apply verb on stone
;	run movement backwards


function Aliases()
{
	declare SkottunTank string global ${Me.Name}
	declare DhaelTank string global "SampleTank"
}
function VariableShit()
{
	declare Beamed bool global FALSE
}
function main()
{
	call Aliases
	Event[EQ2_onIncomingText]:AttachAtom[SteelBeams]
	oc !c all -ccstack all "Insolence" FALSE
	; taunts off on secondary tanks
	oc !c all -latl "Skottun" ${SkottunTank} -latl "Dhael" ${DhaelTank} -uo all checkbox_settings_movetoarea TRUE
	oc !c all -cs all -ccs all CENTERSPOT_REPLACE -ccsw ${SkottunTank} SKOTTUN_SPOT_1_REPLACE -ccsw ${DhaelTank} DHAEL_SPOT_1_REPLACE
	oc !c all -uo all checkbox_settings_ignoretargettoattackhealthcheck FALSE -uo ${SkottunTank} checkbox_settings_ignoretargettoattackhealthcheck TRUE -uo ${DhaelTank} checkbox_settings_ignoretargettoattackhealthcheck TRUE
	while ${Me.InCombat}==FALSE
	{
		wait 10
	}
	wait 80
	oc !c all -uo all checkbox_settings_ignoretargettoattackhealthcheck TRUE
	while ${Actor[Skottun].Health}>81
	{
		wait 10
	}
	if ${Actor[Skottun].Health}>=80 && ${Actor[Skottun].Health}<=82
	{
		oc !c all -ccsw ${SkottunTank} SHARED_LASER_SPOT_REPLACE
	}
}

atom SteelBeams(string Text)
{
	if ${Text.Find["Come out and join me, my brethren!"](exists)}==TRUE && ${CoffinUp}!=TRUE
	{
		CoffinUp:Set[TRUE]
	}
}



