//
//  RegistrationViewModel.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 12.02.2024.
//

import Foundation

class RegistrationViewModel {
    var registrationData = RegistrationData()

    func validateRegistrationData() -> Bool {
        guard let firstName = registrationData.firstName, !firstName.isEmpty,
              let lastName = registrationData.lastName, !lastName.isEmpty,
              firstName.count >= 2, lastName.count >= 2 else {
            return false
        }
        guard let password = registrationData.password,
              let confirmPassword = registrationData.confirmPassword,
              password == confirmPassword,
              password.contains(where: { $0.isUppercase }),
              password.contains(where: { $0.isNumber }) else {
            return false
        }
        return true
    }

    func saveRegistrationDataLocally() {
        let defaults = UserDefaults.standard
        defaults.set(registrationData.firstName, forKey: "firstName")
        defaults.set(registrationData.lastName, forKey: "lastName")
        defaults.set(true, forKey: "isRegistered")
    }

    func checkRegistrationStatus() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isRegistered")
    }
}
