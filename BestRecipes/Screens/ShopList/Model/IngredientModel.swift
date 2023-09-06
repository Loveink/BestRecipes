//
//  IngredientModel.swift
//  BestRecipes
//
//  Created by Анастасия Рыбакова on 03.09.2023.
//

import Foundation

struct IngredientModel: Codable {
    let image: String
    let name: String
    let amount: Double
    
    static func makeMockData() -> [Self] {
        [
            IngredientModel(image: "image", name: "Картошка", amount: 10),
            IngredientModel(image: "image", name: "Моркошка", amount: 2),
            IngredientModel(image: "image", name: "Огурки", amount: 2),
            IngredientModel(image: "image", name: "Помидорки", amount: 3),
            IngredientModel(image: "image", name: "Мазик", amount: 3),
            IngredientModel(image: "image", name: "Огурки", amount: 1),
            IngredientModel(image: "image", name: "Помидорки", amount: 1),
            IngredientModel(image: "image", name: "Мазик", amount: 1),
            
        ]
    }
}


