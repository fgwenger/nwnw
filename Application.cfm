<CFSET request.date_today = DateFormat(now(), 'mm/dd/yyyy')>

<CFFUNCTION name="get_short_name" returntype="string">
	<CFARGUMENT name="pFull" type="string" required="true">
	<CFSET var get_short_name_return = pFull>
	<CFIF Len(Trim(pFull)) GT 27>
		<CFSET get_short_name_return = "#Left(pFull, 13)#..#Right(pFull, 12)#">
	</CFIF>
	<CFRETURN get_short_name_return>
</CFFUNCTION>