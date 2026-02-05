//
//  LoginViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

/*
import UIKit

class LoginController: UIViewController {
    
    var coordinator: AppCoordinator?
    private let viewModel = LoginViewModel()
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.96, alpha: 1.0)
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Daxil ol"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.96, blue: 0.96, alpha: 1.0)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private func createCustomField(title: String, placeholder: String, isSecure: Bool = false) -> (UIView, UITextField) {
        let parentView = UIView()
        parentView.backgroundColor = .white
        parentView.layer.cornerRadius = 16
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.isSecureTextEntry = isSecure
        tf.borderStyle = .none
        
        parentView.addSubviews(label, tf)
        
        label.top(parentView.topAnchor, 8).0
             .leading(parentView.leadingAnchor, 16)
        
        tf.top(label.bottomAnchor, 4).0
          .leading(label.leadingAnchor).0
          .trailing(parentView.trailingAnchor, -16).0
          .bottom(parentView.bottomAnchor, -8)
        
        return (parentView, tf)
    }
    
    private lazy var emailContainer = createCustomField(title: "E-mail", placeholder: "johndoe@gmail.com")
    private lazy var passwordContainer = createCustomField(title: "Şifrə", placeholder: "••••••••", isSecure: true)
    
    private let loginErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mail və ya şifrə yanlışdır"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .red
        label.isHidden = true
        return label
    }()

    private lazy var forgotPasswordButton: UIButton = {
        let btn = UIButton(type: .system)
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor.darkGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        btn.setAttributedTitle(NSAttributedString(string: "Şifrəni unutmusunuz?", attributes: attrs), for: .normal)
        btn.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    private lazy var fieldsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainer.0, passwordContainer.0,  loginErrorLabel, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Növbəti", for: .normal)
        btn.backgroundColor = .buttonDisabled
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
        setupPasswordToggle()
        setupViewModelCallbacks()
        setupTextFieldTargets()
        updateButtonState()
        setupKeyboardObservers()
    }

    // MARK: - Setup
    private func setupTextFieldTargets() {
        [emailContainer.1, passwordContainer.1].forEach { textField in
            textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
    }

   

    private func updateButtonState() {
        let isEmailFilled = !(emailContainer.1.text?.isEmpty ?? true)
        let isPasswordFilled = !(passwordContainer.1.text?.isEmpty ?? true)
        
        let formIsValid = isEmailFilled && isPasswordFilled
        loginButton.isEnabled = formIsValid
        loginButton.backgroundColor = formIsValid ? .buttonPrimary : .buttonDisabled
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(logoImageView, titleLabel, containerView)
        containerView.addSubviews(fieldsStackView, loginButton)
        
        logoImageView
                .top(view.safeAreaLayoutGuide.topAnchor, 20).0
                .centerX(view.centerXAnchor).0
                .width(100).0.height(100)
                
            titleLabel
                .top(logoImageView.bottomAnchor, 40).0
                .leading(view.leadingAnchor, 24)
                
            containerView
                .top(titleLabel.bottomAnchor, 20).0
                .leading(view.leadingAnchor, 16).0
                .trailing(view.trailingAnchor, -16).0
                .bottom(view.safeAreaLayoutGuide.bottomAnchor, -150)

            fieldsStackView
                .top(containerView.topAnchor, 24).0
                .leading(containerView.leadingAnchor, 16).0
                .trailing(containerView.trailingAnchor, -16)
                
            // Hündürlüklər
            emailContainer.0.height(65)
            passwordContainer.0.height(65)
            
            // Unutmusunuz düyməsini sola söykəyirik
            forgotPasswordButton.contentHorizontalAlignment = .left
            
            loginButton
                .top(fieldsStackView.bottomAnchor, 24).0
                .leading(containerView.leadingAnchor, 16).0
                .trailing(containerView.trailingAnchor, -16).0
                .height(60)
    }

    private func setupViewModelCallbacks() {
        viewModel.callBack = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.view.showLoader()
            case .loaded:
                self.view.hideLoader()
            case .error(let message):
                self.showLoginError(message)
            case .success:
                print("")
               // self.coordinator?.showMainTab()
            }
        }
    }
    
    private func showLoginError(_ message: String) {
        UIView.animate(withDuration: 0.3) {
            self.loginErrorLabel.text = message
            self.loginErrorLabel.isHidden = false
            self.forgotPasswordButton.isHidden = false
            
            self.emailContainer.0.layer.borderColor = UIColor.red.cgColor
            self.emailContainer.0.layer.borderWidth = 1
            self.passwordContainer.0.layer.borderColor = UIColor.red.cgColor
            self.passwordContainer.0.layer.borderWidth = 1
            
            self.view.layoutIfNeeded()
        }
    }

    private func setupPasswordToggle() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        passwordContainer.1.rightView = button
        passwordContainer.1.rightViewMode = .always
    }

    @objc private func togglePasswordView(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordContainer.1.isSecureTextEntry = !sender.isSelected
    }

    @objc private func loginTapped() {
        viewModel.email = emailContainer.1.text
        viewModel.password = passwordContainer.1.text
        viewModel.loginUser()
    }
    
    @objc private func forgotPasswordTapped() {
        coordinator?.showPasswordRecovery()
    }
    
    @objc private func textDidChange() {
        updateButtonState()
        
        if !loginErrorLabel.isHidden {
            UIView.animate(withDuration: 0.3) {
                self.loginErrorLabel.isHidden = true
                self.forgotPasswordButton.isHidden = true
                
                self.emailContainer.0.layer.borderWidth = 0
                self.passwordContainer.0.layer.borderWidth = 0
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
}*/

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header (Back & Logo)
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .padding(10)
                    }
                    Spacer()
                }
                .padding(.horizontal, 10)
                .padding(.top, 5)
                
                Image("hospitalLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .padding(.top, 5)
            }
            .padding(.top, 0)
            
            // MARK: - Form Area
            ScrollView {
                VStack {
                    AuthFormView(mode: .login)
                        .padding(.top, 30)
                }
                .padding(.horizontal, 10)
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationBarHidden(true)
    }
}
