//
//  PaymentSuccess.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 20.02.26.
//

import SwiftUI

struct PaymentSuccessView: View {
    @StateObject var viewModel: PaymentSuccessViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 20) {
                Text("Uğurlu əməliyyat!")
                    .font(.system(size: 22, weight: .bold))
                
                Image("checkSuccess")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(red: 0.35, green: 0.65, blue: 0.60))
                
                Divider()
                
                VStack(spacing: 15) {
                    ReceiptRow(label: "Xəstəxana:", value: viewModel.hospitalName)
                    ReceiptRow(label: "Müayinə növü:", value: viewModel.appointmentType)
                    ReceiptRow(label: "Tarix:", value: viewModel.date)
                    ReceiptRow(label: "Saat:", value: viewModel.time)
                    ReceiptRow(label: "Məbləğ:", value: viewModel.amount)
                }
                .padding(.top, 10)
            }
            .padding(30)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button(action: { }) {
                VStack {
                    Image("sharePaymentReceipt")
                        .cornerRadius(10)
                    Text("Göndər")
                        .foregroundColor(.black)
                }
            }
            .padding(.bottom, 48)
        }
        .padding(.top, 48)
        .background(Color(red: 0.95, green: 0.98, blue: 0.97).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left").foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { }) {
                    Image("chatIcon")
                }
            }
        }
    }
}



#Preview {
    NavigationStack {
        PaymentSuccessView(viewModel: PaymentSuccessViewModel())
    }
}
