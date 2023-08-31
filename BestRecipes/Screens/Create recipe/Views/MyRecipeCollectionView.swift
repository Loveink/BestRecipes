//
//  MyRecipeCollectionView.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

var rowDataArray: [RowData] = []


protocol MyRecipeCollectionCellDelegate: AnyObject {
  func selectButtonTapped(at indexPath: IndexPath)
  func textField1DidChange(at indexPath: IndexPath, newValue: String)
  func textField2DidChange(at indexPath: IndexPath, newValue: String)
}

class MyRecipeCollectionView: UIView {
  
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }
  
  private func setupUI() {
    backgroundColor = .white
    setupCollectionView()
    generateInitialData()
  }
  
  private func generateInitialData() {
    rowDataArray = [
      RowData(textField1Text: "", textField2Text: "", isSelected: true)
    ]
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MyRecipeCollectionCell.self, forCellWithReuseIdentifier: "MyRecipeCollectionCell")
    addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

extension MyRecipeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return rowDataArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCollectionCell", for: indexPath) as! MyRecipeCollectionCell
    
    let rowData = rowDataArray[indexPath.row]
    
    cell.textField1.text = rowData.textField1Text
    cell.textField2.text = rowData.textField2Text
    cell.selectButton.isSelected = rowData.isSelected
    
    cell.selectButton.tag = indexPath.row
    cell.indexPath = indexPath
    cell.delegate = self
    
    return cell
  }
}

extension MyRecipeCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 40)
  }
}

extension MyRecipeCollectionView: MyRecipeCollectionCellDelegate {
  func selectButtonTapped(at indexPath: IndexPath) {
    let selectedRow = indexPath.row
    let rowData = rowDataArray[selectedRow]
    
    if !rowData.isSelected {
      if let indexToRemove = rowDataArray.firstIndex(of: rowData) {
        rowDataArray.remove(at: indexToRemove)
      }
    } else {
      let blancDataRow = RowData(textField1Text: "", textField2Text: "", isSelected: false)
      rowDataArray.insert(blancDataRow, at: selectedRow + 1)
    }
    collectionView.reloadData()
      print(rowDataArray)
      print(indexPath.row)

  }
  
  func textField1DidChange(at indexPath: IndexPath, newValue: String) {
      if (0...rowDataArray.count).contains(indexPath.row) {
          rowDataArray[indexPath.row].textField1Text = newValue
          print(rowDataArray)
      }
  
  }
  
  func textField2DidChange(at indexPath: IndexPath, newValue: String) {
      if (0...rowDataArray.count).contains(indexPath.row) {
    rowDataArray[indexPath.row].textField2Text = newValue
          print(rowDataArray)
      }
  }
}
