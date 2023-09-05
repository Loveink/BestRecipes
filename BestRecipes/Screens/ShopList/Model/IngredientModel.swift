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
    let amount: String
    
    static func makeMockData() -> [Self] {
        [
            IngredientModel(image: "image", name: "Картошка", amount: "10 кг"),
            IngredientModel(image: "image", name: "Моркошка", amount: "5 кг"),
            IngredientModel(image: "image", name: "Огурки", amount: "2 кг"),
            IngredientModel(image: "image", name: "Помидорки", amount: "3 кг"),
            IngredientModel(image: "image", name: "Мазик", amount: "1 пачка"),
            IngredientModel(image: "image", name: "Огурки", amount: "2 кг"),
            IngredientModel(image: "image", name: "Помидорки", amount: "3 кг"),
            IngredientModel(image: "image", name: "Мазик", amount: "1 пачка"),
            
        ]
    }
}


