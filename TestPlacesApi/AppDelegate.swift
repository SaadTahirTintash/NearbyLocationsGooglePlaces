//
//  AppDelegate.swift
//  TestPlacesApi
//
//  Created by Tintash on 26/08/2019.
//  Copyright © 2019 Tintash. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSPlacesClient.provideAPIKey("AIzaSyCVl4v76fwh4wwZL9G31SEOeu8yaxQK1-o")
        
        return true
    }

}

