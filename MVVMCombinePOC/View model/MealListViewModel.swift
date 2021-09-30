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
    let mealsPublisher = PassthroughSubject<[Meal], AFError>()
}

class MealListViewModel: Bindable {
    
    private var subscriptions = Set<AnyCancellable>()
    private let output = MealListViewModelOutput()
    
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
        AF.request("https://www.themealdb.com/api/json/v1/1/search.php?f=a").responseDecodable(of: MealsResponse.self) {response in
            switch response.result {
            case .success(let mealsResponse):
                self.output.mealsPublisher.send(mealsResponse.meals)
                break
            case .failure(let error):
                self.output.mealsPublisher.send(completion: .failure(error))
                break
            }
        }
    }
    
    private func goToNextScreen() {
        print("GO TO NEXT SCREEN")
    }
    
}
