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
    
    private var user: CurrentUser?
    
    var name: String = ""
    var surename: String = ""
    var city: String = ""
    var sex: String = ""
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.loadInfo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.cellBackgroundColor()
        addViews()
        setupConstraints()
        configureViewsWithData()
        setupTableView()
        setupActions()
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
            logoutActionView.bottomAnchor.constraint(equalTo: actionsStackView.bottomAnchor)
        ])
        
        deleteActionVeiw.top(isIncludeSafeArea: false)
        NSLayoutConstraint.activate([
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
    
    func setupActions() {
        logoutActionView.setprofileAction {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.output.didLogoutViewTap()
            }
        }
        
        deleteActionVeiw.setprofileAction {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.output.didDeleteAcountViewTap()
            }
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: ProfileCell.self, for: indexPath)
        cell.selectionStyle = .none
        
        var dateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.backendDateStringFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        if  let userBirth = user?.birthday,
            let date2 = inputFormatter.date(from: userBirth) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.frontednDateDisplayFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateString = outputFormatter.string(from: date2)
        } else {
            dateString = "Error"
        }
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter1.locale = Locale(identifier: "en_US_POSIX")
        
        guard let email = user?.email, let sex = user?.sex else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            cell.configureCellWith(with: R.string.localizable.email(),
                                   and: email)
        case 1:
            cell.configureCellWith(with: R.string.localizable.birthdate(),
                                   and: dateString)
        case 2:
            cell.configureCellWith(with: R.string.localizable.sex(),
                                   and: sex)
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
    func getData(userData: CurrentUser) {
        user = userData
        profileTableView.reloadData()
        guard let name = user?.firstname,
              let surname = user?.lastname else {
            return
        }
        
        let personName = name + " " + surname
        profileView.configureView(with: personName, and: user?.city ?? "")
        guard let userSex = user?.sex else { return }
        if userSex == "Unknown" {
            sex = "Не указан"
        } else {
            sex = userSex
        }
        guard let date = user?.birthday else {
            return
        }
    }
}
