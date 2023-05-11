//
//  EventMapView.swift
//  MarshalOne
//
//  Created by Veronika on 17.04.2023.
//

import UIKit
import MapKit

final class EventMapView: UIView {
    private let eventPlaceLabel: UILabel = {
        let eventPlace = UILabel()
        eventPlace.translatesAutoresizingMaskIntoConstraints = false
        eventPlace.font = UIFont.systemFont(ofSize: 16, weight: .light)
        eventPlace.textColor = R.color.mainBlue()
        eventPlace.text = R.string.localizable.mapEventPlace()
        return eventPlace
    }()
    
    private let eventPlaceInfoLabel: UILabel = {
        let eventPlaceInfo = UILabel()
        eventPlaceInfo.translatesAutoresizingMaskIntoConstraints = false
        eventPlaceInfo.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        eventPlaceInfo.textColor = R.color.mainOrange()
        return eventPlaceInfo
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.cellBackgroundColor()
        addViews()
        setupLayout()
        setupMap()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func addViews(){
        self.addSubview(eventPlaceLabel)
        self.addSubview(eventPlaceInfoLabel)
        self.addSubview(mapView)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            eventPlaceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        ])
        eventPlaceLabel.leading(20)
        eventPlaceLabel.trailing(-8)
        
        NSLayoutConstraint.activate([
            eventPlaceInfoLabel.topAnchor.constraint(equalTo: eventPlaceLabel.bottomAnchor, constant: 4)
        ])
        eventPlaceInfoLabel.leading(20)
        eventPlaceInfoLabel.trailing(-8)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: eventPlaceInfoLabel.bottomAnchor, constant: 16)
        ])
        mapView.leading()
        mapView.trailing()
        mapView.bottom(isIncludeSafeArea: false)

    }
    
    func setupMap(){
        let point = MKPointAnnotation()
        point.title = R.string.localizable.mapEventPlace()
        point.coordinate = CLLocationCoordinate2D(latitude: 54.7430, longitude: 55.96779)
        let center = point.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.addAnnotation(point)
        mapView.region = region
    }
    
    func cofigureMap(latitude: Double, longitude: Double, name: String) {
        let point = MKPointAnnotation()
        do {
            point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let center = point.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: center, span: span)
            mapView.addAnnotation(point)
            mapView.region = region
        } catch {
            eventPlaceInfoLabel.text = "Уточните у организатора"
        }
        
        eventPlaceInfoLabel.text = name

    }
}
