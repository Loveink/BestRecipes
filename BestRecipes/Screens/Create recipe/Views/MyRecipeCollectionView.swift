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

//protocol MyRecipeCollectionViewDelegate: AnyObject {
//    func buttonIsEnable(_ IsEnable1: Bool, _ IsEnable2: Bool)
//
//}

class MyRecipeCollectionView: UIView {
  
//    var delegate: MyRecipeCollectionViewDelegate?
    
    var isButtonEnable1 = false
    var isButtonEnable2 = false


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
      cell.collectionDelegate = self
//      cell.textFielDelegate = self
//      delegate?.buttonIsEnable(false, false)

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
      let blancDataRow = RowData(textField1Text: "", textField2Text: "", isSelected: false, isField1: false, isField2: false)
      rowDataArray.insert(blancDataRow, at: selectedRow + 1)
    }
    collectionView.reloadData()
      print(rowDataArray)
      print(indexPath.row)

  }
  
  func textField1DidChange(at indexPath: IndexPath, newValue: String) {
      if (0...rowDataArray.count).contains(indexPath.row) {
          rowDataArray[indexPath.row].textField1Text = newValue
          
          if !newValue.isEmpty {
              rowDataArray[indexPath.row].isField1 = true
          } else {
              rowDataArray[indexPath.row].isField1 = false
          }
          
          print(rowDataArray)

//          delegate?.buttonIsEnable(isButtonEnable1, isButtonEnable2)

      }
  
  }
  
  func textField2DidChange(at indexPath: IndexPath, newValue: String) {
      if (0...rowDataArray.count).contains(indexPath.row) {
    rowDataArray[indexPath.row].textField2Text = newValue
          
          if !newValue.isEmpty {
              rowDataArray[indexPath.row].isField2 = true
          } else {
              rowDataArray[indexPath.row].isField2 = false
          }
          
          
          
//          delegate?.buttonIsEnable(isButtonEnable1, isButtonEnable2)
      }
  }
}

//extension MyRecipeCollectionView: MyTextFieldCellDelegate {
//
//        func textField1IsEmpty(_ isEmpty: Bool) {
//             isButtonEnable1 = !isEmpty
//
//        }
//
//        func textField2IsEmpty(_ isEmpty: Bool) {
//             isButtonEnable2 = !isEmpty
//        }
//    }
