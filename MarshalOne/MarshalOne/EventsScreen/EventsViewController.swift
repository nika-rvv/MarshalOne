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
    
    private let refreshControl = UIRefreshControl()
    
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
        setupRefreshControl()
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
        eventsTable.showsVerticalScrollIndicator = false
        eventsTable.register(EventCell.self)
        eventsTable.backgroundColor = R.color.cellBackgroundColor()
    }
    
    func setupRefreshControl() {
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        eventsTable.addSubview(refreshControl)
        refreshControl.tintColor = R.color.mainBlue()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }
    
    @objc
    func refreshTableView() {
        fetchData()
    }
    
    func fetchData() {
        eventsTable.reloadData()
        refreshControl.endRefreshing()
    }
}

extension EventsViewController: EventsViewInput {
    func setView(index: Int) {
        eventsTable.reloadData()
    }
    
    func updateRace(raceId: Int) {
        let indexPath = IndexPath(item: raceId, section: 0)
        eventsTable.reloadRows(at: [indexPath], with: .none)
    }
    
    func setLikeData(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        eventsTable.reloadRows(at: [indexPath], with: .none)
    }
    
    func setDislike(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        eventsTable.reloadRows(at: [indexPath], with: .none)
    }
    
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
        
        var dateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.eventCellApiDateFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let date2 = inputFormatter.date(from: raceDataList[indexPath.row].date.from) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateString = outputFormatter.string(from: date2)
        } else {
            dateString = "Error"
        }
        
//        cell.configure(indexPath: indexPath.row,
//                               mainText: raceDataList[indexPath.row].name,
//                               dateText: dateString,
//                               placeText: "\(raceDataList[indexPath.row].location.latitude)",
//                               imageName: R.image.addRace.name,
//                               likeText: raceDataList[indexPath.row].likes,
//                               participantsText: raceDataList[indexPath.row].views,
//                               viewsText: raceDataList[indexPath.row].members.count,
//                               isLiked: userLiked.bool(forKey: "\(indexPath.row)"))
//        
        if !userLiked.bool(forKey: "\(indexPath.row)") {
            cell.setLikeAction { [weak self] in
                self?.output.didSetLike(for: indexPath.row)
            }
        } else {
            cell.setDislikeAction { [weak self] in
                self?.output.didUnsetLike(for: indexPath.row)
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.openEvent(with: indexPath.row + 1)
//        output.updateEvent(with: indexPath.row + 1)
        eventsTable.reloadData()
    }
}
