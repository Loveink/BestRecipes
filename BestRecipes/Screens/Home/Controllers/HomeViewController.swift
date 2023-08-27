//
//  ViewController.swift
//  BestRecipes
//
//  Created by Александра Савчук on 26.08.2023.
//

import UIKit

class HomeViewController: UIViewController {

    let button = CustomRedButton(customTitle: "Next", cornerRadius: 8)
    let titleLabel = UILabel.makeLabel(text: "fsf:", font: .poppinsSemiBold(size: 58), textColor: .error100)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .success10

        view.addSubview(titleLabel)
        view.addSubview(button)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }
}
