//
//  AuthPageView.swift
//  megastonks
//
//  Created by Kingsley Okeke on 2021-12-26.
//

import SwiftUI

struct AuthPageView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    @FocusState private var focusedField: ViewModel.RegisterMode?
    
    var body: some View {
        Color.megaStonksDarkGreen
            .ignoresSafeArea()
            .overlay(
                    VStack(spacing: 0) {
                        Image("logo")
                            .resizable()
                            .frame(width: 260, height: 260)
                            .offset(y: 20)

                        switch viewModel.mode {
                        case .loading:
                            ProgressView()
                                .accentColor(.green)
                                .scaleEffect(x: 1.4, y: 1.4)
                                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        case .login:
                            loginView()
                                .transition(.move(edge: .leading))
                            VStack(spacing: 10) {
                                Button(action: { viewModel.setMode(mode: .forgotPassword) }) {
                                    Text("Forgot Password?")
                                        .font(.custom("Poppins-Regular", fixedSize: 14))
                                        .foregroundColor(.megaStonksRed)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                
                                Button(action: {
                                    withAnimation(.linear(duration: 0.4)) {
                                        viewModel.setMode(mode: .register)
                                        focusedField = .email
                                    }
                                }) {
                                    Text("Register")
                                        .font(.custom("Poppins-Regular", fixedSize: 16))
                                        .foregroundColor(.megaStonksOffWhite)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            .padding(.top, 8)
                            .padding()
                        case .register:
                            VStack(spacing: 2) {
                                switch viewModel.registerMode {
                                case .email:
                                    registerViewEmail()
                                        .transition(.move(edge: .trailing))
                                case .password:
                                    registerViewPassword()
                                        .transition(.move(edge: .leading))
                                }
                                Text(viewModel.errorMessage)
                                    .font(.custom("Poppins-Regular", fixedSize: 14))
                                    .foregroundColor(.megaStonksRed)
                                    .padding(-20)
                                    .lineLimit(2)
                                Button(action: {
                                    withAnimation(.linear(duration: 0.4)) {
                                        viewModel.setMode(mode: .login)
                                        focusedField = nil
                                    }
                                } ) {
                                    HStack {
                                        Image(systemName: "arrow.left")
                                        Text("Login")
                                    }
                                    .font(.custom("Poppins-Regular", fixedSize: 16))
                                    .foregroundColor(.megaStonksOffWhite)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding()
                                }
                            }
                        case .forgotPassword:
                            EmptyView()
                            Button(action: {
                                viewModel.setMode(mode: .login)
                                focusedField = nil
                            }) {
                                HStack {
                                    Image(systemName: "arrow.left")
                                    Text("Login")
                                }
                                .font(.custom("Poppins-Regular", fixedSize: 16))
                                .foregroundColor(.megaStonksOffWhite)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding()
                            }
                        }
                 
                        Spacer()
                    }
            )
    }
    
    @ViewBuilder
    func button(text: String, fontSize: CGFloat = 18) -> some View {
        Text(text)
            .font(.custom("Poppins-Regular", fixedSize: fontSize))
            .foregroundColor(.white)
            .padding(.vertical, 6)
            .padding(.horizontal, 24)
            .background(Color.megaStonksLightGreen)
            .cornerRadius(20)
    }
    
    @ViewBuilder
    func loginView() -> some View {
        VStack(spacing: 30) {
            FormFieldView(formTitle: "Email Address", formText: $viewModel.emailLogin)
            FormFieldView(formTitle: "Password", isSecureField: true, formText: $viewModel.passwordLogin)
            Text(viewModel.errorMessage)
                .font(.custom("Poppins-Regular", fixedSize: 14))
                .foregroundColor(.megaStonksRed)
                .padding(-20)
                .lineLimit(2)
            Button (action: {
                focusedField = nil
            }) {
                button(text: "Login")
            }
        }
        .padding()
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder
    func registerViewEmail() -> some View {
        VStack(spacing: 30) {
            FormFieldView(formTitle: "User Name", formText: $viewModel.userNameRegister)
                .focused($focusedField, equals: .email)
            FormFieldView(formTitle: "Email Address", formText: $viewModel.emailRegister)
            Text(viewModel.errorMessage)
                .font(.custom("Poppins-Regular", fixedSize: 14))
                .foregroundColor(.megaStonksRed)
                .padding(-20)
                .lineLimit(2)
            
            Button (action: {
                withAnimation(.linear(duration: 0.4)) {
                    viewModel.setRegisterMode(mode: .password)
                    focusedField = .password
                } } ) {
                button(text: "Next")
            }
        }
        .padding()
        .padding(.horizontal, 30)
    }
    
    func registerViewPassword() -> some View {
        VStack(spacing: 30) {
            FormFieldView(formTitle: "Password", formText: $viewModel.passwordRegister)
                .focused($focusedField, equals: .password)
            FormFieldView(formTitle: "Confirm Password", formText: $viewModel.confirmPasswordRegister)
            
            VStack(spacing: 0) {
                Text(viewModel.errorMessage)
                    .font(.custom("Poppins-Regular", fixedSize: 14))
                    .foregroundColor(.megaStonksRed)
                    .padding(-20)
                    .lineLimit(2)
                HStack{
                    if viewModel.didOpenTerms {
                        Button(action: { viewModel.toggleTerms() })
                        {
                            Image(systemName: viewModel.didAcceptTerms ? "checkmark.square.fill" : "square")
                                .foregroundColor(.megaStonksGreen)
                        }
                    }
                    
                    Button(action: {
                        hideKeyboard()
                        viewModel.openTerms()
                        viewModel.toggleTermsSheet()
                    })
                    {
                        Text("TERMS AND CONDITIONS")
                            .font(.custom("Poppins-SemiBold", fixedSize: 14))
                            .foregroundColor(.white)
                    }
                    .sheet(isPresented: $viewModel.showTermsSheet) {
                        TermsSheet()
                    }
                }
                HStack(spacing: 20) {
                    Button (action: { withAnimation(.linear(duration: 0.4)) { viewModel.setRegisterMode(mode: .email) } } ) {
                        button(text: "Back")
                    }
                    Button (action: {}) {
                        button(text: "Register")
                    }
                }
                .padding(.top, 10)
            }
            .padding(.top, -10)
        }
        .padding()
        .padding(.horizontal, 30)
    }
}

struct TermsSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Color.megaStonksDarkGreen
            .ignoresSafeArea()
            .overlay(
                VStack{
                    ScrollView{
                        VStack{
                            Spacer()
                            Text("Terms and Conditions")
                                .font(.custom("Poppins-SemiBold", fixedSize: 20))
                                .foregroundColor(.megaStonksOffWhite)
                            Spacer()
                            Text(EULA.eula)
                                .font(.custom("Poppins-SemiBold", fixedSize: 14))
                                .foregroundColor(.megaStonksOffWhite)
                                .multilineTextAlignment(.center)
                            Spacer()
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Text("Press to Dismiss")
                                    .font(.custom("Poppins-SemiBold", fixedSize: 14))
                                    .foregroundColor(.megaStonksGreen)
                            })
                        }.padding(.horizontal, 20)
                    }
                }
            )
        
    }
}


struct AuthPageView_Previews: PreviewProvider {
    static var previews: some View {
        AuthPageView()
    }
}
