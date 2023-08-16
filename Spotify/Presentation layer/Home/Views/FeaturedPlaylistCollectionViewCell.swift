//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 25.07.2023.
//

import UIKit

struct FeaturedPlaylistCellModel {
    let name: String
    let artworkURL: URL?
    let creatorName: String
}

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    //    MARK: - UI
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [playlistNameLabel, creatorNameLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        
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
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.kf.cancelDownloadTask()
        playlistCoverImageView.image = nil
    }
    
    //    MARK: - Configure
    
    func configure(with viewModel: FeaturedPlaylistCellModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.kf.setImage(with: viewModel.artworkURL)
    }
    
}
//    MARK: - Private

private extension FeaturedPlaylistCollectionViewCell {
    func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        playlistCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playlistCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            playlistCoverImageView.heightAnchor.constraint(equalToConstant: 120),
            playlistCoverImageView.widthAnchor.constraint(equalToConstant: 120),
            playlistCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: playlistCoverImageView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
