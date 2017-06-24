//
//  ForgotVC.swift
//  Club_Mobile
//
//  Created by Tops on 12/8/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class ForgotVC: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var lblForgot: UILabel!
    var strUEmail = ""
    
    
    @IBOutlet weak var lblEmailLine: UILabel!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var btnBack : UIButton!
    
    let hexGreenColor = Global.g_ColorString.GreenTxt;
    let hexGrayColor = Global.g_ColorString.GreyLightTxt;
    
    
    
    //MARK: - VIEW CYCLE START
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmailLine.backgroundColor = UIColor(hexxString: hexGrayColor as String)
        txtEmail.placeHolderColor = UIColor.lightGray
        txtEmail.autocorrectionType = .no
        txtEmail.delegate = self;
        btnForgot.layer.cornerRadius = btnForgot.frame.size.height/2;
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLanguageText()
        //txtEmail.text = strUEmail
        setLanguageText()
        _ = txtEmail.text!.trimmingCharacters(in: .whitespaces) as String
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnForgot.layer.cornerRadius = btnForgot.frame.size.height/2;
    }
    
    //MARK: - CUSTOM METHODS
    func setLanguageText() -> Void {
        txtEmail.placeholder = LocalizeHelper().localizedString(forKey: "KeyEmailAddress")
        btnForgot.setTitle(LocalizeHelper().localizedString(forKey: "KeyFbtnForgot"), for: .normal)
        btnBack.setTitle(LocalizeHelper().localizedString(forKey: "KeybtnBack"), for: .normal)
        lblForgot.text = LocalizeHelper().localizedString(forKey: "KeylblForgot")
        let trimmedString = txtEmail.text!.trimmingCharacters(in: .whitespaces) as String
        
        if txtEmail.text != "" {
            EmailText(strEmail: trimmedString);
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.tintColor = UIColor(hexxString: Global.g_ColorString.GreenTxt)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == txtEmail){
            let trimmedString = txtEmail.text!.trimmingCharacters(in: .whitespaces) as String
            EmailText(strEmail: trimmedString);
        }
    }
    
    func EmailText(strEmail:String) -> Void {
        if (strEmail.characters.count) > 0 {
            txtEmail.textColor = UIColor(hexxString: Global.g_ColorString.GreenTxt)
            lblEmailLine.backgroundColor = UIColor(hexxString: Global.g_ColorString.GreenTxt)
            imgEmail.image = UIImage(named: "email_green")
        }else{
            txtEmail.textColor = UIColor(hexxString:Global.g_ColorString.GreyLightTxt)
            lblEmailLine.backgroundColor = UIColor(hexxString:Global.g_ColorString.GreyLightTxt)
            imgEmail.image = UIImage(named: "email")
        }
    }
    
    //MARK: - BUTTON ACTION METHODS
    
    @IBAction func btnForgotPressed(_ sender: Any) {
        self.view.endEditing(true)
        MyLoginManager().ForgotPassCall(txtEmail.text!, Complete:{(response) in
            print(response)
            if let Dict = response as? NSDictionary {
                if Dict.object(forKey: "FLAG") as! Bool {
                    StaticClass().ShowNotification(true, strmsg: Dict.object(forKey: "MESSAGE") as! String)
                    _ = self.navigationController?.popViewController(animated: true)
                }
                else{
                    StaticClass().ShowNotification(false, strmsg: Dict.object(forKey: "MESSAGE") as! String)
                }
            }
        } , failure: {
            (is_email:Bool) in
        })
    }
    
    
    @IBAction func btnBackPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
}
