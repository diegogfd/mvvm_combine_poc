//
//  MealDetailViewData.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 15/10/2021.
//

import Foundation

struct MealDetailViewData {
    let thumbnailURL: URL?
    let title: String
    let instructions: String
}

extension MealDetailViewData {
    init(meal: Meal) {
        self.title = meal.name
        self.thumbnailURL = URL(string: meal.thumbnailURL)
        self.instructions = meal.instructions
    }
}
