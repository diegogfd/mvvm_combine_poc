//
//  HomeViewModel.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation

protocol HomeViewModelProtocol {
    
}

class HomeViewModel: HomeViewModelProtocol {
    
    private let useCase: HomeUseCaseProtocol
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
    
}
