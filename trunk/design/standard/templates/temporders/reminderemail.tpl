{set-block scope=root variable=subject}Trenger du hjelp til � fullf�re ordren?{/set-block}
{set-block scope=root variable=email_sender}post@natur.no{/set-block}
{let url='http://www.naturalia.no/'}
Du mottar denne mailen fordi du {$order.created|l10n('datetime')} p�begynte en ordre p� v�rt nettsted
{$url} som ikke ble fullf�rt.

Dersom du ikke mente � fullf�re ordren, kan du se bort ifra denne mailen.

Hvis du derimot hadde problemer med � fullf�re ordren, eller ikke var klar over at ordren
ikke ble fullf�rt, vil gi gjerne hjelpe deg.

Vennligst fors�k p� nytt, eller kontakt oss, s� skal vi hjelpe deg gjennom prosessen.

{section show=$product_items|count|ge(1)}

Her er et sammendrag av din bestilling (som ikke ble fullf�rt):


{section loop=$product_items}
* {$:item.item_count}x {$:item.object_name}

{/section}
{/section}


Med vennlig hilsen,

{ezini( 'SiteSettings', 'SiteName', 'site.ini' )}

{/let}