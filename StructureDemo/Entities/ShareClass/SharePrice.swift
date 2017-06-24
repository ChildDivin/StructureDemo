//
//  SharePrice.swift
//  Booking_system
//
//  Created by Tops on 10/28/16.
//  Copyright © 2016 Tops. All rights reserved.
//

import UIKit

class SharePrice: NSObject {
    var MainPrice:CGFloat = 0.0
    var Discount:CGFloat = 0.0
    var Discount_second:CGFloat = 0.0
    var Gift_Discount:CGFloat = 0.0
    var Total:CGFloat {
        get{
            return MainPrice - (Discount + Gift_Discount + Discount_second)
        }
    }
    
    //private var TempBooking1:CGFloat = 0.0
    var Booking1 :CGFloat {
        get {
            return (MainPrice/2) - (Discount + Gift_Discount)
        }
    }
    //private var TempBooking2:CGFloat = 0.0
    var Booking2 :CGFloat {
        get {
            return (MainPrice / 2) - (Discount_second)
        }
    }
    
}
