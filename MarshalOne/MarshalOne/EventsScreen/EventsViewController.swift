//
//  EventsViewController.swift
//  MarshalOne
//
//  Created by Veronika on 24.02.2023.
//  
//

import UIKit

var userLiked = UserDefaults.standard

final class EventsViewController: UIViewController {
    private let output: EventsViewOutput
    
    var raceDataList: RaceList = []
    
    private let customNavBar: NavigationBarView = {
        let navBar = NavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        return navBar
    }()
    
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
        setupTableView()
        setupNavBar()
        setupConstraints()
        navigationController?.isNavigationBarHidden = true
        output.didLoadRaces()
    }
}

private extension EventsViewController {
    func setupConstraints() {
        customNavBar.top(isIncludeSafeArea: false)
        customNavBar.leading()
        customNavBar.trailing()
        customNavBar.height(88)
        
        NSLayoutConstraint.activate([
            eventsTable.topAnchor.constraint(equalTo: customNavBar.bottomAnchor)
        ])
        eventsTable.leading(12)
        eventsTable.trailing(-12)
        eventsTable.bottom(isIncludeSafeArea: false)
    }
    
    func setupNavBar(){
        view.addSubview(customNavBar)
        customNavBar.setConfigForEventsScreen()
    }
    
    func setupTableView() {
        eventsTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventsTable)
        eventsTable.delegate = self
        eventsTable.dataSource = self
        eventsTable.separatorStyle = .none
        eventsTable.register(EventCell.self)
        eventsTable.backgroundColor = R.color.cellBackgroundColor()
    }
}

extension EventsViewController: EventsViewInput {
    func setData(raceData: RaceList) {
        print(raceData)
        raceDataList = raceData
        eventsTable.reloadData()
    }
}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raceDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: EventCell.self, for: indexPath)
        
        
        cell.configureCellWith(indexPath: indexPath.row,
                               mainText: raceDataList[indexPath.row].name,
                               dateText: raceDataList[indexPath.row].date.from,
                               placeText: "\(raceDataList[indexPath.row].location.latitude)",
                               imageName: R.image.addRace.name,
                               likeText: raceDataList[indexPath.row].likes,
                               participantsText: raceDataList[indexPath.row].views,
                               viewsText: raceDataList[indexPath.row].members.count,
                               isLiked: userLiked.bool(forKey: "\(indexPath.row)"))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.openEventScreen()
    }
}
