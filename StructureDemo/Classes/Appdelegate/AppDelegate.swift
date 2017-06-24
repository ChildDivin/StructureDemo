//
//  AppDelegate.swift
//  Club Mobile Application
//
//  Created by Tops on 12/7/16.
//  Copyright © 2016 Self. All rights reserved.

import UIKit
import IQKeyboardManagerSwift
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate,UITabBarDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate{
    
    var window: UIWindow?
    var nav : UINavigationController?
    var login : LoginVC?
    var locationManager : CLLocationManager!
    var navHome : UINavigationController?
    var strUniqueID = String()
    var intReqestMinite = 0
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        
        if #available(iOS 9.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(lowPowerModeStateChange), name: NSNotification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        } else {
            intReqestMinite = 30
        }
        
        RegistrationForNotification()
        self.setupLocationManager()
        self.lowPowerModeStateChange()
        
        if StaticClass().isAppLaunchedFirst(){
            StaticClass().saveToUserDefaults((false) as AnyObject, forKey: Global.g_UserDefaultKey.IS_USERLOGIN)
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        login = LoginVC (nibName: "LoginVC", bundle:nil)
        //let loginObj = DropZoneVC (nibName: "DropZoneVC", bundle:nil)
        nav = UINavigationController(rootViewController: login!)
        nav?.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        if let notification = launchOptions?[.remoteNotification] as? NSDictionary {
            notificationReceived(notification: notification as [NSObject : AnyObject])
        }
        
        if  (StaticClass().retriveFromUserDefaults(Global.g_UserDefaultKey.IS_USERLOGIN) as! Bool) {
           // ConfigureTabbarAgent(animated: false)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {     }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0; // Clear badge when app is or resumed
    }
    
    func applicationWillTerminate(_ application: UIApplication) {    }
    
    func application(_ application: UIApplication, willChangeStatusBarFrame newStatusBarFrame: CGRect) {  }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
            
            return true;
    }
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // execute code here
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //MARK: LOGOUT
    func LogoutUser() -> Void {
        UserLogourCall()
    }
    
    //MARK: Cutom tab bar for Agent
    func  ConfigureTabbarAgent(animated:Bool) -> Void {
        self.gotoDetailAppAgent(0)
        //self.nav?.pushViewController(self.tabBarController!, animated: animated)
    }
    func gotoDetailAppAgent(_ pintTabId: Int) {
        self.setTabBarForAgent()
//        self.tabBarController?.delegate = self
//        self.tabBarController?.selectedIndex = pintTabId
//        self.tabBarController?.selectTab(pintTabId)
    }
    func setTabBarForAgent() {
        //Note: Use this method and respective variables when there is TabBar in the app.
//        self.tabBarController = UITabBarCustom()
//        // first
//        homeObj = BookNowVC(nibName: "BookNowVC", bundle: nil)
//        navHome = UINavigationController(rootViewController: homeObj!)
//        //second
//        let sellObj = MyRentalVC(nibName: "MyRentalVC", bundle: nil)
//        let navSell = UINavigationController(rootViewController: sellObj)
//        //Thard
//        let StatObj = MyProfileVC(nibName: "MyProfileVC", bundle: nil)
//        let navAgentStat = UINavigationController(rootViewController: StatObj)
//        //forth
//        let AgentStateObj = HomeVC(nibName: "HomeVC", bundle: nil)
//        let navCardState = UINavigationController(rootViewController: AgentStateObj)
//        
//        self.tabBarController?.viewControllers = [navHome!,navSell,navAgentStat,navSell]
//        navHome!.isNavigationBarHidden = true
//        navAgentStat.isNavigationBarHidden = true
//        navSell.isNavigationBarHidden = true
//        navCardState.isNavigationBarHidden = true
    }
    
    
    //MARK:- LOCATION UPDATE
    func setupLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManager?.stopMonitoringSignificantLocationChanges()
        locationManager?.stopUpdatingLocation()
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locationValue)")
        //StaticClass.sharedInstance.setLatitude(lat: CGFloat(locationValue.latitude), Long: CGFloat(locationValue.longitude))
        StaticClass().saveToUserDefaults(locationValue.latitude as AnyObject?, forKey: Global.g_UserDefaultKey.latitude)
        StaticClass().saveToUserDefaults(locationValue.longitude as AnyObject?, forKey: Global.g_UserDefaultKey.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    //MARK:-  LOGOUT CALL
    private func UserLogourCall() -> Void {
        //http://192.168.0.17/web_services/kuloni_kube/ws/logout/id/1
        let strUrl = "logout/id/32\(StaticClass.sharedInstance.strUserId)"
        APICall.shared.Get(strUrl, withLoader: true) { (response) in
            print(response);
            if let dict = response as? NSDictionary {
                if (dict["FLAG"] as! Bool){
                    
                    StaticClass().saveToUserDefaults((false) as AnyObject, forKey: Global.g_UserDefaultKey.IS_USERLOGIN)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.UserID)
                    
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USERFIRSTNAME)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USERLASTNAME)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.UserEMail)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USER_DOB)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USERPROFILEIMAGEURL)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USER_IsVarify)
                    
                    // ADDITONAL
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.UserGender)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.UserMobile)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USERID_FB)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USERID_GG)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USERID_TW)
                    StaticClass().saveToUserDefaults("" as AnyObject, forKey: Global.g_UserData.USER_IsVarify)
                    
                    _ = self.nav?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    //MARK:-  LOW POWER MODE 
    func lowPowerModeStateChange() -> Void {
        if #available(iOS 9.0, *) {
            if ProcessInfo.processInfo.isLowPowerModeEnabled {
                intReqestMinite = 60
            } else {
                intReqestMinite = 30
            }
        }
    }
    
    
    //MARK:-  PUSH NOTIFICATION REGISTER
    func RegistrationForNotification() -> Void {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        NSLog("DEVICE TOKEN:- %@",deviceTokenString)
        StaticClass().saveToUserDefaults(deviceTokenString as AnyObject?, forKey: Global.g_UserDefaultKey.DeviceToken)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("ERROR GETING DEVICE TOKEN ")
    }
    
    //MARK:- NOTIFICATION RECEVED METHODS
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        notificationReceived(notification: userInfo as [NSObject : AnyObject])
        switch application.applicationState {
        case .inactive:
            print("Inactive")
            //Show the view with the content of the push
            
            break
        case .background:
            print("Background")
            //Refresh the local model
            
            break
        case .active:
            print("Active")
            //Show an in-app banner
            break
        }
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let userInfo = notification.request.content.userInfo as? [String : AnyObject] {
            print(userInfo)
            IPNotificationManager.shared.GetPushProcessDataWhenActive(dictNoti: userInfo as NSDictionary)
        }
        NSLog("Handle push from foreground" )
        completionHandler(.badge)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String : AnyObject] {
            print(userInfo)
             IPNotificationManager.shared.GetPushProcessData(dictNoti: userInfo as NSDictionary)
        }
         NSLog("Handle push from background or closed" )
        completionHandler()
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        notificationReceived(notification: userInfo as [NSObject : AnyObject])
        switch application.applicationState {
        case .inactive:
            print("Inactive")
            //Show the view with the content of the push
            completionHandler(.newData)
            
        case .background:
            print("Background")
            //Refresh the local model
            completionHandler(.newData)
            
        case .active:
            print("Active")
            //Show an in-app banner
            completionHandler(.newData)
        }
    }
    
    func notificationReceived(notification: [NSObject:AnyObject]) {
         NSLog("notificationReceived : - %@",notification)
         //IPNotificationManager.shared.GetPushProcessData(dictNoti: notification as NSDictionary)
    }
    
    private func getAlert(notification: [NSObject:AnyObject]) -> (String, String) {
        let aps = notification["aps" as NSString] as? [String:Any]
        let alert = aps?["alert"] as? [String:AnyObject]
        let title = alert?["title"] as? String
        let body = alert?["body"] as? String
        return (title ?? "-", body ?? "-")
    }
}
