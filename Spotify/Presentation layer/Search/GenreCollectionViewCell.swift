//
//  GenreCollectionViewCell.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 28.08.2023.
//

import UIKit
import Kingfisher

class GenreCollectionViewCell: UICollectionViewCell {
   static let identifier = "GenreCollectionViewCell"
    
//    MARK: - UI
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemTeal
    ]
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(label, imageView)
    }
    
   private func setupConstraints() {
       label.translatesAutoresizingMaskIntoConstraints = false
       imageView.translatesAutoresizingMaskIntoConstraints = false
       
       NSLayoutConstraint.activate([
           label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
           label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.height / 2),
           label.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20),
           label.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
       ])

       NSLayoutConstraint.activate([
           imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
           imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
           imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
           imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
       ])
    }
    
    func configure(with title: String) {
        label.text = title
        contentView.backgroundColor = colors.randomElement()
    }
}
