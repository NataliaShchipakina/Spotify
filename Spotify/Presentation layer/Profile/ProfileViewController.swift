//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit
import Kingfisher

protocol IProfileView: AnyObject {
    func showProfile(with model: UserProfile)
    func showFailedLoadProfileView()
}

class ProfileViewController: UIViewController {
    
    // MARK: - UI
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var models = [String]()
    
    // MARK: - Dependecies
    
    private let presenter: IProfilePresenter
    
    // MARK: - Init
    
    init(presenter: IProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ProfileViewController: IProfileView {
    func showProfile(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Full Name : \(model.displayName)")
        models.append("Email Adress: \(model.email)")
        models.append("User ID : \(model.id)")
        models.append("Plan : \(model.product)")
        createTableHeader(with: model.images[1].url)
        tableView.reloadData()
    }
    
    func showFailedLoadProfileView() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
}

private extension ProfileViewController {
    func setupUI() {
        title = "Profile"
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createTableHeader(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.kf.setImage(with: url)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        tableView.tableHeaderView = headerView
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
