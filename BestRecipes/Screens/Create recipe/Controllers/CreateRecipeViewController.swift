//
//  CreateRecipeViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class CreateRecipeViewController: UIViewController {

  let navigationBar = CustomNavigationBar()
  let collectionView = MyRecipeCollectionView()

  private let dishImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "image")
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
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
  var ingredientsLabel = UILabel.makeLabelForCells(text: "Ingredients", font: .poppinsSemiBold(size: 20), textColor: .neutral100)

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupNavBar()
    setupViews()
    setupConstraints()
  }

  private func setupNavBar() {
      navigationBar.titleOfViewLabel.text = "Create recipe"
      navigationBar.titleOfViewLabel.font = .poppinsSemiBold(size: 24)
      navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
      addChild(navigationBar)
      view.addSubview(navigationBar.view)
      navigationBar.didMove(toParent: self)
  }
  
  private func setupViews() {

    view.addSubview(dishImageView)
    view.addSubview(nameTextField)
    view.addSubview(servingPicker)
    view.addSubview(cookTimePicker)
    view.addSubview(ingredientsLabel)
    view.addSubview(collectionView)
  }
  
  private func setupConstraints() {
    servingPicker.translatesAutoresizingMaskIntoConstraints = false
    cookTimePicker.translatesAutoresizingMaskIntoConstraints = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([

      navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -40),
      navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      navigationBar.view.heightAnchor.constraint(equalToConstant: 50),

      dishImageView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor, constant: 10),
      dishImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      dishImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      nameTextField.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 20),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
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
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      collectionView.widthAnchor.constraint(equalTo: dishImageView.widthAnchor)
    ])
  }
}
