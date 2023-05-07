//
//  EventsTableAdapter.swift
//  MarshalOne
//
//  Created by Veronika on 23.04.2023.
//

import UIKit

final class EventsTableAdapter: NSObject {
    typealias DataSource = UITableViewDiffableDataSource<Section, RaceInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RaceInfo>
    typealias EventAction = (Int) -> Void
    
    private var openAction: EventAction?
    private var likeAction: EventAction?
    private var dislikeAction: EventAction?
    
    enum Section {
        case main
    }
    
    private let tableView: UITableView
    private lazy var dataSource: DataSource = makeDataSource()
    
    private var racesInfo: [RaceInfo] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
}

private extension EventsTableAdapter {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueCell(cellType: EventCell.self, for: indexPath)
            
            cell.selectionStyle = .none
            
            cell.configure(title: item.title,
                           dateSubtitle: item.dateSubtitle,
                           placeName: item.placeName,
                           imageId: item.imageId,
                           numberOfLikes: item.numberOfLikes,
                           numberOfParticipants: item.numberOfParticipants,
                           numberOfWatchers: item.numberOfWatchers,
                           isLiked: item.isLiked)
            
            if item.isLiked {
                cell.setDislikeAction {
                    self.dislikeAction?(indexPath.row)
                }
            } else {
                cell.setLikeAction {
                    self.likeAction?(indexPath.row)
                }
            }
            
            return cell
        }
        
        return dataSource
    }
    
    func applySnapshot(animated: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(racesInfo, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

//actions
extension EventsTableAdapter {
    func setOpenAction(_ action: @escaping EventAction) {
        self.openAction = action
    }
    
    func setLikeAction(_ action: @escaping EventAction) {
        self.likeAction = action
    }
    
    func setDisLikeAction(_ action: @escaping EventAction) {
        self.dislikeAction = action
    }
}

extension EventsTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openAction?(indexPath.row)
    }
}

extension EventsTableAdapter {
    func update(with racesInfo: [RaceInfo]) {
        self.racesInfo = racesInfo
        applySnapshot(animated: true)
    }
    
    func updateWithLike(withIndex index: Int) {
        racesInfo[index].isLiked = true
        racesInfo[index].numberOfLikes += 1
        applySnapshot(animated: false)
    }
    
    func updateWithDislike(withIndex index: Int) {
        racesInfo[index].isLiked = false
        racesInfo[index].numberOfLikes -= 1
        applySnapshot(animated: false)
    }
    
    func updateWatchers(withIndex index: Int) {
        racesInfo[index].numberOfWatchers += 1
        applySnapshot(animated: false)
    }
    
    func updateParticipants(withIndex index: Int) {
        racesInfo[index].numberOfParticipants += 1
        applySnapshot(animated: false)
    }
}

