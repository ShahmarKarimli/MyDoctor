//
//  PaymentView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 20.02.26.
//

import SwiftUI

struct PaymentView: View {
    @StateObject private var viewModel: PaymentViewModel
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: StateObject<PaymentViewModel>) {
        _viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Ödəniş üsulu")
                        .font(.system(size: 16, weight: .medium))
                    
                    // Payment Methods
                    VStack(spacing: 12) {
                        PaymentMethodRow(title: "Credit card", icon: "visaMastercard", isSelected: viewModel.selectedMethod == .creditCard) {
                            withAnimation(.easeInOut) {
                                viewModel.selectedMethod = .creditCard
                            }
                        }
                        PaymentMethodRow(title: "Google pay", icon: "googlePay", isSelected: viewModel.selectedMethod == .googlePay) {
                            withAnimation(.easeInOut) {
                                viewModel.selectedMethod = .googlePay
                            }
                        }
                        PaymentMethodRow(title: "Apple pay", icon: "applePay", isSelected: viewModel.selectedMethod == .applePay) {
                            withAnimation(.easeInOut) {
                                viewModel.selectedMethod = .applePay
                            }
                        }
                    }
                    
                    if viewModel.selectedMethod == .creditCard {
                        VStack(alignment: .leading, spacing: 15) {
                            InputField(label: "Kartın üzərindəki ad", text: $viewModel.cardHolderName, placeholder: "Nurida İsmayılova")
                            InputField(label: "Kart nömrəsi", text: $viewModel.cardNumber, placeholder: "4169 **** **** 0599")
                            
                            HStack(spacing: 20) {
                                InputField(label: "Bitmə tarixi", text: $viewModel.expiryDate, placeholder: "05/26")
                                InputField(label: "CVV", text: $viewModel.cvv, placeholder: "***")
                            }
                        }
                        .padding(.top, 10)
                        .transition(.move(edge: .top).combined(with: .opacity)) // Səlis açılış effekti
                    }
                    
                    InputField(label: "Ödəniləcək məbləğ", text: $viewModel.amount, placeholder: "30 AZN", isReadOnly: false)
                        .padding(.top, viewModel.selectedMethod == .creditCard ? 0 : 10)
                    
                    Button(action: { viewModel.processPayment() }) {
                        Text("Ödəniş et")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.35, green: 0.65, blue: 0.60))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
                .padding(25)
            }
        }
        .background(HekimimColors.background)
        .navigationTitle("Ödəniş et")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left").bold().foregroundColor(.teal)
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.navigateToSuccess) {
            PaymentSuccessView(viewModel: PaymentSuccessViewModel())
        }
    }
}

struct PaymentMethodRow: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? Color(red: 0.35, green: 0.65, blue: 0.60) : .gray)
                    .font(.system(size: 20))
                
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 15))
                
                Spacer()
                
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.1), lineWidth: 1)
            )
        }
    }
}

struct ReceiptRow: View {
    let label: String
    let value: String
    var body: some View {
        HStack {
            Text(label).foregroundColor(.gray)
            Spacer()
            Text(value).fontWeight(.medium)
        }
    }
}

struct InputField: View {
    let label: String
    @Binding var text: String
    let placeholder: String
    var isReadOnly: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.7))
            
            TextField(placeholder, text: $text)
                .disabled(isReadOnly) 
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.03), radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    NavigationStack {
        PaymentView(viewModel: StateObject(wrappedValue: PaymentViewModel()))
    }
}
