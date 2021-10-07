//
//  ViewModel.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 29/09/2021.
//

import Foundation
import Alamofire
import Combine

struct MealListViewModelInput {
    let tapRowPublisher = PassthroughSubject<Int, Never>()
    let viewLoadedPublisher = PassthroughSubject<Void, Never>()
    let retryPublisher = PassthroughSubject<Void, Never>()
}

struct MealListViewModelOutput {
    let mealsPublisher = PassthroughSubject<[Meal], MealListError>()
}

protocol MealListViewModelProtocol {
    func bind(input: MealListViewModelInput) -> MealListViewModelOutput
}

class MealListViewModel: MealListViewModelProtocol {
    
    private var subscriptions = Set<AnyCancellable>()
    private let output = MealListViewModelOutput()
    @Published var meals: [Meal] = []
    private let getMealListUseCase: GetMealListUseCaseProtocol
    
    init(getMealListUseCase: GetMealListUseCaseProtocol = GetMealListUseCase()) {
        self.getMealListUseCase = getMealListUseCase
    }
    
    func bind(input: MealListViewModelInput) -> MealListViewModelOutput {
        input.viewLoadedPublisher.sink { [weak self] in
            self?.fetch()
        }
        .store(in: &self.subscriptions)
        
        input.tapRowPublisher.sink { [weak self] row in
            self?.goToNextScreen()
        }.store(in: &self.subscriptions)
        
        input.retryPublisher.sink { [weak self] in
            self?.fetch()
        }.store(in: &self.subscriptions)
        
        return output
    }
    
    private func fetch() {
        self.getMealListUseCase.getMeals().sink { [weak self] result in
            if case .failure(let error) = result {
                self?.output.mealsPublisher.send(completion: .failure(error))
            }
        } receiveValue: { [weak self] meals in
            self?.output.mealsPublisher.send(meals)
        }
        .store(in: &subscriptions)
    }
    
    private func goToNextScreen() {
        print("GO TO NEXT SCREEN")
    }
    
}
