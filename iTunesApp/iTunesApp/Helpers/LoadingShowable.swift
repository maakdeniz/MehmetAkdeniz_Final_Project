//
//  LoadingShowable.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//


import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading(){
        LoadingView.shared.startLoading()
        
    }
    func hideLoading(){
        LoadingView.shared.stopLoading()
    }
}

