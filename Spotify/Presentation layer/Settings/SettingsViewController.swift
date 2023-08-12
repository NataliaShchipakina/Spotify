//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Natalia Shchipakina on 03.07.2023.
//

import UIKit

protocol ISettingsView: AnyObject {
    
}

struct SectionViewModel {
    let title: String
    let options: [OptionViewModel]
}

struct OptionViewModel {
    let title: String
    let handler: () -> Void
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ISettingsView {
       
    // MARK: - UI
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [SectionViewModel]()

    // MARK: - Dependecies
    
    private let presenter: ISettingsPresenter
    
    // MARK: - Init
    
    init(presenter: ISettingsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "Settings"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configureModels() {
        sections.append(SectionViewModel(title: "Profile", options: [OptionViewModel(title: "View your profile", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))
        
        sections.append(SectionViewModel(title: "Account", options: [OptionViewModel(title: "Sign Out", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.signOutTapped()
            }
        })]))
        
    }
    
    private func signOutTapped() {
        
    }
    
    private func viewProfile() {
        presenter.profileButtonDidTap()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
//    MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Call handler for cell
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
