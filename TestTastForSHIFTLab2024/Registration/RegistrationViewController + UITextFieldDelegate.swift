//
//  RegistrationViewController + UITextFieldDelegate.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 13.02.2024.
//

import UIKit

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            dateOfBirthTextField.becomeFirstResponder()
        case dateOfBirthTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        default:
            confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateOfBirthTextField {
            return false
        }
        return true
    }
}
