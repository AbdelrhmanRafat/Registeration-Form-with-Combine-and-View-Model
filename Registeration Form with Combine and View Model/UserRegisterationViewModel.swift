//
//  UserRegisterationViewModel.swift
//  Registeration Form with Combine and View Model
//
//  Created by Macbook on 06/02/2023.
//

import Foundation
import Combine

class UserRegisterationViewModel : ObservableObject {
    //Input
    @Published var username = ""
    @Published var password = ""
    @Published var passwordConfirm = ""
    
    //Output
    @Published var isUserNameLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    //All Properties Annotated with @Published to notify the subscribers whenever there is a value change and perform the validation accordingly...
    private var cancellableSet : Set<AnyCancellable> = []
    
    
    init() {
        //$username --> is the source value change that we want to listen to.
        $username.receive(on: RunLoop.main) // to ensure the subscriber receives values on the main thread.
            .map { username in // map Function is known as an operator in combine that it takes an input processes it, and transforms the input into something the subscriber expects.
                return username.count >= 4
            }
            .assign(to: \.isUserNameLengthValid, on: self) // Assign Subscriber allows to update specific property of object.(It Assign Validation Result to Property)
            //assign function return cancellable instance.
            .store(in: &cancellableSet)// store function save the cancellable reference into a set for later cleanup
        $password.receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        $password.receive(on: RunLoop.main)
            .map {password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression){
                    return true
                }else{
                    return false
                }
            }.assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        Publishers.CombineLatest($password,$passwordConfirm)
            .receive(on: RunLoop.main)
            .map { (password, passwordConfirm) in
                return !passwordConfirm.isEmpty && (passwordConfirm == password)
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
}
