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
  static let key2 = "b4768be03cc34eecac9ddff5b5ec4f66"
  static let key3 = "82c2d8b368364b64ba37c4f11aa55670"
  static let key4 = "512b181445c643b29ffeab3ae46f3406"
  static let key5 = "89470a21c8094205b62fa9d6f4fb7f75"
  static let key6 = "06c6e6e34b5544f6a263f6825fa40fae"
  static let key7 = "060fe2f88f7b4f9e9f5b21d90955989e"
  static let key8 = "21e9db51c06e4d61bbd59d9ec120a3b7"
  static let key9 = "ff6ba20005be4117a24fb55aa129b010"
}

    let apiKeySelect = apiKey.key3

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









