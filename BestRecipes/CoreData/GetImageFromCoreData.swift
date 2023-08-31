//
//  GetImageFromCoreData.swift
//  BestRecipes
//
//  Created by Vanopr on 30.08.2023.
//

import Foundation
import UIKit
import CoreData


private  var context: NSManagedObjectContext!
var imageProfileViewSaved = getImageFromCoreData()

func getImageFromCoreData() -> UIImage {
let images: [Picture]
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return UIImage(named: "ProfilePicture2")!
           }
           context = appDelegate.persistentContainer.viewContext

    let fetchRequest: NSFetchRequest<Picture> = Picture.fetchRequest()

            do {
                images = try context.fetch(fetchRequest)
                print("Количество сохраненных рецептов: \(images.count)")

                let images = images.last
                if let image = images?.imageProfile  {
                        if let uiImage = UIImage(data: image) {
                          return uiImage
                        }
                    }
                
            } catch {
                print("Ошибка при выполнении запроса: \(error)")
            }
    return UIImage(named: "ProfilePicture2")!
        }
