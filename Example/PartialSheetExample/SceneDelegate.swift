//
//  SceneDelegate.swift
//  PartialSheetExample
//
//  Created by Bobby Schultz on 1/29/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()
            .attachPartialSheetToRoot()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(
                rootView: contentView
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
