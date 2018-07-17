<cfoutput>
<CFPARAM name="form.from_date" default="9/5/2014">
<CFPARAM name="form.to_date" default="#request.date_today#">
<CFPARAM name="form.eport_id" default="#form.eport#">
<CFSET num_of_days = 0>
<CFLOOP from="1" to="#(DateDiff('d', form.from_date, form.to_date ))#" index="i">
	<CFIF DayOfWeek(DateAdd('d', -(i), form.to_date)) NEQ 1 and DayOfWeek(DateAdd('d', -(i), form.to_date)) NEQ 7>
		<cfset num_of_days = num_of_days  +1>
	</CFIF>
</CFLOOP>
<CFIF DayOfWeek( form.to_date) NEQ  1 and DayOfWeek( form.to_date) NEQ  7>
	<cfset num_of_days = num_of_days  +1>
</CFIF>
<!---2
<CFSET dow = DayOfWeek(form.to_date)>
<CFSWITCH expression="#dow#">
<CFCASE value="1">
	<CFIF num_of_days GT 2>
		<CFSET num_of_days = num_of_days -2>
	</CFIF>
</CFCASE>
<CFCASE value="7">
	<CFIF num_of_days GT 1>
		<CFSET num_of_days = num_of_days -1>
	</CFIF>
</CFCASE>
<CFDEFAULTCASE>
	<CFIF DOW GT num_of_days>
	</CFIF>
</CFDEFAULTCASE>
</CFSWITCH>
--->
<cfquery name="get_machine" datasource="vending">
	SELECT id, machine_id, machine_name, edevice_id
	FROM Vendor.machine
	WHERE edevice_id = '#form.eport_id#'
</cfquery>

<B>For #get_machine.machine_name#</B><BR>
#form.from_date# - #form.to_date# (#num_of_days# days)
<BR><BR>
<CFIF form.to_date EQ form.from_date>
	<CFSET date_and = " AND EPORT_CAPTURE.trans_date = #CreateODBCDate(form.to_date)# ">
<CFELSE>
	<CFSET date_and = " AND EPORT_CAPTURE.trans_date >= #CreateODBCDate(form.from_date)# AND EPORT_CAPTURE.trans_date <= #CreateODBCDate(form.to_date)# ">
</CFIF>

<cfset a_list = "A1|A2|A3|A4|A5|B1|B2|B3|B4|B5|B6|C1|C2|C3|C4|C5|C6|C7|C8|C9|C10|D1|D2|D3|D4|D5|D6|D7|D8">
<cfset a_deep = 7>
<cfset b_list = "B1|B2|B3|B4|B5|B6">
<cfset b_deep = 7>
<cfset c_list = "C1|C2|C3|C4|C5|C6|C7|C8|C9|C10">
<cfset c_deep = 14>
<cfset d_list = "D1|D2|D3|D4|D5|D6|D7|D8">
<cfset d_deep = 12>

<table border="1">
<tr>
<CFSET what_row = "-1">
<CFLOOP list="#a_list#" delimiters="|" index="loc">
<cfquery name="get_item_num" datasource="vending">
	SELECT item_id
	FROM Vendor.cust_mach_item
	WHERE machine_id = #get_machine.machine_id#
	AND setting = '#loc#'
</cfquery>
<!--- <CFDUMP var="#get_item_num#"><CFABORT>--->
<cfquery name="get_item_name" datasource="vending">
	SELECT type
	FROM Vendor.item
	WHERE item_id = #get_item_num.item_id#
</cfquery>
<cfquery name="get_count" datasource="vending">
	SELECT count(*) as the_count
	FROM Vendor.eport_capture
	WHERE device_id = '#form.EPORT_id#'
	AND setting = '#loc#'
	#PreserveSingleQuotes(date_and)#
</cfquery>
<!--- <CFDUMP var="#get_count#">  <CFABORT> --->
<cfquery name="get_dollars" datasource="vending">
	SELECT sum(trans_amount) as the_dollar
	FROM Vendor.eport_capture
	WHERE device_id = '#form.EPORT_id#'
	AND setting = '#loc#'
	#PreserveSingleQuotes(date_and)#
</cfquery>
<CFIF what_row NEQ Left(loc, 1)>
	<CFSET what_row = Left(loc, 1)>
	</tr><tr>
</CFIF>
<CFINCLUDE template="inc_table_cell.cfm">
</CFLOOP>
</tr>
</table>



</cfoutput>
<BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR><BR>
<CFDUMP var="#url#">