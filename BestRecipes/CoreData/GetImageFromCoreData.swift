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

private func getImageFromCoreData() -> UIImage {
let imageProfileModels: [PicturePofileModel]
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return UIImage(named: "ProfilePicture2")!
           }
           context = appDelegate.persistentContainer.viewContext

    let fetchRequest: NSFetchRequest<PicturePofileModel> = PicturePofileModel.fetchRequest()

            do {
                imageProfileModels = try context.fetch(fetchRequest)

                let imageProfileModel = imageProfileModels.last
                if let image = imageProfileModel?.imageProfile  {
                        if let uiImage = UIImage(data: image) {
                            saveJustLastImage(imageProfileModels)
                            print("Количество сохраненных изображений: \(imageProfileModels.count)")
                          return uiImage
                        }
                    }
                
            } catch {
                print("Ошибка при выполнении запроса: \(error)")
            }
    return UIImage(named: "ProfilePicture2")!
        }



private func saveJustLastImage(_ imageProfileModels: [PicturePofileModel]) {
    do {
        if imageProfileModels.count > 1 {
            // Удаляем все записи, кроме последней
            for i in 0..<imageProfileModels.count  {
                context.delete(imageProfileModels[i])
            }
            
            // Сохраняем изменения после удаления
            try context.save()
        }
    }catch {
        print("Ошибка при извлечении данных: \(error)")
    }
}

