//
//  MealDetailViewModel.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation
import Combine

struct MealDetailViewModelInput {
    let viewLoadedPublisher = PassthroughSubject<Void, Never>()
}

struct MealDetailViewModelOutput {
    let mealDetailPublisher = PassthroughSubject<MealDetailViewData, Never>()
}

protocol MealDetailViewModelProtocol {
    func bind(input: MealDetailViewModelInput) -> MealDetailViewModelOutput
}

class MealDetailViewModel: MealDetailViewModelProtocol {
    
    private let useCase: MealDetailUseCaseProtocol
    private var subscriptions = Set<AnyCancellable>()
    private let output = MealDetailViewModelOutput()
    
    init(useCase: MealDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func bind(input: MealDetailViewModelInput) -> MealDetailViewModelOutput {
        input.viewLoadedPublisher.sink { [weak self] in
            self?.loadViewData()
        }
        .store(in: &self.subscriptions)
        
        return output
    }
    
    private func loadViewData() {
        self.useCase.getMealDetail().sink { [weak self] viewData in
            self?.output.mealDetailPublisher.send(viewData)
        }.store(in: &subscriptions)
    }
    
}
