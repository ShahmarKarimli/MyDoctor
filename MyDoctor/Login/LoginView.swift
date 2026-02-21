import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var navigateToRecovery = false 
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            VStack(spacing: 0) {
                HStack {
                    
                    
                    Image("hospitalLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .padding(.top, 5)
                }
                
                Text("Daxil ol")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                    .padding(.top, 30)
                
                ScrollView {
                    VStack(spacing: 0) {
                        AuthFormView(
                            mode: .login,
                            name: .constant(""),
                            email: $viewModel.email,
                            password: $viewModel.password,
                            isLoading: viewModel.isLoading,
                            emailError: viewModel.errorMessage,
                            action: {
                                viewModel.handleLogin()
                            },
                            forgotAction: {
                                navigateToRecovery = true
                            }
                        )
                    }
                    .padding(.top, 30)
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .bold()
                            .foregroundColor(.teal)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                HomeView()
            }
            
            .navigationDestination(isPresented: $navigateToRecovery) {
                NewPasswordView(email: viewModel.email)
            }
        }
    }
}
