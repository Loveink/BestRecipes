//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Тимур on 28.08.2023.
//

import UIKit

class RecipeDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ingridients = ["Тартилия", "Лук", "Помидор", "Огурцы", "Курица", "Сыр","Цветная капуста", "Соус", "МАслины"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        subview()
        setupConstraints()
        tableView.register(CustomCellRecipe.self, forCellReuseIdentifier: "CustomCell")
    }
    
    
    
    //MARK: - Add subview func
    
    private func subview() {
        view.addSubview(stackView)
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(imageFood)
        stackView.addArrangedSubview(recipeLabel)
        stackView.addArrangedSubview(tableView)
        
        
    }
    
    //MARK: - UI elements
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        //        stackView.backgroundColor = .red
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Шаурма"
        textLabel.textAlignment = .natural
        textLabel.font = .systemFont(ofSize: 24)
        return textLabel
    }()
    
    private lazy var imageFood: UIImageView = {
        let imageFood = UIImageView()
        //        imageFood.backgroundColor = .green
        imageFood.image = UIImage(named: "image")
        imageFood.contentMode = .scaleAspectFit
        imageFood.heightAnchor.constraint(equalToConstant: 206).isActive = true
        return imageFood
    }()
    
    private lazy var recipeLabel: UILabel = {
        let recipeLabel = UILabel()
        //        recipeLabel.backgroundColor = .blue
        recipeLabel.text = " Подготовь ингредиенты: 1. Маринованное мясо (курица, говядина или баранина) - нарежь его тонкими полосками и предварительно промаринуй с специями. 2. Овощи (помидоры, огурцы, лук, зелень) - нарежь их полосками или кубиками.3. Соусы (майонез, кетчуп, чесночный соус) - приготовь заранее."
        recipeLabel.font = .systemFont(ofSize: 17)
        recipeLabel.numberOfLines = 0
        return recipeLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.sectionHeaderHeight = 20
        tableView.separatorStyle = .singleLine
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
        return ingridients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCellRecipe
        
        // Настройте данные вашей кастомной ячейки
        cell.roundImageView.image = UIImage(named: "yourImageName")
        cell.leftTextLabel.text = "Left Text"
        cell.rightTextLabel.text = "Right Text"
        
        return cell
    }
}
