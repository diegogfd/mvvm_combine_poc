//
//  RoutingInfo.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 12/10/2021.
//

import Foundation
import UIKit

public protocol RoutingInfo {
    var host: String { get }
    var mapping: [String : SceneBuilder] { get }
}

