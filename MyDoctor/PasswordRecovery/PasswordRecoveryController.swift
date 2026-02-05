//
//  PasswordRecoveryController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

import UIKit

class PasswordRecoveryController: UIViewController {
    
    var coordinator: AppCoordinator?
    private let viewModel = PasswordRecoveryViewModel()
    
    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.96, alpha: 1.0)
        iv.layer.cornerRadius = 20
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Şifrənin bərpası"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.94, green: 0.96, blue: 0.96, alpha: 1.0)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private func createCustomField(title: String, placeholder: String) -> (UIView, UITextField) {
        let parentView = UIView()
        parentView.backgroundColor = .white
        parentView.layer.cornerRadius = 16
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.borderStyle = .none
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        
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
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Şifrənin bərpası üçün e-poçt ünvanınızı daxil edin."
        label.font = .systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Növbəti", for: .normal)
        btn.backgroundColor = .buttonDisabled
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.layer.cornerRadius = 16
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldTargets()
        setupViewModelCallbacks()
    }

    private func setupTextFieldTargets() {
        emailContainer.1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    @objc private func textDidChange() {
        let isEmailFilled = !(emailContainer.1.text?.isEmpty ?? true)
        nextButton.isEnabled = isEmailFilled
        nextButton.backgroundColor = isEmailFilled ? .buttonPrimary : .buttonDisabled
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(logoImageView, titleLabel, containerView)
        containerView.addSubviews(emailContainer.0, nextButton, infoLabel)
        
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
            .height(220)

        emailContainer.0
            .top(containerView.topAnchor, 24).0
            .leading(containerView.leadingAnchor, 16).0
            .trailing(containerView.trailingAnchor, -16).0
            .height(65)
            
        nextButton
            .top(emailContainer.0.bottomAnchor, 16).0
            .leading(containerView.leadingAnchor, 16).0
            .trailing(containerView.trailingAnchor, -16).0
            .height(60)
            
        infoLabel
            .top(nextButton.bottomAnchor, 20).0
            .leading(containerView.leadingAnchor, 16).0
            .trailing(containerView.trailingAnchor, -16)
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
                self.showError(message)
            case .success:
                print("")
               // self.coordinator?.showOtpScreen(email: self.emailContainer.1.text ?? "", flow: .recovery)
            }
        }
    }
    
    @objc private func nextTapped() {
        viewModel.email = emailContainer.1.text
        viewModel.startRecovery()
    }

    private func showError(_ message: String) {
        UIView.animate(withDuration: 0.3) {
            self.infoLabel.text = message
            self.infoLabel.textColor = .red
            self.emailContainer.0.layer.borderColor = UIColor.red.cgColor
            self.emailContainer.0.layer.borderWidth = 1
        }
    }
}
