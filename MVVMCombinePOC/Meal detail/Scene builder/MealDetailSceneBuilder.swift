//
//  MealDetailSceneBuilder.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation

class MealDetailSceneBuilder {
    
    func build(meal: Meal) -> MealDetailViewController {
        let repository = MealDetailRepository(meal: meal)
        let useCase = MealDetailUseCase(repository: repository)
        let viewModel = MealDetailViewModel(useCase: useCase)
        let viewController = MealDetailViewController(viewModel: viewModel)
        return viewController
    }
    
}
