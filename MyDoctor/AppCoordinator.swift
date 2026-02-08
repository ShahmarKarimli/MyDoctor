//
//  AppCoordinator.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

import SwiftUI

final class AppCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setViewControllers([UIHostingController(rootView: WelcomeView())], animated: true)
    }

    
    func showRegistration() {
      /*  let vc = RegisterController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)*/
    }
    
    func showLogin() {
      /*  let vc = LoginController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)*/
    }
    
    func showOtpScreen() {
    
    }
    
    func showPasswordRecovery() {
       /* let vc = PasswordRecoveryController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)*/
    }
    
    func showNewPassword() {
        let vc = NewPasswordController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goBack() {
            navigationController.popViewController(animated: true)
        }
        
        // Tam başa qayıtmaq üçün (Məsələn uğurlu qeydiyyatdan sonra)
        func popToRoot() {
            navigationController.popToRootViewController(animated: true)
        }
}
