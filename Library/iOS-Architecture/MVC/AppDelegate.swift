//
//  AppDelegate.swift
//  Library
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import LocalPlatform
import NetworkPlatform
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let networkUseCase: Domain.BookUseCase = NetworkPlatform.UseCaseProvider().makeBookUseCase()
        let localUseCase: Domain.BookUseCase = LocalPlatform.UseCaseProvider().makeBookUseCase()
        
        let booksView = BooksViewController().then {
            $0.tabBarItem = .init(title: "Book", image: UIImage(systemName: "book.fill"), tag: 0)
        }
        
        booksView.bookUseCase = networkUseCase
        booksView.favoriteBookUseCase = localUseCase
        
        let favoriteBooksView = FavoriteBooksViewController().then {
            $0.tabBarItem = .init(title: "Favorite", image: UIImage(systemName: "heart.fill"), tag: 0)
        }
        favoriteBooksView.favoriteBookUseCase = localUseCase
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([booksView, favoriteBooksView], animated: true)
        
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
        return true
    }
}

