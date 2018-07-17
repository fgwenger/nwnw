<cfoutput>
<b>Pick dates for #UCase(url.edevice_name)#</b><P>

<form action="machine.cfm" method="post" >
	<!---<input name="place" type="hidden" value="#url.edevice_name#">--->
	<input name="eport" type="hidden" value="#url.eport#">
	<table>
	<TR><TD>FROM:</TD><TD><input name="from_date" type="text" value="#request.date_today#"></TD>
	<TR><TD>TO:</TD><TD><input name="to_date" type="text" value="#request.date_today#"></TD>
	</table>
	<BR><input type="submit" value="Run">
</form>


</cfoutput>