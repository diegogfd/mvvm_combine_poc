//
//  MealDetailCoordinator.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation
import UIKit

protocol MealDetailCoordinatorProtocol: Coordinator {

}

class MealDetailCoordinator: MealDetailCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let meal: Meal
    
    init(meal: Meal, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.meal = meal
    }
    
    func start() {
        let builder = MealDetailSceneBuilder()
        let viewController = builder.build(meal: meal)
        navigationController.pushViewController(viewController, animated: true)
    }
}
