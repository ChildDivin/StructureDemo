//
//  APICall.swift
//  Club Mobile Application
//
//  Created by Tops on 12/7/16.
//  Copyright © 2016 Self. All rights reserved.
//

import Foundation
import AFNetworking
import ISMessages
import NVActivityIndicatorView

class APICall {
    var manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
    var spinnerView: UIView?
    static let shared: APICall = {
        let instance = APICall()
        return instance
    }()
    
    //Mark: View Loader
    func addShowLoaderInView (viewObj: UIView, boolShow: Bool) -> UIView {
        
        spinnerView = UIView()
        
        spinnerView?.frame = CGRect(x: (UIScreen.main.bounds.width - 54), y: (UIScreen.main.bounds.height - 54), width: 100, height: 100)
        spinnerView?.center = viewObj.convert(viewObj.center, from: viewObj)
        spinnerView?.backgroundColor = UIColor(white: 0.0, alpha: 0.6)
        spinnerView?.layer.cornerRadius = 5.0
        viewObj.addSubview(spinnerView!)
        
        let spin = NVActivityIndicatorView(frame: CGRect(x:10, y: 10, width: 60, height: 60), type: .ballClipRotatePulse , color: .white, padding: 0)
        spinnerView?.addSubview(spin)
        spin.startAnimating()
        
        return spinnerView!
    }
    
    func HideSpinnerOnView(_ view:UIView) -> Void {
        view.removeFromSuperview()
    }
    
