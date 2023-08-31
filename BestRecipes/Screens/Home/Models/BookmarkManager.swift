//
//  BookmarkManager.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import Foundation

final class BookmarksManager {

    static let shared = BookmarksManager()
    private init() {}

    private let defaults = UserDefaults.standard
    private let bookmarksKey = "bookmarks"

    var bookmarksArray: [RecipeInfoForCell] {
        get {
            guard let data = defaults.data(forKey: bookmarksKey) else {
                return []
            }
            do {
                let savedBookmarks = try JSONDecoder().decode([RecipeInfoForCell].self, from: data)
                return savedBookmarks
            } catch {
                print("Error decoding bookmarks: \(error)")
                return []
            }
        }
        set {
            do {
                let savedBookmarks = try JSONEncoder().encode(newValue)
                defaults.set(savedBookmarks, forKey: bookmarksKey)
            } catch {
                print("Error encoding bookmarks: \(error)")
            }
        }
    }

    //MARK: - Functions
    func getBookmarks() -> [RecipeInfoForCell] {
        return bookmarksArray
    }

    func saveBookmarks(_ dataToSave: [RecipeInfoForCell]) {
        do {
            let savedNews = try JSONEncoder().encode(dataToSave)
            defaults.set(savedNews, forKey: "bookmarks")
            defaults.synchronize()
        } catch {
            print("Error encoding results: \(error)")
        }
    }
}

