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
        setupUI()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.didLoadRaces()
    }
}

private extension NewEventsViewController {
    func setupUI(){
        setupNavBar()
        setupTableView()
        setupConstraints()
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
}

extension NewEventsViewController: NewEventsViewInput {
    func update(withRaces races: [RaceInfo]) {
        eventsTableAdapter.update(with: races)
    }
}
