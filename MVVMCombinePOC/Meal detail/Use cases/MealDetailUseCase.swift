//
//  MealDetailUseCase.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation
import Combine

protocol MealDetailUseCaseProtocol {
    func getMealDetail() -> AnyPublisher<MealDetailViewData, Never>
}

class MealDetailUseCase: MealDetailUseCaseProtocol {
    
    let repository: MealDetailRepositoryProtocol
    
    init(repository: MealDetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMealDetail() -> AnyPublisher<MealDetailViewData, Never> {
        repository.getMealDetail()
    }
}
