//
//  WelcomeViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import UIKit
import Foundation

/*class WelcomeController: UIViewController {
    var coordinator: AppCoordinator?
    
    private let viewModel = WelcomeViewModel()
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.96, alpha: 1.0)
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        // iv.image = UIImage(named: "app_logo") // Loqo hazır olanda bura əlavə edərsən
        return iv
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Xoş gəlmişsiniz"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Qeydiyyatdan keç", for: .normal)
        btn.backgroundColor = UIColor(red: 0.35, green: 0.67, blue: 0.61, alpha: 1.0)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Daxil ol", for: .normal)
        btn.backgroundColor = UIColor(red: 0.40, green: 0.80, blue: 0.73, alpha: 1.0)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCallBack()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubviews(logoImageView, welcomeLabel, registerButton, loginButton)
        
        
        logoImageView
            .centerX(view.centerXAnchor).0
            .centerY(view.centerYAnchor, -100).0
            .width(160).0
            .height(160)
        
        welcomeLabel
            .top(logoImageView.bottomAnchor, 40).0
            .leading(view.leadingAnchor, 20).0
            .trailing(view.trailingAnchor, -20)
        
        loginButton
            .bottom(view.safeAreaLayoutGuide.bottomAnchor, -40).0
            .leading(view.leadingAnchor, 25).0
            .trailing(view.trailingAnchor, -25).0
            .height(55)
        
        registerButton
            .bottom(loginButton.topAnchor, -15).0
            .leading(loginButton.leadingAnchor).0
            .trailing(loginButton.trailingAnchor).0
            .height(55)
    }
    
    private func setupCallBack() {
            viewModel.callBack = { [weak self] state in
                guard let self = self else { return }
                
                switch state {
                case .loading:
                    self.view.showLoader()
                case .loaded:
                    self.view.hideLoader()
                case .error(let message):
                    self.showMessage(title: "Xəta", message: message)
                }
            }
        }
    
    // MARK: - Actions
    @objc private func registerTapped() {
        coordinator?.showRegistration()
    }
    
    @objc private func loginTapped() {
        coordinator?.showLogin()
    }
}*/

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Xoş gəlmişsiniz")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                VStack(spacing: 15) {
                    NavigationLink(destination: RegistrationView()) {
                        Text("Qeydiyyatdan keç")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 77/255, green: 182/255, blue: 172/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Daxil ol")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 100/255, green: 200/255, blue: 185/255))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 50)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
