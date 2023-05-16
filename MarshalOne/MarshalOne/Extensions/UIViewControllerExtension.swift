//
//  UIViewControllerExtension.swift
//  MarshalOne
//
//  Created by Veronika on 15.05.2023.
//

import UIKit

extension UIViewController {
    func showLoader() {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = R.color.mainBlue()
        
        self.view.addSubview(loader)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        loader.centerX()
        loader.centerY()
        
        loader.startAnimating()
    }
    
    func hideLoader() {
        let loader = self.view.subviews.first { $0 is UIActivityIndicatorView }
        loader?.removeFromSuperview()
    }
    
    func showLoaderIfNeeded(isLoading: Bool) {
        if isLoading {
            showLoader()
        } else {
            hideLoader()
        }
    }
}
