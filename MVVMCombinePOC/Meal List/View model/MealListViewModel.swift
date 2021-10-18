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
    let mealsPublisher = PassthroughSubject<[MealListCellData], MealListError>()
    let selectedMealPublisher = PassthroughSubject<Meal, Never>()
}

protocol MealListViewModelProtocol {
    func bind(input: MealListViewModelInput) -> MealListViewModelOutput
    var output: MealListViewModelOutput { get }
}

class MealListViewModel: MealListViewModelProtocol {
    
    private var subscriptions = Set<AnyCancellable>()
    let output = MealListViewModelOutput()
    private let getMealListUseCase: GetMealListUseCaseProtocol
    private var meals: [Meal] = []
    
    init(getMealListUseCase: GetMealListUseCaseProtocol) {
        self.getMealListUseCase = getMealListUseCase
    }
    
    func bind(input: MealListViewModelInput) -> MealListViewModelOutput {
        input.viewLoadedPublisher.sink { [weak self] in
            self?.fetch()
        }
        .store(in: &self.subscriptions)
        
        input.tapRowPublisher.sink { [weak self] row in
            self?.goToNextScreen(mealIndex: row)
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
            self?.meals = meals
            let mealModels = meals.map { MealListCellData(meal: $0)}
            self?.output.mealsPublisher.send(mealModels)
        }
        .store(in: &subscriptions)
    }
    
    private func goToNextScreen(mealIndex: Int) {
        guard mealIndex >= 0, mealIndex < self.meals.count else {
            return
        }
        self.output.selectedMealPublisher.send(self.meals[mealIndex])
    }
    
}
