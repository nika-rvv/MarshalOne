//
//  ProfileScreenViewController.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import UIKit

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    
    private let profileView: ProfileView = {
        let profile = ProfileView()
        profile.translatesAutoresizingMaskIntoConstraints = false
        return profile
    }()
    
    private let profileTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let actionsStackView: UIStackView = {
        let actions = UIStackView()
        actions.translatesAutoresizingMaskIntoConstraints = false
        actions.axis = .horizontal
        actions.spacing = 24
        actions.distribution = .fillProportionally
        return actions
    }()
    
    private let logoutActionView: ProfileActionView = {
        let logout = ProfileActionView()
        logout.translatesAutoresizingMaskIntoConstraints = false
        logout.layer.cornerRadius = 10
        logout.clipsToBounds = true
        logout.configureViewWith(text: "Выйти из аккаунта",
                                 textColor: R.color.mainTextColor(),
                                 image: R.image.logoutImage())
        return logout
    }()
    
    private let deleteActionVeiw: ProfileActionView = {
        let delete = ProfileActionView()
        delete.translatesAutoresizingMaskIntoConstraints = false
        delete.layer.cornerRadius = 10
        delete.clipsToBounds = true
        delete.configureViewWith(text: "Удалить аккаунт",
                                 textColor: R.color.deleteActionColor(),
                                 image: R.image.deleteAccountImage())
        return delete
    }()
    
    init(output: ProfileViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.cellBackgroundColor()
        addViews()
        setupConstraints()
        configureViewsWithData()
        setupTableView()
    }
}

extension ProfileViewController {
    private func addViews() {
        view.addSubview(profileView)
        
        view.addSubview(profileTableView)
        
        view.addSubview(actionsStackView)
        actionsStackView.addArrangedSubview(logoutActionView)
        actionsStackView.addArrangedSubview(deleteActionVeiw)
    }
    
    private func setupConstraints() {
        profileView.top(5, isIncludeSafeArea: true)
        profileView.leading()
        profileView.trailing()
        profileView.height(160)
        
        profileTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: profileView.bottomAnchor)
        ])
        profileTableView.leading()
        profileTableView.trailing()
        profileTableView.height(200)
        
        NSLayoutConstraint.activate([
            actionsStackView.topAnchor.constraint(equalTo: profileTableView.bottomAnchor),
        ])
        actionsStackView.leading(20)
        actionsStackView.trailing(-20)
        actionsStackView.height(72)
        
        logoutActionView.top(isIncludeSafeArea: false)
        logoutActionView.leading()
        NSLayoutConstraint.activate([
//            logoutActionView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -12),
            logoutActionView.bottomAnchor.constraint(equalTo: actionsStackView.bottomAnchor)
        ])
        
        deleteActionVeiw.top(isIncludeSafeArea: false)
        NSLayoutConstraint.activate([
//            deleteActionVeiw.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 12),
            deleteActionVeiw.bottomAnchor.constraint(equalTo: actionsStackView.bottomAnchor)
        ])
        deleteActionVeiw.trailing()
    }
    
    private func setupTableView() {
        profileTableView.separatorStyle = .singleLine
        profileTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        profileTableView.backgroundColor = R.color.cellBackgroundColor()
        profileTableView.separatorColor = .gray
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(ProfileCell.self)
        profileTableView.allowsSelection = false
        profileTableView.isScrollEnabled = false
    }
    
    private func configureViewsWithData() {
        profileView.configureView(with: R.string.localizable.name(), and: R.string.localizable.city())
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: ProfileCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            cell.configureCellWith(with: R.string.localizable.email(),
                                   and: "ivan@ivanov.ru")
        case 1:
            cell.configureCellWith(with: R.string.localizable.birthdate(),
                                   and: "08.01.2002")
        case 2:
            cell.configureCellWith(with: R.string.localizable.sex(),
                                   and: "man")
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
}

extension ProfileViewController: ProfileViewInput {
    
}
