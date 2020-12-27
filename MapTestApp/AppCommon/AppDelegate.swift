//
//  AppDelegate.swift
//  MapTestApp
//
//  Created by Artem on 26.12.2020.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDlKbcTpU31D2ddhRABgE-pE1qZ1ZZknV4")
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let initialViewController = MapViewController()
    
    window?.rootViewController = initialViewController
    window?.makeKeyAndVisible()
   
    
    return true
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register \(error)")
  }

}
