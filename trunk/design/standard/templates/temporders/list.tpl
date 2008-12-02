{section show=$sent_result}
	<div class="message-feedback">
	
		<h2>{'Reminders sent'|i18n( 'design/admin/shop/orderlist' )}</h2>
		
		<p>{'Reminders were sent for the orders with the following system ID:'|i18n( 'design/admin/shop/orderlist' )}</p>
		
		<ul>
		{section loop=$sent_result}
			<li>{$:item.id}</li>
		{/section}
		</ul>
	
	</div>
{/section}

{section show=$not_sent_result}
	<div class="message-error">
	
		<h2>{'Reminders not sent'|i18n( 'design/admin/shop/orderlist' )}</h2>
		
		<p>{'Reminders were not sent for the orders with the following system ID:'|i18n( 'design/admin/shop/orderlist' )}</p>
		
		<ul>
		{section loop=$not_sent_result}
			<li>{$:item.id}</li>
		{/section}
		</ul>
	
	</div>
{/section}


<div class="message-warning">

<h2>Midlertidige ordrer</h2>

<p>Denne ordrelisten inneholder midlertidige (påbegynte) ordrer som ikke er aktiverte av kunden.</p>

<p>Unnlatelse til å aktivere en ordre er som oftest et bevisst valg fra kundens side. Vær derfor påpasselig med å kun aktivere ordrer som ikke er blitt aktivert ved en feil.</p>

<p><strong>NB.</strong> Kunden vil <strong>ikke</strong> motta en ordrebekreftelse ved aktivering av ordren.</p>

</div>

<form name="orderlist" method="post" action={'/temporders/list'|ezurl}>

<div class="context-block">

{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Orders [%count]'|i18n( 'design/admin/shop/orderlist',, hash( '%count', $order_list|count ) )}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">

{section show=$order_list}
<div class="context-toolbar">
<div class="block">
<div class="left">
<p>
    <span class="current">Sortert etter tid</span>
</p>
</div>
<div class="right">
<p>
    <span class="current">Minkende</span>
</p>
</div>

<div class="break"></div>

</div>
</div>

<table class="list" cellspacing="0">
<tr>
    <th class="tight"><img src={'toggle-button-16x16.gif'|ezimage} alt="{'Invert selection.'|i18n( 'design/admin/shop/orderlist' )}" title="{'Invert selection.'|i18n( 'design/admin/shop/orderlist' )}" onclick="ezjs_toggleCheckboxes( document.orderlist, 'DeleteIDArray[]' ); return false;" /></th>
	<th class="tight">{'System ID'|i18n( 'design/admin/shop/orderlist' )}</th>
	<th class="wide">{'Customer'|i18n( 'design/admin/shop/orderlist' )}</th>
	<th class="tight">{'Total (ex. VAT)'|i18n( 'design/admin/shop/orderlist' )}</th>
	<th class="tight">{'Total (inc. VAT)'|i18n( 'design/admin/shop/orderlist' )}</th>
	<th class="wide">{'Time'|i18n( 'design/admin/shop/orderlist' )}</th>
</tr>
{section var=Orders loop=$order_list sequence=array( bglight, bgdark )}
<tr class="{$Orders.sequence}">
    <td><input type="checkbox" name="ActivateIDArray[]" value="{$Orders.item.id}" title="{'Select order for removal.'|i18n( 'design/admin/shop/orderlist' )}" /></td>
	<td><a href={concat( '/shop/orderview/', $Orders.item.id, '/' )|ezurl}>{$Orders.item.id}</a></td>
	<td><a href={concat( '/shop/customerorderview/', $Orders.item.user_id, '/', $Orders.item.account_email )|ezurl}>{$Orders.item.account_name}</a></td>
	<td class="number" align="right">{$Orders.item.total_ex_vat|l10n( currency )}</td>
	<td class="number" align="right">{$Orders.item.total_inc_vat|l10n( currency )}</td>
	<td>{$Orders.item.created|l10n( shortdatetime )}</td>
</tr>
{/section}
</table>
{section-else}
<div class="block">
<p>{'The order list is empty.'|i18n( 'design/admin/shop/orderlist' )}</p>
</div>
{/section}

<div class="context-toolbar">
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri='/temporders/list'
         item_count=$order_list_count
         view_parameters=$view_parameters
         item_limit=$limit}
</div>

{* DESIGN: Content END *}</div></div></div>
<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">

    <input class="button" type="submit" name="ActivateButton" value="Aktiver valgte" title="Akiver de valgte ordre" /><br />
	<input class="button" type="submit" name="DeleteButton" value="Slett valgte" title="Slett de valgte ordre" /> <strong>MERK.</strong> Slett kun ordrer som du er sikker på at ikke lenger er i bruk.<br />
    <input class="button" type="submit" name="ReminderButton" value="Purr p&aring; valgte" title="Purr p&aring; de valgte ordre" />

</div>
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</form>
