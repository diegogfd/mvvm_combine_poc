//
//  MealListSceneBuilder.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation
import UIKit

class MealListSceneBuilder: SceneBuilder {
    
    func build(params: [String : Any]) -> UIViewController {
        let repository = GetMealsRepository(network: Network())
        let useCase = GetMealListUseCase(repository: repository)
        let viewModel = MealListViewModel(getMealListUseCase: useCase)
        let viewController = MealListViewController(viewModel: viewModel)
        return viewController
    }
}
