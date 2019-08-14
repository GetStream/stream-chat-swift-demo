//
//  AppDelegate.swift
//  Imgur
//
//  Created by Alexey Bukhtin on 14/08/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChatCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Client.config = .init(apiKey: "qk4nn7rpcn75", logOptions: .none)
        Client.shared.set(user: User(id: "noisy-mountain-3", name: "Noisy mountain"),
                          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoibm9pc3ktbW91bnRhaW4tMyJ9.GAhzrzo8SsDn_RGzX4Fob5bZB0nKXXPKya8okbr9WB0")
        
        return true
    }
}
