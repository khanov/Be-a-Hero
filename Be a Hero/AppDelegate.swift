//
//  AppDelegate.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/14/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private(set) var email: String? {
        set { Defaults["email"] = newValue }
        get { return Defaults["email"].string }
    }
    private(set) var name: String? {
        set { Defaults["name"] = newValue }
        get { return Defaults["name"].string }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.tintColor = UIColor(red: 141/255.0, green: 54/255.0, blue: 142/255.0, alpha: 1.0)
        
        if isLoggedIn == false {
            // If we are not logged in, display sign up screen by overriding initial view controller defined in Storyboard.
            // Otherwise the initial view controller from Storyboard will be used.
            
            let signUpVC = window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("SignUpViewController") as? UIViewController
            window?.rootViewController = signUpVC
        }
    
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    var isLoggedIn: Bool {
        return Defaults.hasKey("email") && Defaults.hasKey("name")
    }

    func signUpWithName(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    func logOut() {
        email = nil
        name = nil
    }

}

