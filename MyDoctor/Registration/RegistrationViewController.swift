//
//  RegistrationViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import UIKit

import UIKit

/*class RegisterController: UIViewController {
    
    var coordinator: AppCoordinator?
    
    private let viewModel = RegisterViewModel()
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.96, alpha: 1.0)
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hesab yarat"
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
    
    private let fieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var nameContainer = createCustomField(title: "Ad", placeholder: "Adınızı daxil edin")
    private lazy var emailContainer = createCustomField(title: "E-mail", placeholder: "johndoe@gmail.com")
    private lazy var passwordContainer = createCustomField(title: "Şifrə", placeholder: "••••••••", isSecure: true)
    
    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Bu E-mail artıq istifadə olunub"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Qeydiyyatdan keç", for: .normal)
        btn.backgroundColor = .buttonDisabled
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.layer.cornerRadius = 16
        btn.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPasswordToggle()
        setupViewModelCallbacks()
        setupTextFieldTargets()
        updateButtonState()
        setupKeyboardObservers()
    }

    private func setupTextFieldTargets() {
        [nameContainer.1, emailContainer.1, passwordContainer.1].forEach { textField in
            textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
    }

    @objc private func textDidChange() {
        updateButtonState()
        
        if emailContainer.1.isFirstResponder && !emailErrorLabel.isHidden {
            UIView.animate(withDuration: 0.3) {
                self.emailErrorLabel.isHidden = true
                self.emailContainer.0.layer.borderWidth = 0
                self.view.layoutIfNeeded()
            }
        }
    }

    private func updateButtonState() {
        let isNameFilled = !(nameContainer.1.text?.isEmpty ?? true)
        let isEmailFilled = !(emailContainer.1.text?.isEmpty ?? true)
        let isPasswordFilled = !(passwordContainer.1.text?.isEmpty ?? true)
        
        let formIsValid = isNameFilled && isEmailFilled && isPasswordFilled
        
        registerButton.isEnabled = formIsValid
        registerButton.backgroundColor = formIsValid ? .buttonPrimary : .buttonDisabled
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(logoImageView, titleLabel, containerView)
        
        fieldsStackView.addArrangedSubview(nameContainer.0)
        fieldsStackView.addArrangedSubview(emailContainer.0)
        fieldsStackView.addArrangedSubview(emailErrorLabel)
        fieldsStackView.addArrangedSubview(passwordContainer.0)
        
        containerView.addSubviews(fieldsStackView, registerButton)
        
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
            
        nameContainer.0.height(65)
        emailContainer.0.height(65)
        passwordContainer.0.height(65)
        
        emailErrorLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        registerButton
            .top(fieldsStackView.bottomAnchor, 24).0
            .leading(containerView.leadingAnchor, 16).0
            .trailing(containerView.trailingAnchor, -16).0
            .height(60)
    }
    
    private func setupKeyboardObservers() {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tap)
        }
        
        @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
        
        @objc private func keyboardWillShow(notification: NSNotification) {
            guard let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardHeight / 2)
            }
        }
        
        @objc private func keyboardWillHide() {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }

    // MARK: - Password Visibility Toggle (Göz işarəsi)
    private func setupPasswordToggle() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(.toggle, for: .selected)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        passwordContainer.1.rightView = button
        passwordContainer.1.rightViewMode = .always
    }
    
    private func setupViewModelCallbacks() {
        viewModel.callBack = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                self.view.showLoader()
                self.registerButton.isEnabled = false
            case .loaded:
                self.view.hideLoader()
                self.registerButton.isEnabled = true
            case .error(let message):
                if message.lowercased().contains("email") || message.lowercased().contains("istifadə") {
                    UIView.animate(withDuration: 0.3) {
                        self.emailErrorLabel.text = message
                        self.emailErrorLabel.isHidden = false
                        self.emailContainer.0.layer.borderWidth = 1
                        self.emailContainer.0.layer.borderColor = UIColor.red.cgColor
                        self.view.layoutIfNeeded() 
                    }
                }
            case .success:
                if let email = self.emailContainer.1.text {
                    self.coordinator?.showOtpScreen(email: email, flow: .registration)
                }
            }
        }
    }
    
    @objc private func togglePasswordView(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordContainer.1.isSecureTextEntry = !sender.isSelected
    }
    
    @objc private func registerTapped() {
        viewModel.firstname = nameContainer.1.text
        viewModel.email = emailContainer.1.text
        viewModel.password = passwordContainer.1.text
        viewModel.checkAndRegister()
    }
}*/

import SwiftUI

//struct RegistrationView: View {
//    @StateObject private var viewModel = RegistrationViewModel()
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//
//            VStack {
//                Image("hospitalLogo")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 90, height: 90)
//                        .padding(.top, 20)
//                        .padding(.bottom, 40)
//                
//                AuthFormView(mode: .registration)
//                
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//        }
//        .navigationBarHidden(true)
//    }
//}


struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
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
            
            // MARK: - Sürüşə bilən Forma (Klaviatura dostu)
            ScrollView {
                VStack {
                    AuthFormView(mode: .registration)
                        .padding(.top, 20)
                }
                .padding(.horizontal, 10)
            }
            .scrollIndicators(.hidden)
            .scrollDismissesKeyboard(.interactively)
        }
        .navigationBarHidden(true)
    }
}
