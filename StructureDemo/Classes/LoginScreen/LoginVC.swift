//
//  LoginVC.swift
//  Club_Mobile
//
//  Created by Tops on 12/8/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit
import SystemConfiguration

class LoginVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPass: UIImageView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPasword: UIView!
    
    
    
    //MARK: VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.placeHolderColor = UIColor.white
        txtPass.placeHolderColor = UIColor.white
        txtEmail.autocorrectionType = .no
        txtPass.autocorrectionType = .no
        txtEmail.delegate = self
        txtPass.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLayout()
        setLanguageText()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnLogin.layer.cornerRadius = btnLogin.frame.size.height/2;
    }
    //MARK: -TEXT FIELD DELEGATE
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //textField.appearance().tintColor = UIColor.black
        textField.tintColor = UIColor(hexxString: Global.g_ColorString.GreenTxt)
        return true
    }
    
    @IBAction func btnRegistrationPressed(_ sender: Any) {
        //let registerCont = RegistrationVC(nibName: "RegistrationVC", bundle: nil)
        //self.navigationController?.pushViewController(registerCont, animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        if (textField == txtEmail){
//            let trimmedString = txtEmail.text!.trimmingCharacters(in: .whitespaces) as String
//            
//        }else if (textField == txtPass){
//            let trimmedString = txtPass.text!.trimmingCharacters(in: .whitespaces) as String
//            
//        }
    }
    
    
    //MARK: - CUSTOM METHODS
    
    func setLayout() -> Void {
       
        viewEmail.layer.borderColor = UIColor.white.cgColor
        viewPasword.layer.borderColor = UIColor.white.cgColor
        
        viewEmail.layer.borderWidth = 1.0
        viewPasword.layer.borderWidth = 1.0

        viewEmail.layer.cornerRadius = 24.0
        viewPasword.layer.cornerRadius = 24.0
    
    }
    
    func setLanguageText() -> Void {
        txtEmail.placeholder = LocalizeHelper().localizedString(forKey: "KeyUserName")
        txtPass.placeholder = LocalizeHelper().localizedString(forKey: "KeyVPass")
        btnLogin.setTitle(LocalizeHelper().localizedString(forKey: "KeyVbtnLogin"), for: .normal)
        btnForgot.setTitle(LocalizeHelper().localizedString(forKey: "KeyVbtnForgot"), for: .normal)
        btnSignUp.setTitle(LocalizeHelper().localizedString(forKey: "KeyVbtnCreate"), for: .normal)
    }
    

    //MARK: - BUTTON ACTION METHODS
    @IBAction func btnLoginClick(_ sender: Any) {
        self.view.endEditing(true)
        MyLoginManager().LoginCall(txtEmail.text!, strPass: txtPass.text!, Complete: {
            (response) in
            print(response)
            let dict = response as! NSDictionary
            if (dict["FLAG"] as! Bool){
                if let arrResult = dict["LOGIN_DETAILS"] as? NSArray{
                    if let dicResult = arrResult[0] as? NSDictionary {
                        StaticClass().saveToUserDefaults((true) as AnyObject, forKey: Global.g_UserDefaultKey.IS_USERLOGIN)
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"id") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.UserID)
                        
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"first_name") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.USERFIRSTNAME)
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"last_name") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.USERLASTNAME)
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"email_id") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.UserEMail)
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"date_of_birth") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.USER_DOB)
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"profile_image") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.USERPROFILEIMAGEURL)
                        StaticClass().saveToUserDefaults((dicResult.object(forKey:"is_verify") as? String  ?? "") as AnyObject, forKey: Global.g_UserData.USER_IsVarify)
                        
                        Global.appdel.ConfigureTabbarAgent(animated: true)
                        
                    }
                }
                
            }else{
                StaticClass().ShowNotification(false, strmsg: dict["MESSAGE"] as? String ?? "")
            }
            
        }, failure: {
            (is_email:Bool,is_pass:Bool) in
            let dashBoard = DashboradVC(nibName: "DashboradVC", bundle: nil)
            self.navigationController?.pushViewController(dashBoard, animated: true)
        })
    }
    
    @IBAction func btnForgotClick(_ sender: Any) {
        self.view.endEditing(true)
        let forgot = ForgotVC(nibName: "ForgotVC", bundle: nil)
        forgot.strUEmail = txtEmail.text!
        self.navigationController?.pushViewController(forgot, animated: true)
    }

    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}
