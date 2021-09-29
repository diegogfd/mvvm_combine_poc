//
//  ViewModel.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 29/09/2021.
//

import Foundation
import Alamofire
import Combine

protocol MealListViewModelProtocol: ViewModel {
    
}

struct MealListViewModelInput {
    let viewLoadedPublisher: AnyPublisher<Void, Never>
    let tapRowPublisher: AnyPublisher<Int, Never>
}

class MealListViewModel: MealListViewModelProtocol {
    
    var meals: [Meal] = []
    private var subscriptions = Set<AnyCancellable>()
    
    var mealsPublisher = PassthroughSubject<[Meal], Never>()
    
    func bind(input: MealListViewModelInput) {
        input.viewLoadedPublisher.sink {
            self.fetch()
        }
        .store(in: &self.subscriptions)
    }
    
    private func fetch() {
        AF.request("https://www.themealdb.com/api/json/v1/1/search.php?f=a").responseDecodable(of: MealsResponse.self) {response in
            switch response.result {
            case .success(let mealsResponse):
                self.meals = mealsResponse.meals
                self.mealsPublisher.send(self.meals)
                break
            case .failure(let error):
                break
            }
        }
    }
    
    private func goToNextScreen() {
        print("GO TO NEXT SCREEN")
    }
    
}
