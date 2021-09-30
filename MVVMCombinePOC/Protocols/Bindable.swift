//
//  Bindable.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 30/09/2021.
//

import Foundation

protocol Bindable {
    associatedtype Input
    associatedtype Output
    
    func bind(input: Input) -> Output
}
