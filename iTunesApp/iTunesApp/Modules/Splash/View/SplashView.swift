//
//  SplashView.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 16.06.2023.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashView: BaseView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        presenter.viewDidAppear()
    }
    
}

extension SplashView: SplashViewControllerProtocol {
    func noInternetConnection() {
        DispatchQueue.main.async {
            self.titleLabel.text = "Lütfen internet bağlantınızı kontrol edin."
        }
    }
}
