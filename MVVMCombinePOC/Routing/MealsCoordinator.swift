//
//  MealsCoordinator.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation

import UIKit

protocol MealListCoordinatorProtocol: AnyObject {
    func coordinateToMealDetail()
}

class MealListCoordinator: Coordinator, MealListCoordinatorProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let builder = MealListSceneBuilder()
        let mealsListViewController = builder.build(coordinator: self)
        navigationController.pushViewController(mealsListViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToMealDetail() {
        print("GO TO MEAL DETAIL")
    }
}
