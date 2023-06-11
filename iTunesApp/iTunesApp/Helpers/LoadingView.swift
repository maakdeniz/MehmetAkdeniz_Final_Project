//
//  LoadingView.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//


import UIKit
class LoadingView {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init(){
        configure()
    }
    
    func configure(){
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            UIApplication.shared.windows.first?.addSubview(self!.blurView)
            self?.activityIndicator.startAnimating()
        }
    }
    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.blurView.removeFromSuperview()
            self?.activityIndicator.stopAnimating()
        }
    }
    
}

