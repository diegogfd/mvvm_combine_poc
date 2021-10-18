//
//  HomeCoordinator.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol: Coordinator {
    
}

class HomeCoordinator: HomeCoordinatorProtocol {
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let builder = HomeSceneBuilder()
        let viewController = builder.build(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}
