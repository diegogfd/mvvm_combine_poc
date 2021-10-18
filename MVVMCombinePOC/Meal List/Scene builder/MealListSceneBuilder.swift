//
//  MealListSceneBuilder.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation
import UIKit

class MealListSceneBuilder {
    
    func build(coordinator: MealListCoordinator) -> MealListViewController {
        let repository = GetMealsRepository(network: Network())
        let useCase = GetMealListUseCase(repository: repository)
        let viewModel = MealListViewModel(getMealListUseCase: useCase)
        let viewController = MealListViewController(viewModel: viewModel, coordinator: coordinator)
        return viewController
    }
}
