//
//  SharePaypal.swift
//  Booking_system
//
//  Created by Tops on 11/4/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit

class SharePaypal: NSObject {
    var strOrderid:String = ""
    var strPasref:String = ""
    var strCorrelationID:String = ""
    var strToken:String = ""
    var strBuild:String = ""
    var strVersion:String = ""
    var strPayerID:String = ""
    var strTimestamp:String = ""
    var strPrice:String = ""
}

/*{
    FLAG: true,
    MESSAGE: "successfully.",
    DATA: {
        orderid: "20161103141151-479",
        pasref: "1478182314026268",
        token_data: {
            Timestamp: "2016-11-03T14:11:55Z",
            Ack: "Success",
            CorrelationID: "8703d5e07b077",
            Token: "EC-94C26843R9996510V",
            Version: "98.0",
            Build: "26593028"
        }
    }
}
 */
