//
//  CustomBackButtonView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 05.02.26.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button(action: {
            dismiss()
        }) {
            HStack(spacing: 5) {
                Image(systemName: "chevron.left")
                    .fontWeight(.semibold)
                Text("Back")
            }
            .foregroundColor(.blue) 
            .padding(.vertical, 10)
        }
    }
}
