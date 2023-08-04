//
//  AuthCombine.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/02/2023.
//

import SwiftUI

struct AuthCombineView : View {
    @StateObject  var viewModel = AuthViewModel()
    
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            
            VStack{
                
                Text("Grocery")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                AuthTextField(inputValue : $viewModel.userName,
                              title : "User name",
                              error : viewModel.userNameError)
                
                AuthTextField(inputValue : $viewModel.email,
                              title : "Email",
                              error : viewModel.emailError,
                              keyboardType : .emailAddress)
                
                AuthTextField(inputValue : $viewModel.password,
                              title : "Password",
                              error : viewModel.passwordError,
                              isSecured : true)
                
                AuthTextField(inputValue : $viewModel.confirmedPassword,
                              title : "Confirm password",
                              error : viewModel.confirmPasswordError,
                              isSecured : true)
                
                Button(action: signUp) {
                    Text("Sign Up")
                }
                .frame(maxWidth : .infinity)
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .cornerRadius(.infinity)
                .padding(.vertical, 20)
            }
            .padding(40)
        }
    }
    
    func signUp(){
        viewModel.isValidAll() ? print("valid all.") : print("Error happen.")
    }
}

struct AuthCombine_Previews: PreviewProvider {
    static var previews: some View {
        AuthCombineView()
    }
}

//MARK: - components
struct AuthTextField: View {
    @Binding var inputValue : String
    var title : String
    var error : String
    var isSecured = false
    var keyboardType : UIKeyboardType = .default
    
    var body: some View {
        VStack {
            if isSecured{
                SecureField(title, text: $inputValue)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
            }
            else{
                TextField(title, text: $inputValue)
                    .padding()
                    .background(.white)
                    .cornerRadius(10)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
            }
            
            Text(error)
                .fontWeight(.bold)
                .foregroundColor(.red.opacity(0.65))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

//MARK: - view model
import Combine

class AuthViewModel : ObservableObject {
    @Published var userName : String = ""
    var userNameError : String = ""
    
    @Published var email : String = ""
    var emailError : String = ""
    
    @Published var password : String = ""
    var passwordError : String =  ""
    
    @Published var confirmedPassword : String = ""
    var confirmPasswordError : String = ""
    
    private var disposeBag = Set<AnyCancellable>()
    
    //user name
    private var userNameRequiredPublisher : AnyPublisher<Bool, Never>{
        return $userName
            .map { !$0.isEmpty } //.map{} used to transform the values emitted by a publisher into a new set of values.
            .eraseToAnyPublisher()
    }
    //email
    private var emailRequiredPublisher : AnyPublisher<(email : String, isValid : Bool), Never>{
        return $email
            .map{(email : $0, isValid : !$0.isEmpty)}
            .eraseToAnyPublisher()
    }
    private var emailValidPublisher : AnyPublisher<(email : String, isValid : Bool), Never>{
        return emailRequiredPublisher
            .filter{$0.isValid}
            .map{(email : $0.email, isValid : $0.email.isValidEmail())}
            .eraseToAnyPublisher()
    }
    //password
    private var passwordRequiredPublisher : AnyPublisher<(password : String, isValid : Bool), Never>{
        return $password
            .map{(password : $0, isValid : !$0.isEmpty)}
            .eraseToAnyPublisher()
    }
    private var passwordValidPublisher : AnyPublisher<Bool, Never>{
        return passwordRequiredPublisher
            .filter{$0.isValid}
            .map{$0.password.isValidPassword()}
            .eraseToAnyPublisher()
    }
    //confirm password
    private var confirmPasswordRequiredPublisher : AnyPublisher<(confirmPw : String, isValid : Bool), Never>{
        return $confirmedPassword
            .map{(confirmPw : $0, isValid : !$0.isEmpty)}
            .eraseToAnyPublisher()
    }
    private var confirmPasswordEqualPublisher : AnyPublisher<Bool, Never>{
        return Publishers.CombineLatest($password, $confirmedPassword)
            .filter{ !$0.0.isEmpty && !$0.1.isEmpty}
            .map{ password, confirmPassword in
                return password == confirmPassword
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        userNameRequiredPublisher.receive(on: RunLoop.main)
            .dropFirst()
            .map { isValid in
                isValid ? "" : "User name is missing"
            }
            .assign(to: \.userNameError, on: self)
            .store(in: &disposeBag)
        
        emailRequiredPublisher.receive(on: RunLoop.main)
            .dropFirst()
            .map { args in args.isValid ? "" : "Email is missing"}
            .assign(to: \.emailError, on: self)
            .store(in: &disposeBag)
        
        emailValidPublisher.receive(on: RunLoop.main)
            .map { args in args.isValid ? "" : "Email is not valid"}
            .assign(to: \.emailError, on: self)
            .store(in: &disposeBag)

        passwordRequiredPublisher.receive(on: RunLoop.main)
            .dropFirst()
            .map { args in args.isValid ? "" : "Password is missing"}
            .assign(to: \.passwordError, on: self)
            .store(in: &disposeBag)

        passwordValidPublisher.receive(on: RunLoop.main)
            .map { isValid in isValid ? "" : "Password must be 8 characters with 1 alphabet and 1 number"}
            .assign(to: \.passwordError, on: self)
            .store(in: &disposeBag)
        
        confirmPasswordRequiredPublisher.receive(on: RunLoop.main)
            .dropFirst()
            .map { args in args.isValid ? "" : "Password is missing"}
            .assign(to: \.confirmPasswordError, on: self)
            .store(in: &disposeBag)
        
        confirmPasswordEqualPublisher.receive(on: RunLoop.main)
            .map { isSame in
                isSame ? "" : "Confirm password doesn't match."
            }
            .assign(to: \.confirmPasswordError, on: self)
            .store(in: &disposeBag)
    }
    
    
    func isValidAll() -> Bool{
        return false
    }
    
    deinit{ // memory management
        disposeBag.removeAll()
    }
}
