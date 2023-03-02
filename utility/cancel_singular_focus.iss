; detects if Singular Focus is applied and cancels it.
; Singular Focus prevents user's area of effect auto attacks from triggering. Useful in many situations where you want to control damage or aggro.
; loops to avoid bug where the buff doesn't appear on maintained effects bar when the bar is overpopulated.
function main()
{
	declare Check string "Stuff"
	while 1
	{
		Check:Set[${Me.Maintained["Singular Focus"]}]
		if ${Check.Equal["Singular Focus"]}
		{
			Me.Maintained["Singular Focus"]:Cancel
			wait 1
		}
		else
		{
			break
		}
	}
}
