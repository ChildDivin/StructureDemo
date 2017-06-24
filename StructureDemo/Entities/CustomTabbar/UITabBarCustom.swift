//
//  UITabBarCustom.swift
//  Club_Mobile
//
//  Created by Tops on 12/10/16.
//  Copyright © 2016 Self. All rights reserved.
//

import UIKit

class UITabBarCustom: UITabBarController ,UITabBarControllerDelegate {
    
    var btnTab1: UIButton!
    var btnTab2: UIButton!
    var btnTab3: UIButton!
    var btnTab4: UIButton!
    var btnTab5: UIButton!
    var imgTabBg: UIImageView!
    var bottom_view: UIView!
    var y_position : Float = 0.0
    var btn_x_position : Float = 0.0
    var btn_y_position : Float = 0.0
    var btn_width : Float = 0.0
    var btn_height : Float = 0.0
    var HeightTabbar : Float = 0.0
    var noOfTab : Float = 0.0
    var viewMenu: MenuView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HeightTabbar = 46.0
        noOfTab = 4.0
        
        let arrNib = Bundle.main.loadNibNamed("MenuView", owner: self, options: nil)
        viewMenu = arrNib![0] as? MenuView
        //let  appDelegate = (UIApplication.shared.delegate! as! AppDelegate)
        self.view.addSubview(viewMenu)
        
        viewMenu.btnHelp.addTarget(self, action: #selector(btnHelpClick), for: .touchUpInside)
        self.addCustomElements()
        viewMenu.btnRateUs.addTarget(self, action: #selector(btnRateUSClick), for: .touchUpInside)
        viewMenu.btnLogout.addTarget(self, action: #selector(btnLogoutClick), for: .touchUpInside)
        viewMenu.btnReport.addTarget(self, action: #selector(btnReportClick), for: .touchUpInside)
        viewMenu.btnSetting.addTarget(self, action: #selector(btnSettingClick), for: .touchUpInside)
        self.addCustomElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideOriginalTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewMenu.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 41)
        
        //setupButton(button: viewMenu.btnLogout)
        
    }
    // MARK: - Hide Original TabBar - Add Custom TabBar
    func hideOriginalTabBar() {
        //let arr = self.view.subviews
        for view: UIView in self.view.subviews {
            if (view is UITabBar) {
                view.isHidden = true
                view.isUserInteractionEnabled = false
            }
        }
    }
    
    func addCustomElements() {
        if imgTabBg != nil {
            imgTabBg.removeFromSuperview()
        }
        let y: Float = Float(UIScreen.main.bounds.size.height) - HeightTabbar
        let w: Float = Float(UIScreen.main.bounds.size.width)
        bottom_view = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(y), width: CGFloat(w), height: CGFloat(HeightTabbar)))
        
        imgTabBg = UIImageView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(w), height: CGFloat(HeightTabbar)))
        imgTabBg.backgroundColor = UIColor.clear
        //imgTabBg.useTopline(1.0, lineColor: UIColor.lightGray, lineWidth: bottom_view.bounds.width)
        self.view.addSubview(bottom_view)
        bottom_view.backgroundColor = UIColor.clear
        bottom_view.addSubview(imgTabBg)
        y_position = 0
        btn_y_position = 0
        btn_x_position = 0
        btn_width = w / noOfTab
        btn_height = HeightTabbar
        viewMenu.btnWidthConstant.constant = CGFloat(btn_width)
        viewMenu.btnHeightConstant.constant = CGFloat(btn_width)
        
        viewMenu.btnLogout.DrawButtonTopline(0.5, lineColor: UIColor(hexxString: Global.g_ColorString.GreyLightTxt), lineWidth: CGFloat(btn_width))
        viewMenu.btnSetting.DrawButtonTopline(0.5, lineColor: UIColor(hexxString: Global.g_ColorString.GreyLightTxt), lineWidth: CGFloat(btn_width))
        viewMenu.btnHelp.DrawButtonTopline(0.5, lineColor: UIColor(hexxString: Global.g_ColorString.GreyLightTxt), lineWidth: CGFloat(btn_width))
        viewMenu.btnRateUs.DrawButtonTopline(0.5, lineColor: UIColor(hexxString: Global.g_ColorString.GreyLightTxt), lineWidth: CGFloat(btn_width))
        
