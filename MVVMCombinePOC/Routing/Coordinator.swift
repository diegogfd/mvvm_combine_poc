//
//  Coordinator.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation

public protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

public extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
