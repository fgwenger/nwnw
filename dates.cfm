<cfoutput>
<b>Pick dates for #UCase(url.place)#</b><P>

<form action="report.cfm" method="post" >
	<input name="place" type="hidden" value="#url.place#">
	<table>
	<TR><TD>FROM:</TD><TD><input name="from_date" type="text" value="#request.date_today#"></TD>
	<TR><TD>TO:</TD><TD><input name="to_date" type="text" value="#DateFormat(now(), 'mm/dd/yyyy')#"></TD>
	</table>
	<BR><input type="submit" value="Run">
</form>


</cfoutput>