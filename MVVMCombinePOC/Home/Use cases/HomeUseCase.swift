//
//  HomeUseCase.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation

protocol HomeUseCaseProtocol {
    
}

class HomeUseCase: HomeUseCaseProtocol {
    
    private let repository: HomeRepositoryProtocol
    
    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
    
}
