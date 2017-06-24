//
//  ShareDevice.swift
//  KoloniKube_Swift
//
//  Created by Tops on 4/6/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit

class ShareHomeParam {
    var strUser_id:String = ""
    var doubleLat: Double  = 0.0
    var doubleLong: Double  = 0.0
    var strIsNearest: String = "0"
    var strDistance_Unit: String = "0"
    var intMinVal:Int = 0
    var intMaxVal:Int = 0
    var intRating:Int = 0
    var strSelectedCategory = ""
    var strKeyword: String = ""
    var strtype :String = "0"
    var arrCategories = NSMutableArray()
}

class ShareDevice: NSObject {
    var totalCalulationPrice: String = ""
    var strPenaltyAmount:String = ""
    var strBookingID:String = ""
    var strObjectID:String = ""
    var strAddress:String = ""
    var strLocationName:String = ""
    var strId:String = ""
    var strReview:String = ""
    var strRating:Double = 0
    var strAvgRating:Double = 0
    var strKubes:String = ""
    var strBikes:String = ""
    var strKubeAvgPrice:Double = 0
    var strBikeAvgPrice:Double = 0
    var strLat:Double = 0
    var strLong:Double = 0
    var strAvailableBike:Int = 0
    var strAvailableKube:Int = 0
    var isFeedBackStatus: String = ""
    
    var arrKubes:NSMutableArray = NSMutableArray()
    var arrBikes:NSMutableArray = NSMutableArray()
    var arrAmenities:NSMutableArray = NSMutableArray()
    var arrImage:NSMutableArray = NSMutableArray()
    
}
class ShareDeviceImage: NSObject {

    var strImage:String = ""
}

class ShareAmenities: NSObject {
    var strId:String = ""
    var strName:String = ""
    var strImage:String = ""
}

class ShareBothBikeKube: NSObject {
    var strId:String = ""
    var strName:String = ""
    var strImg:String = ""
    var doublePrice :Double = 0.0
}
