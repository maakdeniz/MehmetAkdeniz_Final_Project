//
//  BaseView.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 10.06.2023.
//

import UIKit

class BaseView: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlert(_ title: String, _ message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }

}
