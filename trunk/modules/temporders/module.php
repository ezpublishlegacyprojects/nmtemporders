<?php

$Module = array( "name" => "Temp orders" );

$ViewList = array();
$ViewList["list"] = array( 	"script" 	=> "list.php",
				"functions" 	=> array( "view" ),
				"default_navigation_part" => 'ezshopnavigationpart',
    				"unordered_params" => array( "offset" => "Offset" ));

$FunctionList['view'] = array( );

?>
