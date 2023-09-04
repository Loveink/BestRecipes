//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Тимур on 28.08.2023.
//

import UIKit

class RecipeDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var ingridients = ["Тартилия", "Лук", "Помидор", "Огурцы", "Курица"]
    
    let navigationBar = CustomNavigationBar()
    
    //MARK: - UI elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let cartButton: UIButton = {
        let cartButton = UIButton()
        cartButton.setTitle("Add to cart", for: .normal)
        cartButton.backgroundColor = .red
        cartButton.layer.cornerRadius = 15
        cartButton.titleLabel?.font = .poppinsSemiBold(size: 20)
        cartButton.titleLabel?.textColor = .white
        cartButton.isEnabled = true
        return cartButton
    }()
    
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
        textLabel.font = .poppinsRegular(size: 18)
        return textLabel
    }()
    
    private lazy var imageFood: UIImageView = {
        let imageFood = UIImageView()
        imageFood.image = UIImage(named: "image")
        imageFood.contentMode = .scaleAspectFit
        
        return imageFood
    }()
    
    private lazy var likeLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.text = "150 Likes"
        likeLabel.textAlignment = .left
        likeLabel.font = .poppinsRegular(size: 12)
        return likeLabel
    }()
    
    private lazy var instructionLabel: UILabel = {
        let instructionLabel = UILabel()
        instructionLabel.text = "Instruction"
        instructionLabel.textAlignment = .left
        instructionLabel.font = .poppinsSemiBold(size: 16)
        return instructionLabel
    }()
    
    private lazy var recipeLabel: UILabel = {
        let recipeLabel = UILabel()
        recipeLabel.text = "Подготовь ингредиенты: 1. Маринованное мясо (курица, говядина или баранина) - нарежь его тонкими полосками и предварительно промаринуй с специями. 2. Овощи (помидоры, огурцы, лук, зелень) - нарежь их полосками или кубиками."
        recipeLabel.font = .poppinsRegular(size: 14)
        recipeLabel.numberOfLines = 0
        return recipeLabel
    }()
    
    private lazy var ingridentsLabel: UILabel = {
        let ingridentsLabel = UILabel()
        ingridentsLabel.text = "ingridents"
        ingridentsLabel.font = .poppinsSemiBold(size: 16)
        return ingridentsLabel
    } ()
    
    private lazy var itemLabel: UILabel = {
        let itemLabel = UILabel()
        itemLabel.text = "5 items"
        itemLabel.font = .poppinsRegular(size: 16)
        itemLabel.textAlignment = .right
        
        return itemLabel
    } ()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCellRecipe.self, forCellReuseIdentifier: "CustomCellRecipe")
        tableView.separatorStyle = .none
        setupNavBar()
        subview()
        setupConstraints()
        cartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)
        
    }
    
    
    //MARK: - Button
    @objc func cartButtonPressed() {
        print("chartButton pressed")
    }
    
    //MARK: - Add subview func
    
    private func subview() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        //        view.addSubview(stackView)
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(imageFood)
        stackView.addArrangedSubview(likeLabel)
        stackView.addArrangedSubview(instructionLabel)
        stackView.addArrangedSubview(ingridentsLabel)
        stackView.addArrangedSubview(recipeLabel)
        stackView.addArrangedSubview(horizontalStackView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(cartButton)
        
        
    }
    
    // MARK: -  Constrains
    func setupConstraints() {
        NSLayoutConstraint.activate([
            navigationBar.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.view.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: navigationBar.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32), // Ограничение для ширины stackView
            
            tableView.heightAnchor.constraint(equalToConstant: 300),
            
            
        ])
    }
    
    //MARK: - NavigationBar
    private func setupNavBar() {
        navigationBar.titleOfViewLabel.text = ""
        navigationBar.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(navigationBar)
        view.addSubview(navigationBar.view)
        navigationBar.didMove(toParent: self)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCellRecipe
        cell.toggleCheckmark()
    }
    
}

