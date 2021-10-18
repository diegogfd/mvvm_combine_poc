//
//  MealsCoordinator.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation
import Combine

import UIKit

protocol MealListCoordinatorProtocol: AnyObject {
    func coordinateToMealDetail(meal: Meal)
}

class MealListCoordinator: Coordinator, MealListCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    private var subscriptions = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let builder = MealListSceneBuilder()
        let mealsListViewController = builder.build(coordinator: self)
        mealsListViewController.viewModel.output.selectedMealPublisher
            .sink { [weak self] meal in
            self?.coordinateToMealDetail(meal: meal)
        }
        .store(in: &subscriptions)
        navigationController.pushViewController(mealsListViewController, animated: false)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToMealDetail(meal: Meal) {
        let mealDetailCoordinator = MealDetailCoordinator(meal: meal, navigationController: navigationController)
        coordinate(to: mealDetailCoordinator)
    }
}
