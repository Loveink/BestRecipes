//
//  MyRecipeCollectionCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class MyRecipeCollectionCell: UICollectionViewCell {
  
  var delegate: MyRecipeCollectionCellDelegate?
  var indexPath: IndexPath?
  
  let textField1: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Item name"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 8
    textField.layer.borderColor = UIColor.gray.cgColor
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    
    return textField
  }()
  
  let textField2: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Quantity"
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.layer.borderWidth = 1.0
    textField.layer.cornerRadius = 8
    textField.layer.borderColor = UIColor.gray.cgColor
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    
    return textField
  }()
  
  let selectButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "plus"), for: .selected)
    button.setImage(UIImage(systemName: "minus"), for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    
    textField1.addTarget(self, action: #selector(textField1DidChange(_:)), for: .editingChanged)
    textField2.addTarget(self, action: #selector(textField2DidChange(_:)), for: .editingChanged)
    selectButton.addTarget(self, action: #selector(selectButtonTapped(_:)), for: .touchUpInside)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    addSubview(textField1)
    addSubview(textField2)
    addSubview(selectButton)
    
    NSLayoutConstraint.activate([
      textField1.topAnchor.constraint(equalTo: topAnchor),
      textField1.leadingAnchor.constraint(equalTo: leadingAnchor),
      textField1.widthAnchor.constraint(equalToConstant: 200),
      textField1.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      textField2.topAnchor.constraint(equalTo: topAnchor),
      textField2.leadingAnchor.constraint(equalTo: textField1.trailingAnchor, constant: 20),
      textField2.widthAnchor.constraint(equalToConstant: 100),
      textField2.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      selectButton.topAnchor.constraint(equalTo: topAnchor),
      selectButton.leadingAnchor.constraint(equalTo: textField2.trailingAnchor, constant: 10),
      selectButton.trailingAnchor.constraint(equalTo: trailingAnchor),
      selectButton.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  @objc private func selectButtonTapped(_ sender: UIButton) {
    delegate?.selectButtonTapped(at: indexPath!)
  }
  
  @objc private func textField1DidChange(_ textField: UITextField) {
    delegate?.textField1DidChange(at: indexPath!, newValue: textField.text ?? "")
  }
  
  @objc private func textField2DidChange(_ textField: UITextField) {
    delegate?.textField2DidChange(at: indexPath!, newValue: textField.text ?? "")
  }
}
