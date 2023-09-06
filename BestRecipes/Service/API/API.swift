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

let apiKey = [
"f41a6796b57a45b7868f512abf929d51",
"a29eb5640b5c4435ad8ec2ef72759fe5",
"a63ec13f2c7a473f9a9ec94e8d190e5c",
"ce1dcc3c21614ac29f4f314e25f37a4f",
"cbab9c65a56b431b843893b723acaa5d",
"3edc89e90aad46d8a1806b89c284c359",
"f23bfe6f20de46ef81114161e0e58ae6",
"466a1187dd1a443d8e67d4da587ca850",
"6b6b22ed8efc4cc18506fc60b5a9cd26",
"d67869c008124d30a5e11bf6c47629ac",
"8d8d1a32e9ad404c9614e941e7331c7e",
"20f7932dd958459aa0248ce528676f83",
"1d336be93da74382b0e6941d9926844c",
"711999a664534dc6a911633b77b822c8",
"9b1b942676e44183b4f451ba87c92b05",
"c868165944ce4ec4bf8c418c19c08a98",
"7864898b65f744ddb4ad15365abf6bb0",
"28d850d79fc449fd9cec3c8c9f821ddf",
"8b9dd504b42a4eb2814b07ca7cb25ed9",
"64c38bd8049146abbc70c6b574783117",
"75e325b8a6044f59bf08dcb57b15db74"
]

var apiKeySelect = apiKey[0]

    enum adds {
        static let popularity = "&sort=popularity"
        static let information = "informationBulk"
        static let number = "&number=50"
        static let complexSearch = "complexSearch"
        static let autocomplete = "autocomplete"
        static let instructions = "analyzedInstructions"
        
    }

struct RecipeAPI {
    
    //MARK: - Загрузка изображений

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
    
    
//MARK: - Запросы данных
    
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
    static func fetchSearch(with request: String) async throws -> RecipeResults {
        let requestForURL = request.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(url.MainUrl)\(adds.complexSearch)?query=\(requestForURL)&number=10&apiKey=\(apiKeySelect)"
        return try await networkManager.request(urlString: urlString)
    }
    // Получение данных для нескольких ids: String
    static func fetchFullInfoFromIdString(with ids: String) async throws -> [RecipeInfoForCell] {
        let urlString = "\(url.MainUrl)\(adds.information)?ids=\(ids)&apiKey=\(apiKeySelect)"
        return try await networkManager.request(urlString: urlString)
    }

  static func fetchCuisine(with request: String) async throws -> RecipeResults {
      let urlString = "\(url.MainUrl)\(adds.complexSearch)?cuisine=\(request)&number=10&apiKey=\(apiKeySelect)"
      return try await networkManager.request(urlString: urlString)
  }

  static func fetchInstructions(with ids: String) async throws -> RecipeResults {
      let urlString = "\(url.MainUrl)\(ids)\(adds.instructions)apiKey=\(apiKeySelect)"
      return try await networkManager.request(urlString: urlString)
  }
}
