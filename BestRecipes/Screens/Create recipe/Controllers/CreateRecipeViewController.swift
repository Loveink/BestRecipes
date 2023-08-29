//
//  CreateRecipeViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class CreateRecipeViewController: UIViewController {
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Create recipe"
    label.font = .poppinsSemiBold(size: 24)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
    setupConstraints()
  }
  
  private func setupViews() {
    view.addSubview(titleLabel)
    view.addSubview(dishImageView)
    view.addSubview(nameTextField)
    view.addSubview(servingPicker)
    view.addSubview(cookTimePicker)
  }
  
  private func setupConstraints() {
    servingPicker.translatesAutoresizingMaskIntoConstraints = false
    cookTimePicker.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      
      dishImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      dishImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      dishImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      nameTextField.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 20),
      nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      
      servingPicker.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
      servingPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      servingPicker.heightAnchor.constraint(equalToConstant: 60),
      servingPicker.widthAnchor.constraint(equalTo: dishImageView.widthAnchor),
      
      cookTimePicker.topAnchor.constraint(equalTo: servingPicker.bottomAnchor, constant: 20),
      cookTimePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cookTimePicker.heightAnchor.constraint(equalToConstant: 60),
      cookTimePicker.widthAnchor.constraint(equalTo: dishImageView.widthAnchor)
    ])
  }
}
