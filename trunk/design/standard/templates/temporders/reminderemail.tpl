{set-block scope=root variable=subject}Trenger du hjelp til å fullføre ordren?{/set-block}
{set-block scope=root variable=email_sender}post@natur.no{/set-block}
{let url='http://www.naturalia.no/'}
Du mottar denne mailen fordi du {$order.created|l10n('datetime')} påbegynte en ordre på vårt nettsted
{$url} som ikke ble fullført.

Dersom du ikke mente å fullføre ordren, kan du se bort ifra denne mailen.

Hvis du derimot hadde problemer med å fullføre ordren, eller ikke var klar over at ordren
ikke ble fullført, vil gi gjerne hjelpe deg.

Vennligst forsøk på nytt, eller kontakt oss, så skal vi hjelpe deg gjennom prosessen.

{section show=$product_items|count|ge(1)}

Her er et sammendrag av din bestilling (som ikke ble fullført):


{section loop=$product_items}
* {$:item.item_count}x {$:item.object_name}

{/section}
{/section}


Med vennlig hilsen,

{ezini( 'SiteSettings', 'SiteName', 'site.ini' )}

{/let}