//
//  MealListCellViewModel.swift
//  MVVMCombinePOC
//
//  Created by Diego Flores on 14/10/2021.
//

import Foundation

struct MealListCellData {
    let title: String
    let thumbnailURL: URL?
}

extension MealListCellData {
    init(meal: Meal) {
        self.title = meal.name
        self.thumbnailURL = URL(string: meal.thumbnailURL)
    }
}
