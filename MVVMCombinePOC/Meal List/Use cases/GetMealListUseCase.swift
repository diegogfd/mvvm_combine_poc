//
//  GetMoviesUseCase.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 06/10/2021.
//

import Foundation
import Combine

protocol GetMealListUseCaseProtocol {
    func getMeals() -> AnyPublisher<[Meal],MealListError>
}

class GetMealListUseCase: GetMealListUseCaseProtocol {
    
    private let repository: GetMealsRepositoryProtocol
    
    init(repository: GetMealsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMeals() -> AnyPublisher<[Meal], MealListError> {
        return self.repository.getMeals()
    }
    
}
