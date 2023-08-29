//
//  RecipeFullInfoForCell.swift
//  BestRecipes
//
//  Created by Vanopr on 29.08.2023.
//

import Foundation

struct RecipeInfoForCell: Codable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceName: String
    let aggregateLikes: Int
    
}
