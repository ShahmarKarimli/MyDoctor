//
//  OtpViewController.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

import UIKit

/*class OTPViewController: UIViewController {
    
    var coordinator: AppCoordinator?
    var userEmail: String?
    var flow: OTPFlow = .registration
    
    private let viewModel = OTPViewModel()
    private var otpTextFields = [UITextField]()
    
    // MARK: - UI Elements
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OTP kodunu daxil edin"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "E-mailinizə göndərilən 6 rəqəmli kodu daxil edin"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let otpStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:59"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(string: "Kodu yenidən göndər", attributes: attrs)
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(self, action: #selector(resendTapped), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Çox sayda cəhd aşkarlandı. Zəhmət olmasa, bir az sonra yenidən cəhd edin."
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupOTPFields()
        bindViewModel()
        viewModel.email = userEmail
        viewModel.startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(backButton, titleLabel, subtitleLabel, otpStackView, timerLabel, resendButton, errorLabel)
        
        backButton
            .top(view.safeAreaLayoutGuide.topAnchor, 20).0
            .leading(view.leadingAnchor, 16).0
            .width(24).0.height(24)
        
        titleLabel
            .top(backButton.bottomAnchor, 30).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24)
        
        subtitleLabel
            .top(titleLabel.bottomAnchor, 8).0
            .leading(titleLabel.leadingAnchor).0
            .trailing(titleLabel.trailingAnchor)
        
        otpStackView
            .top(subtitleLabel.bottomAnchor, 30).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24).0
            .height(70)
        
        timerLabel
            .top(otpStackView.bottomAnchor, 24).0
            .leading(view.leadingAnchor, 80)
        
        resendButton
            .centerY(timerLabel.centerYAnchor).0
            .leading(timerLabel.trailingAnchor, 12)
        
        errorLabel
            .top(resendButton.bottomAnchor, 12).0
            .leading(view.leadingAnchor, 24).0
            .trailing(view.trailingAnchor, -24)
    }
    
    private func setupOTPFields() {
        for i in 0..<6 {
            let field = UITextField()
            field.backgroundColor = UIColor(red: 0.94, green: 0.97, blue: 0.97, alpha: 1.0)
            field.layer.cornerRadius = 12
            field.textAlignment = .center
            field.font = .systemFont(ofSize: 24, weight: .bold)
            field.keyboardType = .numberPad
            field.delegate = self
            field.tag = i
            otpStackView.addArrangedSubview(field)
            otpTextFields.append(field)
        }
        otpTextFields.first?.becomeFirstResponder()
    }
    
    private func bindViewModel() {
        viewModel.flow = self.flow
        viewModel.onTimerUpdate = { [weak self] timeString in
            DispatchQueue.main.async {
                self?.timerLabel.text = timeString
            }
        }
        
        viewModel.callBack = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.view.showLoader()
            case .loaded:
                self.view.hideLoader()
            case .success:
                if flow == .recovery {
                    self.coordinator?.showNewPassword()
                } else {
                    self.showMessage(title: "Uğurlu", message: "Hesabınız təsdiqləndi!")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            case .error(let message):
                self.showMessage(title: "Xəta", message: message)
            }
        }
        
        viewModel.onLimitReached = { [weak self] in
            DispatchQueue.main.async {
                self?.resendButton.isEnabled = false
                self?.resendButton.alpha = 0.5
                self?.errorLabel.isHidden = false
                self?.timerLabel.textColor = .gray
            }
        }
        }
    
    // MARK: - Actions
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func resendTapped() {
        viewModel.resendCode()
    }
}

// MARK: - UITextFieldDelegate
extension OTPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty {
            textField.text = string
            let nextTag = textField.tag + 1
            
            if nextTag < 6 {
                otpTextFields[nextTag].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                let fullCode = otpTextFields.compactMap { $0.text }.joined()
                
                if fullCode.count == 6 {
                    viewModel.verifyCode(fullCode)
                }
            }
            return false
        }
        
        if string.isEmpty {
            textField.text = ""
            let prevTag = textField.tag - 1
            if prevTag >= 0 {
                otpTextFields[prevTag].becomeFirstResponder()
            }
            return false
        }
        
        return true
    }
}*/

import SwiftUI

struct OTPView: View {
    @StateObject private var viewModel = OTPViewModel()
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            VStack(alignment: .leading, spacing: 10) {
                Text("OTP kodunu daxil edin")
                    .font(.system(size: 24, weight: .bold))
                
                Text("E-mailinizə göndərilən 6 rəqəmli kodu daxil edin.")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.top, 20)
            
            // OTP Xanaları
            ZStack {
                TextField("", text: $viewModel.otpCode)
                    .frame(width: 0, height: 0)
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .onChange(of: viewModel.otpCode) { newValue in
                        if newValue.count > viewModel.otpLength {
                            viewModel.otpCode = String(newValue.prefix(viewModel.otpLength))
                        }
                    }
                
                HStack(spacing: 12) {
                    ForEach(0..<viewModel.otpLength, id: \.self) { index in
                        otpCharacter(at: index)
                    }
                }
            }
            .onTapGesture { isFocused = true }
            
            HStack {
                Button(action: viewModel.resendCode) {
                    Text("Kodu yenidən göndər")
                        .font(.system(size: 14))
                        .foregroundColor(viewModel.isTimerRunning ? .gray : .blue)
                }
                .disabled(viewModel.isTimerRunning)
                
                Spacer()
                
                Text(viewModel.timeString(from: viewModel.timeRemaining))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(red: 77/255, green: 182/255, blue: 172/255))
            }
            
            Spacer()
            
            Button(action: viewModel.verifyOTP) {
                Text("Təsdiqlə")
                    .font(.system(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.otpCode.count == viewModel.otpLength ? Color(red: 77/255, green: 182/255, blue: 172/255) : Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(viewModel.otpCode.count != viewModel.otpLength)
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 24)
        .onAppear { isFocused = true }
    }
    
    @ViewBuilder
    func otpCharacter(at index: Int) -> some View {
        let char = viewModel.otpCode.count > index ?
            String(viewModel.otpCode[viewModel.otpCode.index(viewModel.otpCode.startIndex, offsetBy: index)]) : ""
        
        Text(char)
            .font(.system(size: 20, weight: .bold))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(viewModel.otpCode.count == index ? Color(red: 77/255, green: 182/255, blue: 172/255) : Color.gray.opacity(0.2), lineWidth: 2)
            )
    }
}
