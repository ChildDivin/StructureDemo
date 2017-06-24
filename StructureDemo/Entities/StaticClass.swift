//
//  StaticClass.swift
//  SwiftDemo
//
//  Created by Ilesh_Panchal on 02/03/2015.
//  Copyright (c) 2015 Ilesh_Panchal. All rights reserved.


import UIKit
import ISMessages
import NVActivityIndicatorView

class StaticClass {
    
    var spinnerView:UIView?
    var arrGender : NSMutableArray = NSMutableArray()
    var arrAmenities : NSMutableArray = NSMutableArray()
    var arrRunningBookingId = NSMutableArray()
    var arrRunningObjectId = NSMutableArray()
    
    var shareDevice = ShareDevice()
    
    //MARK: - Variable values set
    var latitude :CGFloat  {
        get{
            return CGFloat(retriveFromUserDefaults(Global.g_UserDefaultKey.latitude) as? NSNumber ?? 0)
        }
    }
    var longitude :CGFloat {
        get{
            return CGFloat(retriveFromUserDefaults(Global.g_UserDefaultKey.longitude) as? NSNumber ?? 0)
        }
    }
    
    var strUserId : String {
        get {
            return String(describing: retriveFromUserDefaults(Global.g_UserData.UserID) as! String)
        }
    }
    var strDeviceToken : String {
        get {
            return retriveFromUserDefaults(Global.g_UserDefaultKey.DeviceToken) as? String ?? ""
        }
    }
    
    var strUniqueCode : String {
        get {
            return retriveFromUserDefaults(Global.g_UserDefaultKey.UniqueCode) as? String ?? ""
        }
    }
    
    
    static let sharedInstance: StaticClass = {
        let instance = StaticClass()
        return instance
    }()
    
    
    //MARK: - NOTIFICATION MESSAGE
    func ShowNotification(_ success:Bool,strmsg:String) -> Void {
        if success {
            ISMessages.showCardAlert(withTitle: "Success", message: strmsg, duration: 3.0, hideOnSwipe: true, hideOnTap: true, alertType: .success, alertPosition: .top, didHide: nil)
        }else{
            ISMessages.showCardAlert(withTitle: "Error", message: strmsg, duration: 3.0, hideOnSwipe: true, hideOnTap: true, alertType:.error, alertPosition: .top, didHide: nil)
        }
        
    }
    
    func PriceFormater(price:Double) -> String {
        return String(format: "$%.2f",price)
    }
    
