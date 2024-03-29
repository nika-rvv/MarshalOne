//
//  NewEventsViewController.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//  
//

import UIKit

final class NewEventsViewController: UIViewController {
	private let output: NewEventsViewOutput
    
    private lazy var eventsTableView = UITableView()
    private lazy var eventsTableAdapter = EventsTableAdapter(tableView: eventsTableView)
    
    private let customNavBar: NavigationBarView = {
        let navBar = NavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        label.textColor = R.color.mainTextColor()
        label.numberOfLines = 0
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    private let refreshControl = UIRefreshControl()

    init(output: NewEventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = R.color.cellBackgroundColor()
        self.tabBarController?.tabBar.backgroundColor = R.color.launchScreenColor()
        setupUI()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.showLoader()
        output.didLoadRaces()
    }
}

private extension NewEventsViewController {
    func setupUI(){
        setupNavBar()
        setupTableView()
        setupConstraints()
        setupActions()
        setupRefreshControl()
    }
    
    func setupNavBar(){
        view.addSubview(customNavBar)
        customNavBar.setConfigForEventsScreen()
    }
    
    func setupConstraints() {
        customNavBar.top(isIncludeSafeArea: false)
        customNavBar.leading()
        customNavBar.trailing()
        customNavBar.height(88)
        
        NSLayoutConstraint.activate([
            eventsTableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor)
        ])
        eventsTableView.leading(12)
        eventsTableView.trailing(-12)
        eventsTableView.bottom(isIncludeSafeArea: false)
        
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
    }

    func setupTableView() {
        eventsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventsTableView)
        eventsTableView.separatorStyle = .none
        eventsTableView.showsVerticalScrollIndicator = false
        eventsTableView.delegate = eventsTableAdapter
        eventsTableView.register(EventCell.self)
        eventsTableView.backgroundColor = R.color.cellBackgroundColor()
    }
    
    func setupActions() {
        eventsTableAdapter.setOpenAction { [weak self] index in
            self?.output.didOpenEvent(with: index)
        }
        
        eventsTableAdapter.setLikeAction { [weak self] index in
            self?.output.didSetLike(for: index)
        }
        
        eventsTableAdapter.setDisLikeAction { [weak self] index in
            self?.output.didUnsetLike(for: index)
        }
    }
    
    func setupRefreshControl() {
        refreshControl.tintColor = R.color.mainBlue()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        eventsTableView.addSubview(refreshControl)
    }
    
    @objc
    func refresh() {
        output.didLoadRaces()
    }
}

extension NewEventsViewController: NewEventsViewInput {
    func showError(error: String?) {
        if let error = error {
            let alert = UIAlertController(title: R.string.localizable.ops(),
                                          message: "\(error)",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: R.string.localizable.correct(), style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func update(withRaces races: [RaceInfo]) {
        refreshControl.endRefreshing()
        eventsTableAdapter.update(with: races)
    }
    
    func setLike(raceId: Int) {
        eventsTableAdapter.updateWithLike(withIndex: raceId)
    }
    
    func setDislike(raceId: Int) {
        eventsTableAdapter.updateWithDislike(withIndex: raceId)
    }
    
    func addWatcher(raceId: Int) {
        eventsTableAdapter.updateWatchers(withIndex: raceId)
    }
    
    func showLoaderView() {
        eventsTableView.isHidden = true
        self.showLoader()
    }
    
    func hideLoaderView() {
        self.hideLoader()
        eventsTableView.isHidden = false
    }
}