        self.addAllElements()
    }
    
    func addAllElements() {
        if btnTab1 != nil {
            btnTab1.removeFromSuperview()
        }
        if btnTab2 != nil {
            btnTab2.removeFromSuperview()
        }
        if btnTab3 != nil {
            btnTab3.removeFromSuperview()
        }
        if btnTab4 != nil {
            btnTab4.removeFromSuperview()
        }
        if btnTab5 != nil {
            btnTab5.removeFromSuperview()
        }
        btnTab1 = self.getGeneralTabButton(0, isSelected: true)
        btnTab2 = self.getGeneralTabButton(1, isSelected: false)
        btnTab3 = self.getGeneralTabButton(2, isSelected: false)
        btnTab4 = self.getGeneralTabButton(3, isSelected: false)
        btnTab5 = self.getGeneralTabButton(4, isSelected: false)
        bottom_view.addSubview(btnTab1)
        bottom_view.addSubview(btnTab2)
        bottom_view.addSubview(btnTab3)
        bottom_view.addSubview(btnTab4)
        bottom_view.addSubview(btnTab5)
        // Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
        btnTab1.addTarget(self, action: #selector(self.buttonClicked), for: .touchDown)
        btnTab2.addTarget(self, action: #selector(self.buttonClicked), for: .touchDown)
        btnTab3.addTarget(self, action: #selector(self.buttonClicked), for: .touchDown)
        btnTab4.addTarget(self, action: #selector(self.buttonClicked), for: .touchDown)
        btnTab5.addTarget(self, action: #selector(self.buttonClicked), for: .touchDown)
    }
    
    
    
    func getGeneralTabButton(_ pintTag: Int, isSelected pbolIsSelected: Bool) -> UIButton {
        var btnImage: UIImage?
        var btnImageSelected: UIImage?
        
        var btnBGImage: UIImage?
        var btnBGImageSelected: UIImage?
        
        let btn = TabbatButton(type: .custom)
        btn.setTitleColor(UIColor.white, for: .selected)
        btn.setTitleColor(UIColor(hexxString: Global.g_ColorString.GreyLightTxt), for: .normal)
        btn.titleLabel!.font = UIFont(name: Global.CFName.Muli_Semibold, size: CGFloat(10.0))!
        btn.tag = pintTag
        btn.isSelected = pbolIsSelected
        btnImage = nil
        btnImageSelected = nil
        switch pintTag {
        case 0:
            //Tab-1
            btnImage = UIImage(named: "book_now_green")!
            btnImageSelected = UIImage(named: "book_now")!
            btnBGImage = UIImage(named: "white_footer")!
            btnBGImageSelected = UIImage(named: "green_footer")!
            btn.frame = CGRect(x: CGFloat(btn_x_position), y: CGFloat(btn_y_position), width: CGFloat(btn_width), height: CGFloat(btn_height))
            btn.setTitle("Book Now", for: .normal)
        case 1:
            //Tab-2
            btnImage = UIImage(named: "my_rentals_green")!
            btnImageSelected = UIImage(named: "my_rentals")!
            btnBGImage = UIImage(named: "white_footer")!
            btnBGImageSelected = UIImage(named: "green_footer")!
            btn.frame = CGRect(x: CGFloat(btn_x_position + btn_width), y: CGFloat(btn_y_position), width: CGFloat(btn_width), height: CGFloat(btn_height))
            btn.setTitle("My Rentals", for: .normal)
        case 2:
            //Tab-3
//            btnImage = UIImage(named:"profile")!
//            btnImageSelected = UIImage(named:"profile_green")!
            btnImage = UIImage(named: "profile_green")!
            btnImageSelected = UIImage(named: "profile")!
            btnBGImage = UIImage(named: "white_footer")!
            btnBGImageSelected = UIImage(named: "green_footer")!
            btn.frame = CGRect(x: CGFloat(btn_x_position + (btn_width * 2)), y: CGFloat(btn_y_position), width: CGFloat(btn_width), height: CGFloat(btn_height))
            btn.setTitle("Profile", for: .normal)
        case 3:
            //Tab-4
            
            btnImage = UIImage(named: "more_green")!
            btnImageSelected = UIImage(named: "more")!
            btnBGImage = UIImage(named: "white_footer")!
            btnBGImageSelected = UIImage(named: "green_footer")!
            btn.frame = CGRect(x: CGFloat(btn_x_position + (btn_width * 3)), y: CGFloat(btn_y_position), width: CGFloat(btn_width), height: CGFloat(btn_height))
            btn.setTitle("More", for: .normal)
        default:
            //Tab-1
            btnImage = UIImage(named: "more_green")!
            btnImageSelected = UIImage(named: "more")!
            btnBGImage = UIImage(named: "white_footer")!
            btnBGImageSelected = UIImage(named: "green_footer")!
            btn.frame = CGRect(x: CGFloat(btn_x_position + (btn_width * 4)), y: CGFloat(btn_y_position), width: CGFloat(btn_width), height: CGFloat(btn_height))
            btn.setTitle("More", for: .normal)
        }
        
        btn.setImage(btnImage, for: .normal)
        btn.setImage(btnImageSelected, for: .selected)
        
        btn.setBackgroundImage(btnBGImage, for: .normal)
        btn.setBackgroundImage(btnBGImageSelected, for: .selected)
        if #available(iOS 9.0, *) {
            btn.setBackgroundImage(btnBGImageSelected, for: .focused)
        } else {
            btn.setBackgroundImage(btnBGImageSelected, for: .highlighted)
        }
        
        //(btn.frame.size.width / 2) - (btn.imageView!.frame.size.width/2)
        //btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView!.frame.size.width, -btn.titleLabel!.frame.size.height * 2, 0)
        
        //btn.imageEdgeInsets = UIEdgeInsetsMake(-(btn.imageView!.frame.size.height),((btn.titleLabel?.frame.size.width)!) - ((btn.imageView?.frame.size.width)!/2), 0, 0)
        //btn.titleLabel?.frame = CGRect(x: 0, y: btn.frame.size.height-15, width: btn.frame.size.width, height: 15)
        //btn.titleLabel!.textAlignment = .center
        //btn.titleLabel?.backgroundColor = UIColor.red
        //btn.imageView?.backgroundColor = UIColor.yellow
        setupButton(button: btn)
    
        return btn
    }
    func setupButton(button: UIButton) {
        let spacing: CGFloat = 3.0
        let imageSize: CGSize = button.imageView!.image!.size
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -22, 0.0)
        let labelString = NSString(string: button.titleLabel!.text!)
        let titleSize = labelString.size(attributes: [NSFontAttributeName: button.titleLabel!.font])
        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing - 11), 0.0, 0.0, -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
    }
    
    // MARK: - Select Tab
    
    func buttonClicked(_ sender: Any) {
        let tagNum = Int((sender as AnyObject).tag)
        self.selectTab(tagNum)
    }
    
    func selectTab(_ tabID: Int) {
        hideMenuView()
        switch tabID {
        case 0:
            btnTab1.isSelected = true
            btnTab2.isSelected = false
            btnTab3.isSelected = false
            btnTab4.isSelected = false
            btnTab5.isSelected = false
        case 1:
            btnTab1.isSelected = false
            btnTab2.isSelected = true
            btnTab3.isSelected = false
            btnTab4.isSelected = false
            btnTab5.isSelected = false
        case 2:
            btnTab1.isSelected = false
            btnTab2.isSelected = false
            btnTab3.isSelected = true
            btnTab4.isSelected = false
            btnTab5.isSelected = false
        case 3:
            showMenuview()
            btnTab1.isSelected = false
            btnTab2.isSelected = false
            btnTab3.isSelected = false
            btnTab4.isSelected = true
            btnTab5.isSelected = false
        case 4:
            btnTab1.isSelected = false
            btnTab2.isSelected = false
            btnTab3.isSelected = false
            btnTab4.isSelected = false
            btnTab5.isSelected = true
        default:
            print("default case.")
            
        }
        
        self.selectedIndex = tabID
        if self.selectedIndex == tabID {
            if tabID == 3 {
                return
            }
            else {
                if let rootView = self.viewControllers![self.selectedIndex] as? UINavigationController {
                    rootView.popToRootViewController(animated: false)
                }
            }
        }
        else {
            self.selectedIndex = tabID
        }
    }
    
    func showTabBar() {
        self.bottom_view.isHidden = false
        self.imgTabBg.isHidden = false
        self.btnTab1.isHidden = false
        self.btnTab2.isHidden = false
        self.btnTab3.isHidden = false
        self.btnTab4.isHidden = false
        self.btnTab5.isHidden = false
        self.btnTab1.isUserInteractionEnabled = true
        self.btnTab2.isUserInteractionEnabled = true
        self.btnTab3.isUserInteractionEnabled = true
        self.btnTab4.isUserInteractionEnabled = true
        self.btnTab5.isUserInteractionEnabled = true
    }
    
    func hideTabBar() {
        self.bottom_view.isHidden = true
        self.imgTabBg.isHidden = true
        self.btnTab1.isHidden = true
        self.btnTab2.isHidden = true
        self.btnTab3.isHidden = true
        self.btnTab4.isHidden = true
        self.btnTab5.isHidden = true
        self.btnTab1.isUserInteractionEnabled = false
        self.btnTab2.isUserInteractionEnabled = false
        self.btnTab3.isUserInteractionEnabled = false
        self.btnTab4.isUserInteractionEnabled = false
        self.btnTab5.isUserInteractionEnabled = false
    }
    /*  #pragma mark -Load Nib
     - (id)loadViewNib:(NSString *)nibName {
     NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
     if([nibs count] > 0) {
     return [nibs objectAtIndex:0];
     }
     return nil;
     }
     #pragma mark- player delegate method
     -(void)pushSettingView
     {
     
     }
     -(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
     if ([keyPath isEqual:@"outputVolume"]) {
     NSLog(@"volume changed!");
     
     }
     
     }*/
    
    func showMenuview() -> Void {
        viewMenu.isHidden = false
    }
    
    func hideMenuView() -> Void {
        viewMenu.isHidden = true
    }
    
    //MARK:- BUTTON ACTION METHODS
    func btnReportClick() -> Void {
       
    }
    func btnLogoutClick() -> Void {
        Global.appdel.LogoutUser()
    }
    
    func btnRateUSClick() -> Void {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1024941703"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    func btnSettingClick() -> Void {
        
    }
    
    func btnHelpClick() -> Void {
        
    }
}


