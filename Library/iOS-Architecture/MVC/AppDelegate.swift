//
//  AppDelegate.swift
//  Library
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import NetworkPlatform

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let networkUseCaseProvider: Domain.UseCaseProvider = NetworkPlatform.UseCaseProvider()
        
        let bookView = BooksViewController()
        bookView.bookUseCase = networkUseCaseProvider.makeBookUseCase()
        
        window?.rootViewController = bookView
        
        window?.makeKeyAndVisible()
        return true
    }
}

