//
//  MealDetailRepository.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation
import Combine

protocol MealDetailRepositoryProtocol {
    func getMealDetail() -> AnyPublisher<MealDetailViewData, Never>
}

class MealDetailRepository: MealDetailRepositoryProtocol {
    
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    func getMealDetail() -> AnyPublisher<MealDetailViewData, Never> {
        return Just(MealDetailViewData(meal: meal))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
