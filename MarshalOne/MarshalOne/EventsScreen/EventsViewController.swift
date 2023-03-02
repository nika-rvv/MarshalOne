//
//  EventsViewController.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import UIKit

final class EventsViewController: UIViewController {
	private let output: EventsViewOutput
    
    private let eventsTable = UITableView()

    init(output: EventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = R.color.cellBackgroundColor()
        title = R.string.localizable.events()
        setupTableView()
        setupConstraints()
	}
}

extension EventsViewController: EventsViewInput {
    private func setupConstraints() {
        eventsTable.top(isIncludeSafeArea: true)
        eventsTable.leading(12)
        eventsTable.trailing(-12)
        eventsTable.bottom(isIncludeSafeArea: false)
    }
    
    private func setupTableView() {
        eventsTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventsTable)
        eventsTable.delegate = self
        eventsTable.dataSource = self
        eventsTable.separatorStyle = .none
        eventsTable.register(EventCell.self)
        eventsTable.backgroundColor = R.color.cellBackgroundColor()
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: EventCell.self, for: indexPath)
        cell.configureCellWith(title: "Title should be bigger than this one to check number of rows",
                               date: "28/02/2023",
                               place: "Moscow")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
}