    //MARK: - SPINNER METHODS
    func ShowSpiner() -> Void {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size: CGSize(width: 60, height: 60), message: "", messageFont: UIFont.systemFont(ofSize: 10), type: .ballClipRotatePulse , color: .white, padding: 0, displayTimeThreshold:0, minimumDisplayTime: 0))
    }
    func HideSpinner() -> Void {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    /**
     Call like:
     ### StaticClass.sharedInstance.ShowSpinnerWithView(tblAgent)
     */
    func ShowSpinnerWithView(_ onView:UIView) -> Void {
        //child.center = [parent convertPoint:parent.center fromView:parent.superview];
        onView.isUserInteractionEnabled = false
        if spinnerView == nil {
            spinnerView = UIView()
            spinnerView!.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            spinnerView!.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
            spinnerView!.layer.cornerRadius = 3.0
        }
        onView.addSubview(spinnerView!)
        spinnerView!.center = onView.convert(onView.center, from: onView)
        let spin = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80), type: .orbit , color: .white, padding: 0)
        spinnerView?.addSubview(spin)
        spin.startAnimating()
    }
    
    /**
     Call like:
     ### taticClass.sharedInstance.HideSpinnerOnView(tblAgent)
     */
    func HideSpinnerOnView(_ view:UIView) -> Void {
        view.isUserInteractionEnabled = true
        spinnerView?.removeFromSuperview()
        spinnerView = nil
        
    }
    
    // MARK: - Save to NSUserdefault
    func saveToUserDefaults (_ value: AnyObject?, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
        defaults.synchronize()
    }
    
    func saveBoolToUserDefaults (_ value: Bool, forKey key: String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
        defaults.synchronize()
    }
    
    func retriveFromUserDefaults (_ key: String) -> AnyObject? {
        let defaults = UserDefaults.standard
        if(defaults.value(forKey: key as String) != nil){
            print(defaults.value(forKey: key as String) ?? "")
            return defaults.value(forKey: key as String) as AnyObject?
        }
        return "" as AnyObject?
    }
    
    // MARK: - Validation
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format:"SELF MATCHES [c]%@",emailRegex)
        return (emailText.evaluate(with: email))
    }
    func validatePhoneNumber(_ value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidatePhoneNumber(_ candidate: String) -> Bool {
        if candidate.characters.count <= 14 && candidate.characters.count > 6
        {
            let phoneRegex: String = "[0-9]{8}([0-9]{1,3})?"
            let test: NSPredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return test.evaluate(with: candidate)
        }
        else{
            return false
        }
    }
    
    func isUsernameValid_aA9(_ strUser:String,WithAccept Charecter:String) -> Bool{
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789\(Charecter)")
        if strUser.rangeOfCharacter(from: characterset.inverted) != nil {
            print("string contains special characters")
            return false
        }else{
            return true
        }
    }
    
    //MARK: LOGS ALL FONTS INSTALLS
    func fontDisplayAllFonts() -> Void {
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    /*func removeTimeFromDate (date: NSDate) -> NSDate {
     let calendarObj: NSCalendar = NSCalendar.autoupdatingCurrentCalendar()
     
     let dateComponentsObj = calendarObj.components([.NSDayCalendarUnit, .NSMonthCalendarUnit, .NSYearCalendarUnit] , fromDate: date)
     dateComponentsObj.hour = 00
     dateComponentsObj.minute = 00
     dateComponentsObj.second = 00
     
     return calendarObj.dateFromComponents(dateComponentsObj)! as NSDate
     }
     
     func getMonthFromDate (date: NSDate) -> Int {
     let components = NSCalendar.currentCalendar().components([.Hour, .Minute, .Month, .Year, .Day], fromDate: date)
     return components.month as Int
     }
     
     func getYearFromDate (date: NSDate) -> NSInteger {
     let components = NSCalendar.currentCalendar().components([.Hour, .Minute, .Month, .Year, .Day], fromDate: date)
     return components.year as NSInteger
     }
     */
    // MARK: - General Methods
    
    func removeNull (_ str:String) -> String {
        if (str == "<null>" || str == "(null)" || str == "N/A" || str == "n/a" || str.isEmpty || str == "null" || str == "NSNull") {
            return ""
        } else {
            return str
        }
    }
    
    func getDouble(value:Any) -> Double {
        if let double_V = value as? Double {
            return double_V
        } else if let Int_V = value as? Int {
            return Double(Int_V)
        }else if let String_V = value as? String {
            return String_V.toDouble()
        }
        else{
            return 0.0
        }
    }
    
    func getInterGer(value:Any) -> Int {
        if let double_V = value as? Double {
            return Int(double_V)
        } else if let Int_V = value as? Int {
            return Int_V
        }else if let String_V = value as? String {
            return Int(String_V.toDouble())
        }
        else{
            return 0
        }
    }
    
    func setPrefixHttp (_ str:NSString) -> NSString {
        if (str == "" || str .hasPrefix("http://") || str .hasPrefix("https://")) {
            return str
        } else {
            return "http://".appendingFormat(str as String) as NSString
        }
    }
    
    func isconnectedToNetwork() -> Bool {
        /* let reachability = Reachability.reachabilityForInternetConnection()
         
         if !reachability.isReachable() {
         AlertView().showAlertWithOKButton(self.setLocalizeText("keyInternetConnectionError"), withType: AJNotificationTypeRed)
         }
         return reachability.isReachable()*/
        
        return true
    }
    //MARK: TIME FORMAT
    func TimeFormatter_12H() -> DateFormatter {
        //06:35 PM
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter
    }
    
    func TimeFormatter_24_H() -> DateFormatter {
        //19:29:50
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }
    //MARK: DATE FORMAT
    func dateFormatterFullWiteTimeZone() -> DateFormatter {
        //2016-10-24 19:29:50 +0000
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        return dateFormatter
    }
    func dateFormatterFull() -> DateFormatter {
        //2016-10-24 19:29:50 +0000
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
    
    func dateFormatterFull_DMY_HMS() -> DateFormatter {
        //24-10-2016 19:29:50
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter
    }
    
    func dateFormatterDD_MM_YYYY() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
    
    func dateFormatter() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }
    
    func dateFormatterForDisplay() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter
    }
    func dateFormatterForDisplay_DMMMY() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter
    }
    func dateFormatterForCall() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    func dateFormatterForCallBirthDay() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    func dateFormatterForYearOnly() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }
    func dateFormatterForMonthINNumberOnly() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter
    }
    func dateFormatterForDaysMonthsYears() -> DateFormatter {
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE, d LLL yyyy"
        return dateFormatter
    }
    func dateFormatterForYMD_T_HMSsss() -> DateFormatter {
        //yyyy-MM-dd'T'HH:mm:ss.SSS
        //"Date": "2016-12-15T00:00:00",
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter
    }
    func dateFormatterForYMD_T_HMS() -> DateFormatter {
        //yyyy-MM-dd'T'HH:mm:ss
        //"Date": "2016-12-15T00:00:00",
        var dateFormatter: DateFormatter
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }
    
    //MARK: COLOR FORMATE
    func getUIColorFromRBG (R rVal: CGFloat, G gVal: CGFloat, B bVal: CGFloat) -> UIColor {
        return UIColor(red: rVal/255.0, green: gVal/255.0, blue: bVal/255.0, alpha: 1.0)
    }
    
    func getUIColorFromRBGAlpha (R rVal: CGFloat, G gVal: CGFloat, B bVal: CGFloat, Alpha alpha: CGFloat) -> UIColor {
        return UIColor(red: rVal/255.0, green: gVal/255.0, blue: bVal/255.0, alpha: alpha)
    }
    
    //MARK: DATE AND TIME
    
    func secondsToHoursMinutesSeconds (_ seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    //MARK: CHECK APP INSTALATION NUMBERS
    
    func isAppLaunchedFirst()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnceMode"){
            print("App already launched ")
            return false
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnceMode")
            print("App launched first time")
            return true
        }
    }
    
    func checkAppIsLaunchInDay()-> Bool{
        let strToday = self.dateFormatterForCall().string(from: Date() as Date)
        let strDate = self.retriveFromUserDefaults("ISAPPLAUNCH_TODAYFIRST") as? String
        //print(strDate); print(strToday)
        if (strDate != nil) {
            if strDate == strToday{
                return false
            } else {
                StaticClass().saveToUserDefaults(strToday as AnyObject? , forKey: "ISAPPLAUNCH_TODAYFIRST")
                return true
            }
        }else{
            StaticClass().saveToUserDefaults(strToday as AnyObject? , forKey: "ISAPPLAUNCH_TODAYFIRST")
            return true
        }
    }
    
    
    //MARK: STRING METHODS FOR CREDIT CARD
    /**
     See sample usage:
     ### let str = "41111111111111111"
     
     let x = yourClassname.setStringAsCardNumberWithSartNumber(4, withString: str!, withStrLenght: 8)
     
     ### output:- 4111XXXXXXXX1111
     
     let x = yourClassname.setStringAsCardNumberWithSartNumber(0, withString: str!, withStrLenght: 12)
     
     ### output: - XXXXXXXXXXXX1111
     
     */
    func setStringAsCardNumberWithSartNumber(_ Number:Int,withString str:String ,withStrLenght len:Int ) -> String{
        //let aString: String = "41111111111111111"
        let arr = str.characters
        var CrediteCard : String = ""
        if arr.count > (Number + len) {
            for (index, element ) in arr.enumerated(){
                if index >= Number && index < (Number + len) {
                    CrediteCard = CrediteCard + String("X")
                }else{
                    CrediteCard = CrediteCard + String(element)
                }
            }
            return CrediteCard
        }else{
            print("\(Number) plus \(len) are grether than strings chatarter \(arr.count)")
        }
        print("\(CrediteCard)")
        return str
    }
}


