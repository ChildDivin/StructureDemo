//
//  Global.swift
//  Created by Ilesh on 12/7/16.
//  Copyright © 2016 Self. All rights reserved.
//

// lat :-  44.040219                     //23.0239806629938
// long :- -100.173340125                //72.5703668200795

import UIKit

class Global {
    
    static let g_Username = "admin"
    static let g_Password = "1234"
    static var Obj_Type = ""
    static var objectAddress = ""
    static var Booking_ID = ""
    static var sharedBikeData = ShareBikeKube()
    
    //API base Url
    
    static let g_APIBaseURL = "http://192.168.0.56/web_services/kuloni_kube/ws/"
    //static let g_APIBaseURL = ""
    
    
    // PAYPAL PAYMENT MODE // 0 = sandbox, 1 = Live
    static let g_paypal_live = "0"

    // GOOGLE MAPS API KYES
    static let g_GoogleApiKey = ""
    /**
     GOOGLE SAMPLE PLACES API: -https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=51.5074,0.1278&radius=2000&types=parking&sensor=true&key=AIzaSyBpMTpURbOvDeoNRnqTThXCeuCaXKMUP04
     */
    
    static let appdel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    struct Messages {
        static let serverError = "Oops, we can’t reach server.Please Check your connection and try again."
    }
    
    //Custom Font name
    struct CFName {
        static let Muli_Semibold = "Muli-SemiBold"
        //static let Muli_Black = "Lato-Black"
        //static let Lato_Medium = "Lato-Medium"
        //static let Lato_Thin = "Lato-Thin"
        static let Muli_Bold = "Muli-Bold"
        //static let Lato_Heavy = "Lato-Heavy"
        static let Muli_Regular = "Muli-Regular"
        //static let Lato_Light = "Lato-Light"
    }
    
    struct g_ColorString {
        static let GreenTxt = "#3BBEAE"
        static let GreyLightTxt = "#A8ABB2"
        static let RedLight = "#DB4437"
        static let Red = "#FF0303"
        static let Blue = "#4267B2"
        static let SkyBlue = "#1DA1F2"
        static let Black = "#333333"
        static let Unselected = "#E0E0E0"
    }
    
    struct BT_Card_Details {
        static var CardNo           = "KCCardNumber"
        static var Expiry           = "CMExpiry"
        static var Exipry_month     = "CMExpiry_Month"
        static var Exipry_year      = "CMUserGender"
        static var ID               = "CMID"
        static var Name             = "CMName"
        static var CardType         = "CMCardType"
        
    }
    
    struct g_UserData {
        
        static let ObjectPrice    = "KCObjectPrice"
        static let ObjectName     = "KCObjectName"
        static let BookingID      = "KCOBookingID"
        static let BookingIDsArr  = "KCOBookingIDCurrent"
        static let ObjectID       = "KCObjectID"
        static let ObjectIDsArr   = "KCObjectIDCurrent"
        static let UserID         = "KCUID"
        static let UserEMail      = "CMEmailAddress"
        static let UserName       = "CMUsername"
        static let UserGender     = "CMUserGender"
        static let UserMobile     = "CMUserMobile"
        static let USERID_FB      = "CMFBid"
        static let USERID_TW      = "CMTWid"
        static let USERID_GG      = "CMGGid"
        static let USERFIRSTNAME  = "CMFirstName"
        static let USERLASTNAME   = "CMSurname"
        static let USER_DOB       = "CMDOB"
        static let USERPROFILEIMAGEURL = "CMProfileImageUrl"
        static let USER_IsVarify  = "CMVerify"
        static let Customer_ID    = "CMCustomerID"
        static let CreateToken = "CMToken"
        
        static let USER_CARDNO = "CMuser_card_number"
        static let USER_CARDMONTH = "CMuser_card_month"
        static let USER_CARDYEAR = "CMuser_card_year"
        static let USER_CARDCVV = "CMuser_card_cvv"
        static let USER_CARDNAME = "CMuser_card_name"
        static let USER_CARDBANK = "CMuser_card_bank"
        static let USER_CARD_ID = "CMuser_card_id"
        static let USER_CARDTYPE = "CMuser_card_type"
    }
    
    struct g_UserDefaultKey {
        static let Token_login      = "CMToken_login"
        static let latitude         = "CMlatitude"
        static let longitude        = "CMlongitude"
        static let DeviceToken      = "CMDeviceToken"
        static let UniqueCode       = "CMUniqueCode"
        static let IS_USERLOGIN     = "CMUSER_LOGIN"
    }
    
    struct directoryPath {
        static let Documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        static let Tmp = NSTemporaryDirectory()
    }
    
    //Device Compatibility
    //MARK: DEVICE IDENTIFICATON CODE
    struct is_Device {
        static let _iPhone = (UIDevice.current.model as NSString).isEqual(to: "iPhone") ? true : false
        static let _iPad = (UIDevice.current.model as NSString).isEqual(to: "iPad") ? true : false
        static let _iPod = (UIDevice.current.model as NSString).isEqual(to: "iPod touch") ? true : false
    }
    //MARK: IOS IDENTIFICATION CODE
    struct is_Ios {
        static let _10 = ((UIDevice.current.systemVersion as NSString).floatValue >= 10.0) ? true : false
        static let _9 = ((UIDevice.current.systemVersion as NSString).floatValue >= 9.0) ? true : false
        static let _8 = ((UIDevice.current.systemVersion as NSString).floatValue >= 8.0 && (UIDevice.current.systemVersion as NSString).floatValue < 9.0) ? true : false
        static let _7 = ((UIDevice.current.systemVersion as NSString).floatValue >= 7.0 && (UIDevice.current.systemVersion as NSString).floatValue < 8.0) ? true : false
        static let _6 = ((UIDevice.current.systemVersion as NSString).floatValue <= 6.0 ) ? true : false
    }
    
    //MARK: IPHONE MODEL IDENTIFICATION CODE
    struct is_Iphone {
        static let _6p = (UIScreen.main.bounds.size.height >= 736.0 ) ? true : false
        static let _6 = (UIScreen.main.bounds.size.height <= 667.0 && UIScreen.main.bounds.size.height > 568.0) ? true : false
        static let _5 = (UIScreen.main.bounds.size.height <= 568.0 && UIScreen.main.bounds.size.height > 480.0) ? true : false
        static let _4 = (UIScreen.main.bounds.size.height <= 480.0) ? true : false
    }
    
    struct inApp {
        //7days
        static let inapp2  = "com.lystiosapp.swipes7"
        static let inapp3  = "com.lystiosapp.waitlist7"
        static let inapp4  = "com.lystiosapp.messageReminder7"
        static let inapp5  = "com.lystiosapp.SearchLocation7"
        static let inapp6  = "com.lystiosapp.Alltheabove7"
    }
    
    struct notification {
            static let DeviceBLE_StateChange            = "deviceBLEOffEvent"
            static let Push_forLocation                 = "pushnotificationUpdateValuesinLocation"
            static let Push_forBookingTrip              = "pushnotificationUpdateValuesinBookingTrip"
        
    }
    struct local {
        static let LocalDocument = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
}
