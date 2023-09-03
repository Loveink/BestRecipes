//
//  ImageSelectionViewController.swift
//  BestRecipes
//
//  Created by Vanopr on 30.08.2023.
//



// "82c2d8b368364b64ba37c4f11aa55670", //Vanopr Keys
// "c0472158d42f45c9b91c7244460c36e1",
// "cb0a8f037cba4750bd8706d4473228d6"

import UIKit

class ProfilePageViewController: UIViewController, ImageSelectionDelegate {
    
    var myRecipes = GetFromCoreData.getRecipeMyRecipeModelsFromCoreData()
    var myIngridients = GetFromCoreData.fetchArrayOfArraysFromCoreData()
    private var mainLabel = UILabel.makeLabelForCells(text: "My Profile", font: .poppinsSemiBold(size: 35), textColor: .black)
    private let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), collectionViewLayout: UICollectionViewFlowLayout())
      var imageProfileView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 20
        imageView.image = imageProfileViewSaved
        return imageView
    }()
    private var myRecipeLabel = UILabel.makeLabelForCells(text: "My recipes", font: .poppinsSemiBold(size: 28), textColor: .black)
    private let imageChoice = ImageSelectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMainLabel()
        setupImageView()
        setupMyRecipeLabel()
        setupCollectionView()
        addConstrains()
    }
    
    private func setupImageView() {
        imageProfileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageProfileView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageProfileView.addGestureRecognizer(tapGesture)
    }
    
    private func setupMainLabel() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLabel)
    }
    
    private func setupMyRecipeLabel() {
        myRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myRecipeLabel)
    }
    
    private func setupCollectionView() {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MyRecipeCell.self, forCellWithReuseIdentifier: "MyRecipeCell")
            collectionView.backgroundColor = .white

            view.addSubview(collectionView)
    }
    
    @objc private func imageTapped() {
        let imageSelectionVC = ImageSelectionViewController()
        imageSelectionVC.delegate = self
        present(imageSelectionVC, animated: true, completion: nil)    }
    
  private func addConstrains() {
      NSLayoutConstraint.activate([
        mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        mainLabel.heightAnchor.constraint(equalToConstant: 50),

        imageProfileView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
        imageProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
        imageProfileView.heightAnchor.constraint(equalToConstant: 100),
        imageProfileView.widthAnchor.constraint(equalToConstant: 100),
        
        myRecipeLabel.topAnchor.constraint(equalTo: imageProfileView.bottomAnchor, constant: 20),
        myRecipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        myRecipeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        myRecipeLabel.heightAnchor.constraint(equalToConstant: 50),
        
        collectionView.topAnchor.constraint(equalTo: myRecipeLabel.bottomAnchor, constant: 20),
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
    }
        func didUpdateProfileImage(_ image: UIImage) {
            imageProfileView.image = image
        }
}

extension ProfilePageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 200) // Размеры карточки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2 // Промежуток между карточками
    }
}

extension ProfilePageViewController:  UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecipeCell", for: indexPath) as! MyRecipeCell
        let myRecipe = myRecipes[indexPath.row]
        if let imageData = myRecipe.recipeImage {
            cell.dishImageView.image = UIImage(data: imageData)
        }
        let howManyIngridients = myIngridients[indexPath.row].count
        cell.minuteLabel.text = "\(howManyIngridients) ingredients" + " | " + myRecipe.cookTime!
        cell.titleLabel.text  = myRecipe.recipeName
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
}

