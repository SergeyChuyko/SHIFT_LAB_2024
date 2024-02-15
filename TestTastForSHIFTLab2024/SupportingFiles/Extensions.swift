//
//  Extensions.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 15.02.2024.
//

import UIKit

extension UITextField {
    static func makeTextField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(named: "textFieldBackGround-color")
        textField.layer.borderColor = UIColor(named: "border-color")?.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 8
        textField.textColor = UIColor(named: "customDark-color")
        let placeholderColor = UIColor(named: "customGray-color") ?? UIColor.black
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: placeholderColor
            ])
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        return textField
    }
}

extension String {
    var isValidPassword: Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
}