    //MARK: BASIC FIX URL
    func GetWithFixUrl(_ withUrl:String, withLoader showLoder:Bool, successBlock:@escaping (_ responce:AnyObject) -> Void) {
        if(showLoder){
            StaticClass().ShowSpiner()
        }
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        manager.get(withUrl, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if let jsonResponse = responseObject as? NSDictionary {
                if(showLoder){
                    StaticClass().HideSpinner()
                }
                successBlock(jsonResponse)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            if(showLoder){
                StaticClass().HideSpinner()
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
        }
    }
    
    //MARK: BASIC + GET + LOADER
    func Get(_ withUrl:String, withLoader showLoder:Bool, successBlock:@escaping (_ responce:AnyObject) -> Void) {
        if(showLoder){
            StaticClass().ShowSpiner()
        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        manager.responseSerializer.acceptableStatusCodes = NSIndexSet(indexSet:[500,200]) as IndexSet
        
        print("URL: \(urlPath1)")
        
        
        manager.get(urlPath1, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if(showLoder){
                StaticClass().HideSpinner()
            }
            if let jsonResponse = responseObject as? NSDictionary {
                successBlock(jsonResponse)
            }
            else {
                successBlock(responseObject as AnyObject)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            if(showLoder){
                StaticClass().HideSpinner()
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
        }
    }
    
    func GetLogin(_ withUrl:String, withLoader showLoder:Bool, successBlock:@escaping (_ responce:AnyObject) -> Void) {
        if(showLoder){
            StaticClass().ShowSpiner()
        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        print("URL: \(urlPath1)")
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        manager.get(urlPath1, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            
            if let string = String(data: responseObject as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                print(string)
                if(showLoder){
                    //StaticClass().HideSpinner()
                }
                successBlock(string as AnyObject)
            }
            else if let jsonResponse = responseObject as? NSDictionary {
                if(showLoder){
                    StaticClass().HideSpinner()
                }
                successBlock(jsonResponse) //
                if let error =  jsonResponse.object(forKey: "Message") as? String {
                    StaticClass().ShowNotification(false, strmsg:error)
                }
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            StaticClass().HideSpinner()
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
        }
    }
    
    func GetEncript(_ withUrl:String, withLoader showLoder:Bool, successBlock:@escaping (_ responce:AnyObject) -> Void) {
        if(showLoder){
            StaticClass().ShowSpiner()
        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        print("URL: \(urlPath1)")
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        manager.get(urlPath1, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if let string = String(data: responseObject as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                print(string)
                if(showLoder){
                    //StaticClass().HideSpinner()
                }
                successBlock(string as AnyObject)
            }
            else if let jsonResponse = responseObject as? NSDictionary {
                if(showLoder){
                    StaticClass().HideSpinner()
                }
                successBlock(jsonResponse) //
                if let error =  jsonResponse.object(forKey: "Message") as? String {
                    StaticClass().ShowNotification(false, strmsg:error)
                }
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            StaticClass().HideSpinner()
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
        }
    }
    
    func Post(_ withUrl:String, parameters:NSMutableDictionary, showLoder:Bool, successBlock:@escaping (_ responce : AnyObject) -> Void) {
        if(showLoder){
            StaticClass().ShowSpiner()
        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        print("URL \(urlPath1) \n Para:\(parameters)")
        manager.post(urlPath1, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if let jsonResponse = responseObject as? NSDictionary {
                if(showLoder){
                    StaticClass().HideSpinner()
                }
                successBlock(jsonResponse)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error.localizedDescription)")
            print("code :-\(error.localizedDescription)")
            
            if ((task) != nil) {
                
            }
            if(showLoder){
                StaticClass().HideSpinner()
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
            
        }
    }
    
    
    
    func callApiForMultipleImageUpload (_ urlPath: NSString, withParameter dictData: NSMutableDictionary, withImage arrimage: NSMutableArray,withLoader showLoader: Bool, successBlock success:@escaping (_ responceData:AnyObject)->Void, failureBlock Failure:@escaping (_ Error: NSError?)->Void) {
        
        if(showLoader){
            StaticClass().ShowSpiner()
        }
        
        let urlPath1 = Global.g_APIBaseURL + (urlPath as String)
        print(urlPath1)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
         manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        
        var randomNumber :String {
            var number = ""
            for i in 0..<4 {
                var randomNumber = arc4random_uniform(10)
                while randomNumber == 0 && i == 0 {
                    randomNumber = arc4random_uniform(10)
                }
                number += "\(randomNumber)"
            }
            return String(number)
        }
        var randomNumber2 :String {
            var number = ""
            for i in 0..<8 {
                var randomNumber = arc4random_uniform(10)
                while randomNumber == 0 && i == 0 {
                    randomNumber = arc4random_uniform(10)
                }
                number += "\(randomNumber)"
            }
            return String(number)
        }
        
        print(dictData)
        _ = manager.post(urlPath1, parameters: dictData, constructingBodyWith: { (Data) in
        
            for imag in arrimage {
                let imageTemp = imag as! UIImage
                if imageTemp != UIImage(named: "imgPlaceHolderIcon"){
                    let dataParse = UIImagePNGRepresentation(imageTemp)
                    Data.appendPart(withFileData: dataParse!, name:"image[]", fileName: "\(randomNumber2).png", mimeType: "image/png")
                }
            }
            
        }, progress: { (Finished) in
            
        }, success: { (task:URLSessionDataTask, response:Any?) in
            if(showLoader){
                StaticClass().HideSpinner()
            }
            success(response as AnyObject)
            
        }) { (task:URLSessionDataTask?, error:Error) in
            
            if(showLoader) {
                StaticClass().HideSpinner()
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
                print(error.localizedDescription)
                
            }
            Failure(error as NSError?)
        }
    }

    
    
    func callApiUsingPOST_Image (_ urlPath: NSString, withParameter dictData: NSMutableDictionary, withImage image: UIImage, WithImageName imageName: NSString, withLoader showLoader: Bool, successBlock success:@escaping (_ responceData:AnyObject)->Void, failureBlock Failure:@escaping (_ Error: NSError?)->Void) {
        
        if(showLoader){
            StaticClass().ShowSpiner()
        }
        
        let urlPath1 = Global.g_APIBaseURL + (urlPath as String)
        print(urlPath1)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        // manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
         manager.requestSerializer.setAuthorizationHeaderFieldWithUsername(Global.g_Username, password: Global.g_Password)
        var Timestamp: String {
            return "\(Date().timeIntervalSince1970 * 1000)"
        }
        
        _ = manager.post(urlPath1, parameters: dictData, constructingBodyWith: { (Data) in
            
            let strFlag = dictData.object(forKey: "is_delete_photo") as? String ?? ""
            if strFlag == "0"{
                let image1: UIImage? = image
                if image1 != nil{
                    Data.appendPart(withFileData: UIImagePNGRepresentation(image1!)!, name: imageName as String, fileName: "\(Timestamp).png", mimeType: "image/png")
                }
            }
            
        }, progress: { (Finished) in
            
        }, success: { (task:URLSessionDataTask, response:Any?) in
            if(showLoader){
                StaticClass().HideSpinner()
            }
            success(response as AnyObject)
            
        }) { (task:URLSessionDataTask?, error:Error) in
            
            if(showLoader) {
                StaticClass().HideSpinner()
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
            Failure(error as NSError?)
        }
    }
    
    
    
    //MARK: ADD LOADER WITH VIEW
    func GetWithView(_ withUrl:String, withLoader showLoder:Bool, view:UIView, successBlock:@escaping (_ responce:AnyObject) -> Void) {
        var  viewLoad:UIView?
        if showLoder {
            if let viewWithTag = view.viewWithTag(200) {
                print("Tag 200")
                viewWithTag.removeFromSuperview()
            }
             viewLoad = addShowLoaderInView(viewObj: view, boolShow: showLoder)
             viewLoad?.tag = 200
        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer()
        //[operation addAcceptableStatusCodes:[NSIndexSet indexSetWithIndex:404]];
        manager.responseSerializer.acceptableStatusCodes = NSIndexSet(indexSet:[500,404,200]) as IndexSet
        print("URL: \(urlPath1)")
        manager.get(urlPath1, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if(showLoder){
                self.HideSpinnerOnView(viewLoad!)
            }
            if let jsonResponse = responseObject as? NSDictionary {
                successBlock(jsonResponse)
            }
            else {
                successBlock(responseObject as AnyObject)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            if(showLoder){
                self.HideSpinnerOnView(viewLoad!)
            }
            StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
        }
    }
    func PostWithView(_ withUrl:String,parameters:NSMutableDictionary, withLoader showLoder:Bool, view:UIView, successBlock: @escaping (_ responce:AnyObject) -> Void){
        if showLoder {
            //viewLoad = addShowLoaderInView(viewObj: view, boolShow: showLoder)
            StaticClass().ShowSpiner()
        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer.acceptableStatusCodes = NSIndexSet(indexSet:[404,200]) as IndexSet
        
        print("POST URL: \(urlPath1)")

        manager.post(urlPath1, parameters: parameters, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if(showLoder){
                //StaticClass().HideSpinnerOnView(viewLoad!)
                StaticClass().HideSpinner()
            }
            if let jsonResponse = responseObject as? NSDictionary {
                successBlock(jsonResponse)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            if(showLoder){
                StaticClass().HideSpinner()
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
        }
    }
    
    func GetWithViewFail(_ withUrl:String, withLoader showLoder:Bool, view:UIView, successBlock:@escaping (_ responce:AnyObject) -> Void,failureBlock Failure:@escaping (_ Error: Error?)-> Void) {
    
        var viewLoad: UIView?
        if showLoder {
            if let viewWithTag = view.viewWithTag(200) {
                print("Tag 200")
                viewWithTag.removeFromSuperview()
            }
            viewLoad = addShowLoaderInView(viewObj: view, boolShow: showLoder)
            viewLoad?.tag = 200

        }
        let urlPath1 = Global.g_APIBaseURL + (withUrl as String)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer()
        print("URL: \(urlPath1)")
        manager.get(urlPath1, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if(showLoder){
                self.HideSpinnerOnView(viewLoad!)
            }
            if let jsonResponse = responseObject as? NSDictionary {
                successBlock(jsonResponse)
            }
            else {
                successBlock(responseObject as AnyObject)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            if(showLoder){
                self.HideSpinnerOnView(viewLoad!)
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
            Failure(error as Error?)
        }
    }
    
    func GetWithViewFailFixUrl(_ withUrl:String, withLoader showLoder:Bool, view:UIView, successBlock:@escaping (_ responce:AnyObject) -> Void,failureBlock Failure:@escaping (_ Error: Error?)-> Void) {
        var viewLoad: UIView?
        if showLoder {
            if let viewWithTag = view.viewWithTag(200) {
                print("Tag 200")
                viewWithTag.removeFromSuperview()
            }
            viewLoad = addShowLoaderInView(viewObj: view, boolShow: showLoder)
            viewLoad?.tag = 200

        }
        let urlPath1 = (withUrl as String)
        let manager = AFHTTPSessionManager(sessionConfiguration: URLSessionConfiguration.default)
        manager.requestSerializer = AFJSONRequestSerializer()
        print("URL: \(urlPath1)")
        manager.get(urlPath1, parameters: nil, progress: nil, success: { (task: URLSessionDataTask, responseObject: Any?) in
            if(showLoder){
                self.HideSpinnerOnView(viewLoad!)
            }
            if let jsonResponse = responseObject as? NSDictionary {
                successBlock(jsonResponse)
            }
            else {
                successBlock(responseObject as AnyObject)
            }
        }) { (task: URLSessionDataTask?, error: Error) in
            print("ERROR ON WS CALL:-\(error)")
            if(showLoder){
                self.HideSpinnerOnView(viewLoad!)
                StaticClass().ShowNotification(false, strmsg:LocalizeHelper().localizedString(forKey: "ERROR_CALL") )
            }
            Failure(error as Error?)
        }
    }
}
