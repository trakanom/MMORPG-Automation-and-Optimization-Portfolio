; runs the finditem function on all characters and centralizes results for ease of organization

function main(string SearchItem)
{
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	wait 10
	eq2ex finditem ${SearchItem}
	wait 10
	Script:End
}
atom EQ2_onIncomingText(string FoundItem)
{
	if ${FoundItem.Find[in inventory]}
		{
			oc ${Me.Name} - ${FoundItem.Token[2,:].Token[1,\\]}
		}
	if ${FoundItem.Find[no items were found]}
		{
			echo ${Me.Name} doesn't have the item you are looking for.
		}
}
