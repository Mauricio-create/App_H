//
//  App_HApp.swift
//  App_H
//
//  Created by Mauricio Castelazo on 29/04/23.
//

import SwiftUI
import FirebaseCore



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}



@main
struct App_HApp: App {
    var body: some Scene {
        WindowGroup {
            AuthenticationView()
        }
    }
}
