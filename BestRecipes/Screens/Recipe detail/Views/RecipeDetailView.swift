//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Тимур on 28.08.2023.
//

import UIKit

class RecipeDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var ingridients = ["Тартилия", "Лук", "Помидор", "Огурцы", "Курица"]
    var recipe: Recipe?
    var recipeFromSeeAll: RecipeInfoForCell?
    let navigationBar = CustomNavigationBar()
    var recipeDetail: [RecipeFullInfo]?
   
    var image: UIImage?
    
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
        imageFood.layer.cornerRadius = 20
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

        getRecipeDetail()
        setupNavBar()
        subview()
        setupConstraints()
        cartButton.addTarget(self, action: #selector(cartButtonPressed), for: .touchUpInside)

        
        
    }
    //MARK: - Gettin Details
    private func getRecipeDetail() {
        if let id = recipe?.id   {
            loadRecipes(with: id)
        }
        if let id =  recipeFromSeeAll?.id  {
            loadRecipes(with: id)
        }
    }
    
    private func loadRecipes(with id: Int)  {
        Task {
            do {
                let response = try await RecipeAPI.fetchFullInfo(id)
                recipeDetail = response
                getImage(recipeDetail?[0].image ?? "" ,at: imageFood)
                setupDetails()
                self.tableView.reloadData()


            } catch {
                await MainActor.run(body: {
                    print(error, error.localizedDescription)
                })
            }
        }
    }
    
    private func getImage(_ image: String,at imageView: UIImageView) {
        if let imageURL = URL(string: image) {
            RecipeAPI.loadImageFromURL(urlString: imageURL.absoluteString) { image in
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }
    
    private func setupDetails() {
        textLabel.text = recipeDetail?[0].title
        recipeLabel.text = recipeDetail?[0].instructions.htmlToString
        likeLabel.text = "👍" + " " + "\(recipeDetail?[0].aggregateLikes ?? 0 )"
        itemLabel.text = "\(recipeDetail?[0].extendedIngredients.count ?? 0) items"

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
  
        return recipeDetail?[0].extendedIngredients.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellRecipe", for: indexPath) as! CustomCellRecipe
        let recipeIngridients = recipeDetail?[0].extendedIngredients[indexPath.row]
   
        let imageString = "https://spoonacular.com/cdn/ingredients_100x100/\(recipeIngridients?.image ?? "")"
        cell.titleLbl.text = recipeIngridients?.name
        cell.descriptionLbl.text = "\(recipeIngridients?.measures.metric.amount ?? 0)" + " " + "g"
        DispatchQueue.main.async {
            self.getImage(imageString, at: cell.dishImageView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCellRecipe
        cell.toggleCheckmark()
    }
}

