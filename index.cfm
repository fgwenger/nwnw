<cfoutput>
<B>Refill</B>
<UL>
<LI><a href="dates.cfm?place=shs">SHS</a></LI>
</UL>
<UL>
<LI><a href="dates.cfm?place=chaos">CHAOS</a></LI>
</UL>
<UL>
<LI><a href="dates.cfm?place=lenity">Lenity Architecture</a></LI>
</UL>
<UL>
<LI><a href="dates.cfm?place=wcb">WCB</a></LI>
</UL>


<cfquery name="get_machines" datasource="vending">
	SELECT machine_id, machine_name, edevice_id
	FROM Vendor.machine
	order by machine_name
</cfquery>
<B>Machine Details</B>
<UL>
<CFLOOP query="get_machines">
	<LI><a href="machdate.cfm?eport=#edevice_id#&edevice_name=#machine_name#">#machine_name#</a></LI>
</CFLOOP>
</UL>

</cfoutput>