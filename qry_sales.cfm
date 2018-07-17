<CFPARAM name="request.qry_extra" default="">
<CFPARAM name="request.subplace" default="">
<CFPARAM name="request.item_and" default="">

<CFIF form.to_date EQ form.from_date>
	<CFSET date_and = " AND EPORT_CAPTURE.trans_date = #CreateODBCDate(form.to_date)# "> 
	<!--- <CFSET date_and = " AND (EPORT_CAPTURE.trans_date >= #CreateODBCDate(DateAdd('d', -1, form.to_date))# AND trans_time > #CreateODBCTime(DateAdd('h', -7, form.to_date))#) AND EPORT_CAPTURE.trans_date <= #CreateODBCDate(form.to_date)# "> --->
<CFELSE>
	<!--- <CFSET date_and = " AND EPORT_CAPTURE.trans_date >= #CreateODBCDateTime(DateAdd('h', -7, form.from_date))# AND EPORT_CAPTURE.trans_date <= #CreateODBCDate(form.to_date)# "> --->
	<CFSET date_and = " AND EPORT_CAPTURE.trans_date >= #CreateODBCDate(form.from_date)# AND EPORT_CAPTURE.trans_date <= #CreateODBCDate(form.to_date)# ">
</CFIF>
<CFSWITCH expression="#lcase(form.place)#">
<CFCASE value="shs">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id IN ( 'VJ100012548', 'VJ100012550','VJ100011876'  ) ">
</cfcase>
<CFCASE value="wcb">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id = 'VJ100011875' ">
</cfcase>
<CFCASE value="chaos">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id = 'VJ100012549' ">
</cfcase>

<CFCASE value="lenity">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id = 'VJ100011877' ">
</cfcase>

</CFSWITCH>

<CFSWITCH expression="#lcase(request.subplace)#">
<CFCASE value="shs1a">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id = 'VJ100012550' ">
	<CFSET request.qry_extra = request.subplace>
</cfcase>
<CFCASE value="shs2a">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id = 'VJ100011876' ">
	<CFSET request.qry_extra = request.subplace>
</cfcase>
<CFCASE value="shs1b">
	<CFSET place_and = " AND EPORT_CAPTURE.device_id = 'VJ100012548' ">
	<CFSET request.qry_extra = request.subplace>
</cfcase>
<CFDEFAULTCASE>
<!--- ignore --->
</CFDEFAULTCASE>

</CFSWITCH>

<cfquery name="get_sales#request.qry_extra#" datasource="vending">

SELECT COUNT( "ITEM"."item_id" ) AS "Sold", "ITEM"."item_id", "ITEM"."type" AS "The_Product" 
FROM "Vendor"."EPORT_CAPTURE" AS "EPORT_CAPTURE", "Vendor"."ITEM" AS "ITEM" 
WHERE "EPORT_CAPTURE"."item_id" = "ITEM"."item_id" 
#preservesinglequotes(place_and)#
#PreserveSingleQuotes(date_and)#
#PreserveSingleQuotes(request.item_and)#

<!--- AND "EPORT_CAPTURE"."trans_date" >= :start_date 
AND "EPORT_CAPTURE"."trans_date" <= NOW() --->
GROUP BY "ITEM"."item_id", "ITEM"."type" 
ORDER BY "Sold" DESC

</cfquery>