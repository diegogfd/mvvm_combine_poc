//
//  MealsRepository.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 06/10/2021.
//

import Foundation
import Combine

enum MealListError: Error {
    case parsingError
    case connectionError
    case unknown
}

protocol GetMealsRepositoryProtocol {
    func getMeals() -> AnyPublisher<[Meal],MealListError>
}

class GetMealsRepository: GetMealsRepositoryProtocol {
    
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getMeals() -> AnyPublisher<[Meal], MealListError> {
        network.get(type: MealsResponse.self, url: URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?f=a")!, headers: [:])
            .map { $0.meals }
            .mapError { networkError in
                guard let error = networkError as? URLError else {
                    return .unknown
                }
                switch error.errorCode {
                case URLError.notConnectedToInternet.rawValue:
                    return .connectionError
                case URLError.cannotParseResponse.rawValue:
                    return .parsingError
                default:
                    return .unknown
                }
            }
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
