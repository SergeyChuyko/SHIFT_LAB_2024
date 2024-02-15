//
//  SceneDelegate.swift
//  TestTastForSHIFTLab2024
//
//  Created by Sergo on 12.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let isRegistered = RegistrationViewModel().checkRegistrationStatus()
        if isRegistered {
            let mainScreenViewModel = MainScreenViewModel()
            showMainScreen(with: mainScreenViewModel)
        } else {
            showRegistrationScreen()
        }
    }

    func showMainScreen(with viewModel: MainScreenViewModel) {
        guard let window = self.window else { return }
        let mainViewController = MainScreenViewController(viewModel: viewModel)
        window.rootViewController = mainViewController
        window.makeKeyAndVisible()
    }

    func showRegistrationScreen() {
        guard let window = self.window else { return }
        let registrationViewController = RegistrationViewController()
        window.rootViewController = registrationViewController
        window.makeKeyAndVisible()
    }
}
