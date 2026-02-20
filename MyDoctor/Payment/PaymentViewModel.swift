//
//  PaymentViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 20.02.26.
//

import Foundation
import Combine

class PaymentViewModel: ObservableObject {
    @Published var selectedMethod: PaymentMethod = .creditCard
    @Published var cardHolderName: String = ""
    @Published var cardNumber: String = ""
    @Published var expiryDate: String = ""
    @Published var cvv: String = ""
    @Published var amount: String = "30 AZN"
    
    @Published var navigateToSuccess: Bool = false
    
    enum PaymentMethod {
        case creditCard, googlePay, applePay
    }
    
    var isFormValid: Bool {
        !cardHolderName.isEmpty && cardNumber.count >= 16 && cvv.count == 3
    }
    
    func processPayment() {
        navigateToSuccess = true
    }
}
