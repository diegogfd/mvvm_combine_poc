//
//  HomeSceneBuilder.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation
import UIKit

class HomeSceneBuilder {
    func build(coordinator: HomeCoordinator) -> UIViewController {
        let repository = HomeRepository()
        let useCase = HomeUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: useCase)
        let viewController = HomeViewController(viewModel: viewModel, coordinator: coordinator)
        return viewController
    }
}
