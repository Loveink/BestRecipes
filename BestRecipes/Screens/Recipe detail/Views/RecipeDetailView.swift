//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Тимур on 28.08.2023.
//

import UIKit

class RecipeDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ingridients = ["Тартилия", "Лук", "Помидор", "Огурцы", "Курица"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        subview()
        setupConstraints()
        tableView.register(CustomCellRecipe.self, forCellReuseIdentifier: "CustomCellRecipe")
        tableView.separatorStyle = .none
    }
    
    
    
    //MARK: - Add subview func
    
    private func subview() {
        view.addSubview(stackView)
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(imageFood)
        stackView.addArrangedSubview(recipeLabel)
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(tableView)
        
        
    }
    
    //MARK: - UI elements
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.addArrangedSubview(ingridentsLabel)
        horizontalStackView.addArrangedSubview(itemLabel)
        return horizontalStackView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Шаурма"
        textLabel.textAlignment = .center
        textLabel.font = .poppinsRegular(size: 24)
        return textLabel
    }()
    
    private lazy var imageFood: UIImageView = {
        let imageFood = UIImageView()
        imageFood.image = UIImage(named: "image")
        imageFood.contentMode = .scaleAspectFit
//        imageFood.heightAnchor.constraint(equalToConstant: 206).isActive = true
        imageFood.isUserInteractionEnabled = true
        return imageFood
    }()
    

    
    private lazy var recipeLabel: UILabel = {
        let recipeLabel = UILabel()
        recipeLabel.text = "Подготовь ингредиенты: 1. Маринованное мясо (курица, говядина или баранина) - нарежь его тонкими полосками и предварительно промаринуй с специями. 2. Овощи (помидоры, огурцы, лук, зелень) - нарежь их полосками или кубиками.."
        recipeLabel.font = .poppinsRegular(size: 17)
        recipeLabel.numberOfLines = 0
        return recipeLabel
    }()
    
    private lazy var ingridentsLabel: UILabel = {
        let ingridentsLabel = UILabel()
        ingridentsLabel.text = "ingridents"
        ingridentsLabel.font = .poppinsRegular(size: 15)
        return ingridentsLabel
    } ()
    
    private lazy var itemLabel: UILabel = {
        let itemLabel = UILabel()
        itemLabel.text = "5 items"
        itemLabel.font = .poppinsRegular(size: 15)
        
        return itemLabel
    } ()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    // MARK: -  Constrains
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2),
            
            imageFood.widthAnchor.constraint(equalToConstant: 343),
            imageFood.heightAnchor.constraint(equalToConstant: 206),
            
            tableView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellRecipe", for: indexPath) as! CustomCellRecipe
        
        // Настройте данные вашей кастомной ячейки
        cell.dishImageView.image = UIImage(named: "image")
        cell.titleLbl.text = "Left Text"
        cell.descriptionLbl.text = "Right text"
        
        return cell
    }
    
// MARK: - DELETE ME
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ShopingListViewController()
        present(destinationVC, animated: true) // Показываем модально

    
    }
}

