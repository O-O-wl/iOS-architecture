//
//  AppDelegate.swift
//  MVP
//
//  Created by 이동영 on 2020/01/21.
//  Copyright © 2020 이동영. All rights reserved.
//

import UIKit
import Domain
import NetworkPlatform
import LocalPlatform

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let booksView = BooksViewController().then {
            $0.tabBarItem = .init(title: "Book",
                                  image: UIImage(systemName: "book.fill"),
                                  tag: 0)
        }
        
        let networkUseCaseProvider: Domain.UseCaseProvider = NetworkPlatform.UseCaseProvider()
        let localUseCaseProvider: Domain.UseCaseProvider = LocalPlatform.UseCaseProvider()
        
        let networkUseCase = networkUseCaseProvider.makeBookUseCase()
        let localUseCase = localUseCaseProvider.makeBookUseCase()
        
        let booksPresenter = BooksPresenterImplementation(view: booksView,
                                                          networkUseCase: networkUseCase,
                                                          localUseCase: localUseCase)
        booksView.presenter = booksPresenter
        
        let favoriteBooksView = FavoriteBooksViewController().then {
            $0.tabBarItem = .init(title: "Favorite",
                                  image: UIImage(systemName: "heart.fill"),
                                  tag: 0)
        }
        
        let favoriteBooksPresenter = FavoriteBooksPresenterImplementation(view: favoriteBooksView,
                                                                          localUseCase: localUseCase)
        favoriteBooksView.presenter = favoriteBooksPresenter
        
        let tabBarController = UITabBarController().then {
            $0.setViewControllers([booksView, favoriteBooksView], animated: true)
        }
        
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
        return true
    }
}

