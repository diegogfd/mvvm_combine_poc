//
//  SceneBuilder.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation
import UIKit

public protocol SceneBuilder {
    func build(params: [String : Any], coordinator: Coordinator) -> UIViewController
    func build(params: [String : Any]) -> UIViewController
}
