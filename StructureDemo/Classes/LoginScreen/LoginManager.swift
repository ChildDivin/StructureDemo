//
//  LoginManager.swift
//  Club_Mobile
//
//  Created by Tops on 12/9/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class MyLoginManager: NSObject {
    
    func LoginCall(_ strEmail:String, strPass:String ,Complete:@escaping(AnyObject)->Void, failure:@escaping(_ is_email:Bool, _ is_Pass:Bool)->Void) -> Void  {
        let strEmail = strEmail.trimmingCharacters(in: .whitespaces)
        guard strEmail.characters.count > 0 else {
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "KeyVLEmail"))
            failure(false,false)
            return
        }
        guard StaticClass().isValidEmail(strEmail) else {
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "KeyVVLEmail"))
            failure(false,false)
            return
        }
        guard strPass.characters.count > 0 else {
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "keyVPassword"))
            failure(true,false)
            return
        }
        
        let paramer: NSMutableDictionary = NSMutableDictionary()
        paramer.setValue(strEmail, forKey: "username")
        paramer.setValue(strPass, forKey: "password")
        paramer.setValue("1", forKey: "device_type")
        paramer.setValue(StaticClass.sharedInstance.strDeviceToken, forKey: "device_token")
        paramer.setValue(String(describing: StaticClass.sharedInstance.latitude), forKey: "latitude")
        paramer.setValue(String(describing: StaticClass.sharedInstance.longitude), forKey: "longitude")
        print(paramer)
       
        APICall.shared.Post("user_login", parameters: paramer, showLoder: true) { (response) in
            Complete(response)
        }
        
    }
    
    func ForgotPassCall(_ strEmail:String ,Complete:@escaping(AnyObject)->Void, failure:@escaping(_ is_email:Bool)->Void) -> Void  {
        let strEmail = strEmail.trimmingCharacters(in: .whitespaces)
        guard strEmail.characters.count > 0 else {
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "KeyEmail"))
            failure(false)
            return
        }
        
        guard StaticClass().isValidEmail(strEmail) else {
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "KeyVVLEmail"))
            failure(false)
            return
        }

        let paramer: NSMutableDictionary = NSMutableDictionary()
        paramer.setValue(strEmail, forKey: "email_id")
        APICall.shared.Post("forget_password", parameters:paramer, showLoder: true, successBlock:{(response) in
            Complete(response)
        })
    }

    
}
