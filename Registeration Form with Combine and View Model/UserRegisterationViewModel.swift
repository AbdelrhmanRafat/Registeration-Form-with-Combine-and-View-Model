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
}
