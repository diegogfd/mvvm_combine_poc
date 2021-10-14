//
//  MealRouting.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 13/10/2021.
//

import Foundation

struct MealRouting: RoutingInfo {   
    var host: String = "meal"
    var mapping: [String : SceneBuilder] = [:]//["list" : MealListSceneBuilder()]
}
