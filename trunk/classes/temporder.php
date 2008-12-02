<?php

include_once("kernel/classes/ezorder.php");
include_once( 'lib/ezutils/classes/ezmail.php' );
include_once( 'lib/ezutils/classes/ezmailtransport.php' );

class tempOrder extends eZOrder
{
	function tempOrder( $row )
    {
        $this->eZPersistentObject( $row );
    }
    
    /*!
     \return the active orders
    */
    function &inActive( $asObject = true, $offset, $limit, $sortField = "created", $sortOrder = "asc" )
    {
            return eZPersistentObject::fetchObjectList( eZOrder::definition(),
                                                        null, array( 'is_temporary' => 1 ),
                                                        array( $sortField => $sortOrder ),
                                                        array( 'offset' => $offset,
                                                               'length' => $limit ),
                                                        $asObject );
	}
	
/*!
     \return the number of active orders
    */
    function &inActiveCount()
    {
        $db =& eZDB::instance();

        $countArray = $db->arrayQuery(  "SELECT count( * ) AS count FROM ezorder WHERE is_temporary='1'" );
        return $countArray[0]['count'];
    }
    
    function sendReminder($orderID)
    {
    	// initiate objects
    	$mail 	= new eZMail();
    	
    	// fetch order
    	$order = eZOrder::fetch( $orderID );
    	
    	// fetch email recipient
    	$email = $order->accountEmail();
    	
    	// if an email address exists
    	if ($mail->validate( $email ) )
    	{
    		// initiate objects
    		$tpl 	= templateInit();
    		$ini 	= eZINI::instance();
            
    		// set order in template
            $tpl->setVariable( 'order', $order);
            $tpl->setVariable( 'product_items', $order->productItems());

            // set template file
            $templateResult = $tpl->fetch( 'design:temporders/reminderemail.tpl');

            // fetch data from template
            $subject 	= $tpl->variable( 'subject' );
            $sender 	= $tpl->variable( 'email_sender' );

            // set mail data
            $mail->setReceiver( $email );
            $mail->setSender( $sender );
            $mail->setReplyTo( $sender );
            $mail->setSubject( $subject );
            $mail->setBody( $templateResult );
            
            // send mail
            $mailResult = eZMailTransport::send( $mail );

            return true;
    	}
    	
    	// if no email address exists
    	else
    	{
    		return false;
    	}
    }
}


?>
