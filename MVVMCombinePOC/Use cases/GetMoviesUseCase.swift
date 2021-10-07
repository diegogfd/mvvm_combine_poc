//
//  GetMoviesUseCase.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 06/10/2021.
//

import Foundation
import Combine

protocol MealListUseCaseProtocol {
    func getMeals() -> AnyPublisher<[Meal],MealListError>
}

class MealListUseCase: MealListUseCaseProtocol {
    
    private let repository: MealsRepositoryProtocol
    
    init(repository: MealsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMeals() -> AnyPublisher<[Meal], MealListError> {
        return self.repository.getMeals()
    }
    
}
