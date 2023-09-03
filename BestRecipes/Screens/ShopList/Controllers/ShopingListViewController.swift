//
//  ShopingListViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 31.08.2023.
//

import UIKit

class ShopingListViewController: UIViewController {

    private let customCellIdentifier = "CustomShopListCell"
    private var shoppingList = IngredientModel.makeMockData()
    
// MARK: - Data for tableView
    
    
// MARK: - User Interface
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel.makeLabel(font: .poppinsRegular(size: 48), textColor: .darkGray)
        textLabel.text = "ShopList"
        textLabel.textAlignment = .center
        textLabel.font = .poppinsSemiBold(size: 48)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .red.withAlphaComponent(0.5)
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Clear Shopping List", for: .normal)
        button.backgroundColor = UIColor(red: 0.89, green: 0.24, blue: 0.24, alpha: 1.00)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    @objc private func clearButtonTapped(_ selector: UIButton) {
        print("Clear Button tapped")

    }
    
    
    

}


// MARK: - Extension for setUp view constraints

extension ShopingListViewController {
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(textLabel)
        view.addSubview(tableView)
        view.addSubview(clearButton)

        // Регистрируем кастомную ячейку
        tableView.register(CustomShopListCell.self, forCellReuseIdentifier: customCellIdentifier)
    }
    
    
    private func setupConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            clearButton.heightAnchor.constraint(equalToConstant: 56),
            
            tableView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -20),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

// MARK: - Extensions for tableView

extension ShopingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Метод переиспользования ячейки с заданным идентификатором
        let cell = tableView.dequeueReusableCell(withIdentifier: customCellIdentifier, for: indexPath) as? CustomShopListCell
        
        // Передаем в ячейку данные из массива (заполняем все ячейки)
        let ingredient = shoppingList[indexPath.row]
        cell?.setDataIntocell(
            imageName: ingredient.image,
            name: ingredient.name,
            amount: ingredient.amount)
        
        // Нужно развернуть опционал
        return cell ?? CustomShopListCell()
    }
    
    
    
    
}

extension ShopingListViewController: UITableViewDelegate {
    
    // При свайпе справа будет кнопка "Удалить"
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { _, _, _ in
            
            // Удаляем ячейку из списка покупок
            self.shoppingList.remove(at: indexPath.row)
            
            // Удаление ячейки из таблицы надо обернуть в Updates()
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .left)  
            self.tableView.endUpdates()
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}


