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
    
    var isLightTheme: Bool = true
    
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
        actions.distribution = .equalCentering
        return actions
    }()
    
    private let logoutActionView: ProfileActionView = {
        let logout = ProfileActionView()
        logout.translatesAutoresizingMaskIntoConstraints = false
        logout.layer.cornerRadius = 10
        logout.clipsToBounds = true
        logout.configureViewWith(text: R.string.localizable.logout(),
                                 textColor: R.color.deleteActionColor(),
                                 image: R.image.logoutImage())
        return logout
    }()
    
    private let changeThemeActionVeiw: ProfileActionView = {
        let change = ProfileActionView()
        change.translatesAutoresizingMaskIntoConstraints = false
        change.layer.cornerRadius = 10
        change.clipsToBounds = true
        change.configureViewWith(text: R.string.localizable.changeTheme(),
                                 textColor: R.color.mainTextColor(),
                                 image: R.image.lightTheme())
        return change
    }()
    
    init(output: ProfileViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        output.loadInfo()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.cellBackgroundColor()
        self.tabBarController?.tabBar.backgroundColor = R.color.launchScreenColor()
        addViews()
        setupConstraints()
        configureViewsWithData()
        setupTableView()
        setupActions()
        output.loadInfo()
    }
}

extension ProfileViewController {
    private func addViews() {
        view.addSubview(profileView)
        
        view.addSubview(profileTableView)
        
        view.addSubview(actionsStackView)
        actionsStackView.addArrangedSubview(changeThemeActionVeiw)
        actionsStackView.addArrangedSubview(logoutActionView)
        
    }
    
    private func setupConstraints() {
        profileView.top(5, isIncludeSafeArea: true)
        profileView.leading()
        profileView.trailing()
        profileView.height(186)
        
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
        
        changeThemeActionVeiw.top(isIncludeSafeArea: false)
        NSLayoutConstraint.activate([
            changeThemeActionVeiw.bottomAnchor.constraint(equalTo: actionsStackView.bottomAnchor)
        ])
        changeThemeActionVeiw.width(160)
        
        logoutActionView.top(isIncludeSafeArea: false)
        NSLayoutConstraint.activate([
            logoutActionView.bottomAnchor.constraint(equalTo: actionsStackView.bottomAnchor),
        ])
        logoutActionView.width(160)
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
        
        changeThemeActionVeiw.setprofileAction {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.output.didChangeThemeViewTap()
                if self?.isLightTheme == true {
                    self?.changeThemeActionVeiw.changeActionImage(image: R.image.darkTheme())
                }
                if self?.isLightTheme == false {
                    self?.changeThemeActionVeiw.changeActionImage(image: R.image.lightTheme())
                }
                
                self?.isLightTheme = !(self?.isLightTheme ?? true)
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
        inputFormatter.dateFormat = DateFormatter.profileDateApiStringFormat
        inputFormatter.locale = Locale(identifier: "ru_RU_POSIX")
        if  let userBirth = user?.birthday,
            let date2 = inputFormatter.date(from: userBirth) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.profileDateDisplayFormat
            outputFormatter.locale = Locale(identifier: "ru_RU_POSIX")
            dateString = outputFormatter.string(from: date2)
        } else {
            dateString = "Error"
        }
        
        var sexRus = ""
        
        guard let email = user?.email, let sex = user?.sex else {
            return cell
        }
        
        if sex == "Female" || sex == "жен" {
            sexRus = "Женский"
        } else {
            sexRus = "Мужской"
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
                                   and: sexRus)
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
        if userSex == "Female" || userSex == "жен" {
            sex = "Женский"
        } else {
            sex = "Мужской"
        }
        guard let date = user?.birthday else {
            return
        }
    }
    
    func showLoaderView() {
        profileView.isHidden = true
        profileTableView.isHidden = true
        actionsStackView.isHidden = true
        self.showLoader()
    }
    
    func hideLoaderView() {
        self.hideLoader()
        UIView.animate(withDuration: 0.2) {
            self.profileView.isHidden = false
            self.profileTableView.isHidden = false
            self.actionsStackView.isHidden = false
        }
    }
    
    func showError(with error: String) {
        let alert = UIAlertController(title: R.string.localizable.ops(),
                                      message: "\(error)",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.correct(), style: .default))
        self.present(alert, animated: true)
    }
}
