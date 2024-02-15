//
//  AlertManager.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 13.02.2024.
//

import UIKit

class AlertManager {
    static func showAlert(on viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        okAction.setValue(UIColor(named: "primary-color"), forKey: "titleTextColor")
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
