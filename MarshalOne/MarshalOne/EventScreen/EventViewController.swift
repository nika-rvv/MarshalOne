//
//  EventViewController.swift
//  MarshalOne
//
//  Created by Veronika on 05.03.2023.
//  
//

import UIKit

final class EventViewController: UIViewController {
	private let output: EventViewOutput

    private let navigationBar: NavigationBarView = {
        let navBar = NavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.setupConfigForRegisterScreen()
        return navBar
    }()
    
    private let raceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = R.image.loginImage()
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var eventContentView: EventContentView = {
        let event = EventContentView()
        event.translatesAutoresizingMaskIntoConstraints = false
        event.layer.cornerRadius = 40
        event.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        event.clipsToBounds = true
        return event
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    init(output: EventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
	}
}

extension EventViewController: EventViewInput {
    private func setupViews(){
        view.backgroundColor = R.color.launchScreenColor()
        view.addSubview(raceImageView)
        view.addSubview(navigationBar)
        view.addSubview(eventContentView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        ])
        
        navigationBar.leading()
        navigationBar.trailing()
        navigationBar.height(80)
        
        NSLayoutConstraint.activate([
            raceImageView.topAnchor.constraint(equalTo: navigationBar.topAnchor)
        ])
        raceImageView.leading()
        raceImageView.trailing()
        raceImageView.height(view.frame.height / 2)
        
        
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: raceImageView.bottomAnchor)
        ])
        eventContentView.leading()
        eventContentView.trailing()
        eventContentView.bottom(isIncludeSafeArea: false)
    }
    
    private func configureView() {
        navigationBar.delegate = self
        eventContentView.configureViewWith(mainText: "Чемпионат России. Гонки на льду - класс 500. Полуфинал - 1 этап",
                                           placeText: "респ. Башкортостан, Уфа",
                                           dateText: "7 янв. — 10 янв.",
                                           additionalText: "Пролог в темное время: часовой (эндуро-стадион + небольшой трек для двух классов Pro и B3. Наличие фары, фонариков - спереди, заднего габарита либо отражающих элементов красного цвета - ОБЯЗАТЕЛЬНО. Первый внедорожный гоночный день классов Profi (Pro) (сложность трека - heavy) и Base 3 (B3) (сложность трека - medium).")
    }
}

extension EventViewController: NavigationBarDelegate {
    func backButtonAction() {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.navigationBar.backButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didPressBackButton()
                self?.navigationBar.backButton.alpha = 1
            }
        }
    }
}
