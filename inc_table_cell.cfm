<CFOUTPUT>	<TD valign="top" style="font-size:0.8em">
		#loc#:<BR>#get_short_name(get_item_name.type)#
		<!--- <BR>(#num_of_days# days) --->
		<BR><i>Total</i>: #get_count.the_count#
		<!---
		<BR><i>Avg##</i>: #get_count.the_count/num_of_days#
		--->
		<BR><i>Sales</i>: #DollarFormat(Val(get_dollars.the_dollar))#
		<!---
		<CFIF Len(Trim(get_dollars.the_dollar)) NEQ 0>
			<BR><i>Avg$</i>: #DollarFormat(get_dollars.the_dollar/num_of_days)#
		<CFELSE>
			<BR><i>Avg$</i>: $0		
		</CFIF>
		--->
	</TD>
</CFOUTPUT>