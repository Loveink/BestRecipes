
//
//  CreateRecipeViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class CreateRecipeViewController: UIViewController {

    private let navigationBar = CustomNavigationBar()
    private let collectionView = MyRecipeCollectionView()
    private let imagePicker = UIImagePickerController()

  private let imageEdit = UIImageView.init(image: UIImage(named: "Edit"))

  private var dishImageView: UIImageView = {
    let imageView = UIImageView()
      imageView.image = UIImage(named: "ProfilePictureEdit")
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.isUserInteractionEnabled = true
      imageView.layer.borderColor = UIColor.lightGray.cgColor
      imageView.layer.borderWidth = 2
      imageView.layer.cornerRadius = 20
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Recipe Name"
    textField.borderStyle = .roundedRect
    textField.layer.cornerRadius = 10
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.black.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()

  private let servingPicker = ServingPickerView()
  private let cookTimePicker = CookTimePickerView()
  private let ingredientsLabel = UILabel.makeLabelForCells(text: "Ingredients", font: .poppinsSemiBold(size: 20), textColor: .neutral100)
 
    private let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create recipe", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .poppinsSemiBold(size: 20)
        button.titleLabel?.textColor = .white
        return button
    }()
  
    
  override func viewDidLoad() {
    super.viewDidLoad()

    tabBarController?.tabBar.isHidden = true
    view.backgroundColor = .white
    setupNavBar()
    setupViews()
    setupConstraints()
    setupDishImageAction()
      
  }

  private func setupNavBar() {
      navigationBar.titleOfViewLabel.text = "Create recipe"
      navigationBar.titleOfViewLabel.font = .poppinsSemiBold(size: 24)
      navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
      addChild(navigationBar)
          view.addSubview(navigationBar.view)
      navigationBar.didMove(toParent: self)
  }
    
    private func setupDishImageAction() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        dishImageView.addGestureRecognizer(tapGesture)
    }
  
  private func setupViews() {

    view.addSubview(dishImageView)
      
    view.addSubview(nameTextField)
    view.addSubview(servingPicker)
    view.addSubview(cookTimePicker)
    view.addSubview(ingredientsLabel)

    view.addSubview(collectionView)
      dishImageView.addSubview(imageEdit)
      view.addSubview(createButton)


  }
  
  private func setupConstraints() {
    servingPicker.translatesAutoresizingMaskIntoConstraints = false
    cookTimePicker.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
      createButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([

        navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        navigationBar.view.heightAnchor.constraint(equalToConstant: 50),

        createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        createButton.heightAnchor.constraint(equalToConstant: 56),
        
      dishImageView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 10),
      dishImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      dishImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        dishImageView.heightAnchor.constraint(equalToConstant: 200),

      nameTextField.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 20),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        imageEdit.rightAnchor.constraint(equalTo: dishImageView.rightAnchor, constant:  -10),
        imageEdit.topAnchor.constraint(equalTo: dishImageView.topAnchor,constant: 10),
        
      servingPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
      servingPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      servingPicker.heightAnchor.constraint(equalToConstant: 50),
      servingPicker.widthAnchor.constraint(equalTo: dishImageView.widthAnchor),

      cookTimePicker.topAnchor.constraint(equalTo: servingPicker.bottomAnchor, constant: 10),
      cookTimePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cookTimePicker.heightAnchor.constraint(equalToConstant: 50),
      cookTimePicker.widthAnchor.constraint(equalTo: dishImageView.widthAnchor),

      ingredientsLabel.topAnchor.constraint(equalTo: cookTimePicker.bottomAnchor, constant: 10),
      ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      ingredientsLabel.heightAnchor.constraint(equalToConstant: 40),

        collectionView.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10),
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        collectionView.bottomAnchor.constraint(equalTo: createButton.topAnchor),
        collectionView.widthAnchor.constraint(equalTo: dishImageView.widthAnchor)

    ])
  }
    
    @objc func imageTapped() {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    
}

extension CreateRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            dishImageView.image = selectedImage
            
//            saveImageToCoreData(selectedImage)
            // Выбранное изображение доступно в переменной selectedImage
            // Выполните здесь нужные действия с изображением, например, сохраните его или отобразите в вашем интерфейсе
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
//    func saveImageToCoreData(_ image:UIImage) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                    return
//                }
//                context = appDelegate.persistentContainer.viewContext
//
//                // Сохранение изображения
//
//                    if let imageData = image.pngData() {
//                        let recipe = RecepiS(context: context)
//                        recipe.imageRecipe = imageData
//
//                        do {
//                            try context.save()
//                            print("Изображение успешно сохранено")
//                        } catch {
//                            print("Ошибка при сохранении: \(error)")
//                        }
//                    }
//
//            }
   
//    func getImageFromCoreData() {
//
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                   return
//               }
//               context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest: NSFetchRequest<RecepiS> = RecepiS.fetchRequest()
//
//                do {
//                    savedRecipes = try context.fetch(fetchRequest)
//                    print("Количество сохраненных рецептов: \(savedRecipes.count)")
//
//                    for recipe in savedRecipes {
//                        if let image = recipe.imageRecipe as? Data {
//                            if let uiImage = UIImage(data: image) {
//                                imageView.image = uiImage
//                                break
//                            }
//                        }
//                    }
//                } catch {
//                    print("Ошибка при выполнении запроса: \(error)")
//                }
//            }
        
}
