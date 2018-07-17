<cfoutput>
<b>Sales for #UCase(form.place)#</b><BR>
dates #form.from_date#-to-#form.to_date#
<BR>
<CFSET the_total = 0>
<table border="1">
<TR>
	<TH>Sold</TH><TH>Product</TH>
	<CFIF LCase(form.place) EQ 'shs'>
	<TH>1A</TH><TH>1B</TH><TH>2A</TH>
	</CFIF>
</TR>
<CFLOOP query="get_sales">
	<TR>
		<TD>#sold#</TD><td>#the_product#</td>
		<CFSET the_total = the_total +sold>
		<CFIF LCase(form.place) EQ 'shs'>
			<CFLOOP list="shs1a|shs1b|shs2a" delimiters="|" index="i">
			<CFSET request.subplace = i>
			<CFSET request.item_and = "AND item.item_id = #get_sales.item_id#">
			<CFINCLUDE template="qry_sales.cfm">
			<TD>#Evaluate("get_sales#i#.sold")#</TD>
			</CFLOOP>
		</CFIF>
	</TR>
</CFLOOP>
<TR><TD><b>#the_total#</b></TD><TD> </TD></TR>
</table>

<!---<CFDUMP var="#get_sales#"> --->



</cfoutput>
