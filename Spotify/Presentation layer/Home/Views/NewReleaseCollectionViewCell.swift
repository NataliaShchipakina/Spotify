//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.07.2023.
//

import UIKit
import Kingfisher

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    //    MARK: - UI
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [albumNameLabel, numberOfTracksLabel, artistNameLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .leading
        
        return stackView
    }()
    
    //    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    //    MARK: - Configure
    
    func configure(with viewModel: NewReleasesCellModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.kf.setImage(with: viewModel.artworkURL, completionHandler: nil)
    }
    
}
//    MARK: - Private

private extension NewReleaseCollectionViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            albumCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            albumCoverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            albumCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumCoverImageView.heightAnchor.constraint(equalToConstant: 126),
            albumCoverImageView.widthAnchor.constraint(equalToConstant: 126),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 4),
        ])
    }
}

