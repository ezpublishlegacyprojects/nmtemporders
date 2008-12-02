<?php

include_once( "extension/temporders/classes/temporder.php" );
include_once( "kernel/common/template.php" );
include_once( 'kernel/classes/ezpreferences.php' );

$offset = $Params['Offset'];
$limit = 15;
$sortOrder = 'desc';

$http =& eZHttpTool::instance();
$tpl =& templateInit();

/* if one or more orders should be activated */
if ( $http->hasPostVariable( 'ActivateButton' ) )
{
    if ( $http->hasPostVariable( 'ActivateIDArray' ) )
    {
        $activateIDArray =& $http->postVariable( 'ActivateIDArray' );
        if ( $activateIDArray !== null )
        {
                foreach($activateIDArray as $orderID)
                {
                    $order = eZOrder::fetch( $orderID );
                	$order->activate();
                }
        }
    }
}

/* if one or more orders should be reminded */
if ( $http->hasPostVariable( 'ReminderButton' ) )
{
	if ( $http->hasPostVariable( 'ActivateIDArray' ) )
    {
        $reminderIDArray =& $http->postVariable( 'ActivateIDArray' );
        if ( $reminderIDArray !== null )
        {
        		$sentArray = array();
        		$notSentArray = array();
                foreach($reminderIDArray as $orderID)
                {
                	if(tempOrder::sendReminder( $orderID ))
                	{
                		$sentArray[] = array('id' => $orderID);	
                	}
                	else
                	{
                		$notSentArray[] = array('id' => $orderID);	
                	}
                }
        }
    }
    
    // set send result in template
    $tpl->setVariable( 'sent_result', $sentArray );
    $tpl->setVariable( 'not_sent_result', $notSentArray );
}

/* if one or more orders should be deleted */
if ( $http->hasPostVariable( 'DeleteButton' ) )
{
	if ( $http->hasPostVariable( 'ActivateIDArray' ) )
    {
        $deleteIDArray =& $http->postVariable( 'ActivateIDArray' );
        if ( $deleteIDArray !== null )
        {
                foreach($deleteIDArray as $orderID)
                {
                    eZOrder::cleanupOrder( $orderID );
                }
        }
    }
}


$orderArray =& tempOrder::inActive( true, $offset, $limit, "created", $sortOrder);
$orderCount = tempOrder::inActiveCount( true, $offset );

$tpl->setVariable( 'order_list', $orderArray );
$tpl->setVariable( 'order_list_count', $orderCount );
$tpl->setVariable( 'limit', $limit );

$viewParameters = array( 'offset' => $offset );
$tpl->setVariable( 'view_parameters', $viewParameters );
$tpl->setVariable( 'sort_order', $sortOrder );

$Result['content'] =& $tpl->fetch( "design:temporders/list.tpl" );
$Result['path'] = array( array( 'text' => "List", 'url' => false ) );

?>
