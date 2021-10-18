//
//  TabBarCoordinator.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        
        let mealsNavigationController = UINavigationController()
        mealsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let mealsListCoordinator = MealListCoordinator(navigationController: mealsNavigationController)
        
        tabBarController.viewControllers = [homeNavigationController, mealsNavigationController]
        tabBarController.modalPresentationStyle = .fullScreen
        
        coordinate(to: homeCoordinator)
        coordinate(to: mealsListCoordinator)
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
