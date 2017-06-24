//
//  shareTransation.swift
//  Club_Mobile
//
//  Created by Tops on 12/22/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit
/*
 "Transactions": [
 {
 "TransactionId": "212ad427-7ce5-4dcd-81e4-7b3d59d19e44",
 "CardId": "217ecd8b-fc33-4cc5-a304-ae4ff93f628e",
 "Date": "2016-12-15T00:00:00",
 "Reference": "CREDIT1",
 "Description": "test credit",
 "Amount": 50,
 "Status": 1,
 "Credit": 1,
 "ErrorCode": null,
 "ErrorDescription": null
 },*/

class shareTransation: NSObject {
    var strId:String = ""
    var strDate:String = ""
    var strCardId:String = ""
    var strReference:String = ""
    var strDisc:String = ""
    var fltAmoount:Float = 0.0
    var fltPrebalance:Float = 0.0
    var fltbalance:Float = 0.0
    var fltcommision:Float = 0.0
    var strStatus:String = ""
    var strIsCredit:String = ""
    
    // FOR DATE SORTING 
    var date:Date {
        get {
            if let date = StaticClass().dateFormatterForYMD_T_HMSsss().date(from:strDate) as NSDate? {
                print(date)
                return date as Date
            }
            else if let date = StaticClass().dateFormatterForYMD_T_HMS().date(from:strDate) as NSDate? {
                print(date)
                return date as Date
            }
            else{
                return Date()
            }
        }
    }
    // FOR AGENT SIDE NEW
    var strUserId:String = ""
    var strAgentId:String = ""
    var strDateApproved:String = ""
    var strApprovedById:String = ""
    
}
