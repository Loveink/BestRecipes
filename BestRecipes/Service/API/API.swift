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
  static let key2 = "5bcb58f5df0343c2b1670804076fee20"
  static let key3 = "929fcbb8f426404db8c5e1851818dfea"
  static let key4 = "3e206b1f2c3345ef948741b8ff3bbc4d"
  static let key5 = "0c2ed2c3dfb740bbb1ea235170e87c73"
  static let key6 = "bb8f3cb319be42178e0dd928aa576993"
  static let key7 = "a48b4a5a2d04465e907baec66822adf0"
  static let key8 = "bcebdf6dd5cf483d8246687cc3300687"
  static let key9 = "f6995d0a20a24616bb50c8250ab4353a"
}

  let apiKeySelect = apiKey.key8

    enum adds {
        static let popularity = "&sort=popularity"
        static let information = "informationBulk"
        static let number = "&number=50"
        static let complexSearch = "complexSearch"
        static let autocomplete = "autocomplete"
        
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

// Новый Пример запроса для Trending

//private func loadRecipes()  {
//    var recipes: [Recipe] = []
//    Task {
//        do {
//            let response = try await RecipeAPI.fetchTrends()
//            recipes = response.results
//            var recipesId: String = ""
//            for number in 0...(recipes.count - 1) {
//                recipesId += String(recipes[number].id) + ","
//                let secondResponce =  try await RecipeAPI.fetchFullInfoFromIdString(with: recipesId)
//                recipeFullInfo = secondResponce
//            }
//
//        } catch {
//            await MainActor.run(body: {
//                print(error, error.localizedDescription)
//            })
//        }
//    }
//}









