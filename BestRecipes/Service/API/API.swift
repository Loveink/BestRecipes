//
//  API.swift
//  BestRecipes
//
//  Created by Vanopr on 27.08.2023.
//

//https://api.spoonacular.com/recipes/complexSearch?apiKey=611a18c719a04c4fb245e60ee70336b3&sort=popularity&number=50

//https://api.spoonacular.com/recipes/informationBulk?ids=715424&apiKey=82c2d8b368364b64ba37c4f11aa55670

//https://api.spoonacular.com/recipes/complexSearch?query=fried%20pot&apiKey=82c2d8b368364b64ba37c4f11aa55670

import Foundation
import UIKit

let networkManager = NetworkManager()

    enum url {
        static let MainUrl = "https://api.spoonacular.com/recipes/"
    }

  // Свои ключи

    enum apiKey {
        static let key1 = "82c2d8b368364b64ba37c4f11aa55670"
        static let key2 = "c0472158d42f45c9b91c7244460c36e1"
    }

    let apiKeySelect = apiKey.key2

    enum adds {
        static let popularity = "&sort=popularity"
        static let information = "informationBulk"
        static let number = "&number=50"
        static let complexSearch = "complexSearch"
        static let autocomplete = "autocomplete"
        
    }

struct RecipeAPI {
    
    static func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }
    
    
//MARK: - Запросы
    
    // Для Trending
    static func fetchTrends() async throws -> RecipeResults {
        let urlString = "\(url.MainUrl)\(adds.complexSearch)?apiKey=\(apiKeySelect)\(adds.popularity)"
        return try await networkManager.request(urlString: urlString)
    }
    // Для See all
    static func fetchTrendsAll() async throws -> RecipeResults {
        let urlString = "\(url.MainUrl)\(adds.complexSearch)?apiKey=\(apiKeySelect)\(adds.popularity)\(adds.number)"
        return try await networkManager.request(urlString: urlString)
    }
    // Для Detail
    static func fetchFullInfo(_ id: Int) async throws ->  [RecipeFullInfo] {
        let urlString = "\(url.MainUrl)\(adds.information)?ids=\(id)&apiKey=\(apiKeySelect)"
        return try await networkManager.request(urlString: urlString)
    }
    // Для Search и Categories(просто вместо request подставить нужную нам категорию) 
    func fetchSearch(with request: String) async throws -> RecipeResults {
        let requestForURL = request.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(url.MainUrl)\(adds.complexSearch)?query=\(requestForURL)&number=10&apiKey=\(apiKeySelect)"
        return try await networkManager.request(urlString: urlString)
    }
}

// Вот пример получения данных для Trending

//var recipes: [Recipe] = []
//func loadRecipes()  {
//    Task {
//        do {
//            let response = try await RecipeAPI.fetchTrends()
//            recipes = response.results
//        } catch {
//            await MainActor.run(body: {
//                print(error, error.localizedDescription)
//            })
//        }
//    }
//}


// Модель для Trending, SeeAll и Search и Categories 
struct RecipeResults: Codable {
    let results: [Recipe]
}

struct Recipe: Codable, Equatable {
    let id: Int
    let title: String
    let image: String
}


import Foundation



// Модель для Detail

struct RecipeFullInfo: Codable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let spoonacularSourceUrl: String
    let instructions: String
    let extendedIngredients: [ExtendedIngredient]
}

struct ExtendedIngredient: Codable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
    let measures: Measures
    let image: String
}

struct Measures: Codable {
    let us, metric: Metric
}

struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}
