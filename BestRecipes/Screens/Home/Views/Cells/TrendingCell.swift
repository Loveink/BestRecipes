//
//  TrendingCell.swift
//  BestRecipes
//
//  Created by Александра Савчук on 27.08.2023.
//

import UIKit
import Kingfisher

class TrendingCell: UICollectionViewCell {

  var liked: Bool = false
  var currentRecipe: RecipeInfoForCell?

  static let identifier = "TrendingCell"
  let bookmarksManager = BookmarksManager.shared


  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Outlets
  private let dishImageView: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "image")
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 20
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private let titleLabel = UILabel.makeLabelForCells(text: "How to make sharwama at home", font: .poppinsSemiBold(size: 16), textColor: .black)

  private let authorImageView: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "Creator")
    image.contentMode = .scaleAspectFill
    image.layer.cornerRadius = 8
    image.clipsToBounds = true
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private let authorLabel = UILabel.makeLabelForCells(text: "By Zeelicious foods", font: .poppinsRegular(size: 12), textColor: .black)

  private let minuteLabel = UILabel.makeLabelForCells(text: "15 min", font: .poppinsRegular(size: 12), textColor: .white)

  lazy var minuteView: UIView = {
      let view = UIView()
      view.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 0.3)
      view.layer.cornerRadius = 8
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()

  private let likesLabel = UILabel.makeLabelForCells(text: "23 likes", font: .poppinsRegular(size: 12), textColor: .white)

  lazy var likesView: UIView = {
      let view = UIView()
      view.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 0.3)
      view.layer.cornerRadius = 8
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()

  lazy var whiteCircleView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      view.layer.cornerRadius = 17
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()

  lazy var favouriteButton: UIButton = {
      let button = UIButton()
      button.setImage(UIImage(named: "bookmark"), for: .normal)
      button.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
      button.translatesAutoresizingMaskIntoConstraints = false
      return button
  }()

  //MARK: - Functions
  @objc func favouriteButtonPressed() {
    if liked {
      favouriteButton.setImage(UIImage(named: "bookmark"), for: .normal)
      liked = false
      bookmarksManager.bookmarksArray.removeAll { $0 == currentRecipe }
    } else {
      favouriteButton.setImage(UIImage(named: "bookmarkSelect"), for: .normal)
      liked = true
      bookmarksManager.bookmarksArray.append(currentRecipe!)
    }
  }

  let options: KingfisherOptionsInfo = [
    .cacheOriginalImage
  ]

  let thumbsUpEmoji = "👍"

  public func configureCell(_ data: RecipeInfoForCell) {
    DispatchQueue.main.async {
      self.titleLabel.text = data.title
      self.dishImageView.kf.setImage(with: URL(string: data.image), options: self.options)
      self.authorLabel.text = data.sourceName
      self.likesLabel.text = self.thumbsUpEmoji + " " + String(data.aggregateLikes)
      self.minuteLabel.text = String(data.readyInMinutes) + " " + "min"
      self.currentRecipe = data
    }
  }

  private func setupViews() {
    contentView.addSubview(dishImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(authorImageView)
    contentView.addSubview(authorLabel)

    whiteCircleView.addSubview(favouriteButton)
    contentView.addSubview(whiteCircleView)

    minuteView.addSubview(minuteLabel)
    contentView.addSubview(minuteView)

    likesView.addSubview(likesLabel)
    contentView.addSubview(likesView)
  }

  //MARK: - Constraints
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      dishImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      dishImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      dishImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      dishImageView.heightAnchor.constraint(equalToConstant: 150),

      whiteCircleView.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 8),
      whiteCircleView.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor,constant: -9),
      whiteCircleView.widthAnchor.constraint(equalToConstant: 32),
      whiteCircleView.heightAnchor.constraint(equalToConstant: 32),

      favouriteButton.centerXAnchor.constraint(equalTo: whiteCircleView.centerXAnchor),
      favouriteButton.centerYAnchor.constraint(equalTo: whiteCircleView.centerYAnchor),
      favouriteButton.widthAnchor.constraint(equalToConstant: 32),
      favouriteButton.heightAnchor.constraint(equalToConstant: 32),

      titleLabel.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: dishImageView.trailingAnchor, constant: -10),
      titleLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: 10),

      authorImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      authorImageView.widthAnchor.constraint(equalToConstant: 32),
      authorImageView.heightAnchor.constraint(equalToConstant: 32),
      authorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      authorLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
      authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: -10),
      authorLabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),

      minuteLabel.centerXAnchor.constraint(equalTo: minuteView.centerXAnchor),
      minuteLabel.centerYAnchor.constraint(equalTo: minuteView.centerYAnchor),

      likesLabel.centerXAnchor.constraint(equalTo: likesView.centerXAnchor),
      likesLabel.centerYAnchor.constraint(equalTo: likesView.centerYAnchor),

      minuteView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: 10),
      minuteView.bottomAnchor.constraint(equalTo: dishImageView.bottomAnchor, constant: -10),
      minuteView.widthAnchor.constraint(equalToConstant: 45),
      minuteView.heightAnchor.constraint(equalToConstant: 20),

      likesView.leadingAnchor.constraint(equalTo: dishImageView.leadingAnchor, constant: 10),
      likesView.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 10),
      likesView.widthAnchor.constraint(equalToConstant: 58),
      likesView.heightAnchor.constraint(equalToConstant: 21),

    ])
  }
}
