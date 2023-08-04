//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.07.2023.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    //    MARK: - UI
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [trackNameLabel, artistNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
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
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    //    MARK: - Configure
    
    func configure(with viewModel: RecommendedTrackCellModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.kf.setImage(with: viewModel.artworkURL, completionHandler: nil)
    }
    
}
//    MARK: - Private

private extension RecommendedTrackCollectionViewCell {
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
            albumCoverImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            albumCoverImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            albumCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumCoverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: albumCoverImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

