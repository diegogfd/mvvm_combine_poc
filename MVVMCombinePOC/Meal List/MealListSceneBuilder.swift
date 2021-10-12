//
//  MealListSceneBuilder.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation

protocol MealListSceneBuilderProtocol {
    func build() -> MealListViewController
}

class MealListSceneBuilder: MealListSceneBuilderProtocol {
    func build() -> MealListViewController {
        let repository = GetMealsRepository(network: Network())
        let useCase = GetMealListUseCase(repository: repository)
        let viewModel = MealListViewModel(getMealListUseCase: useCase)
        let viewController = MealListViewController(viewModel: viewModel)
        return viewController
    }
}
