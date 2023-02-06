//
//  ContentView.swift
//  Registeration Form with Combine and View Model
//
//  Created by Macbook on 05/02/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var userRegisterationViewModel = UserRegisterationViewModel()
    var body: some View {
        VStack {
            HeaderView()
            UserNameView(userRegisterationViewModel: userRegisterationViewModel)
            PasswordView(userRegisterationViewModel: userRegisterationViewModel)
            PasswordConfirmView(userRegisterationViewModel: userRegisterationViewModel)
            Button(action: {
                // To Next Screen
            }) {
            }.buttonStyle(LongButtonStyle())
            HStack{
                Text("Already have an Account?")
                    .font(.system(.body, design: .rounded))
                    .bold()
                Button(action: {
                    //To Sign IN Screen
                }){
                }.buttonStyle(TextButtonStyle())
            }
            .padding(.top,50)
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RequirmentText : View {
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    var text = ""
    var isStrikeThrough = false
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
            Text(text)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.secondary)
                .strikethrough(isStrikeThrough) // Applies strike through on text based on Boolean Argument.Default value for strike through is true.
            Spacer()
        }
    }
}

struct FormField : View {
    var fieldName = ""
    @Binding var fieldValue : String
    var isSecure = false
    var body: some View {
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue) // Secure Field Automatically masks the user's input.
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            }
            else {
                TextField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            }
            Divider() // Line After Text Field.
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
        }
    }
}
struct HeaderView : View {
    var body: some View {
        Text("Create an Account")
            .font(.system(.largeTitle, design: .rounded))
            .bold()
            .padding(.bottom,30)
    }
}
struct UserNameView : View {
    @ObservedObject var userRegisterationViewModel : UserRegisterationViewModel
    var body: some View {
        FormField(fieldName: "UserName", fieldValue: $userRegisterationViewModel.username)
        RequirmentText(iconColor: userRegisterationViewModel.isUserNameLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255),text: "A minimum of 4 characters",isStrikeThrough: userRegisterationViewModel.isUserNameLengthValid)
            .padding()
    }
}
struct PasswordView : View {
    @ObservedObject var userRegisterationViewModel : UserRegisterationViewModel
    var body: some View {
        FormField(fieldName: "Password", fieldValue: $userRegisterationViewModel.password, isSecure: true)
        VStack(spacing: 5) {
            RequirmentText(iconName: "lock.open",iconColor: userRegisterationViewModel.isPasswordLengthValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 8 characters", isStrikeThrough: userRegisterationViewModel.isPasswordLengthValid)
            RequirmentText(iconName: "lock.open", iconColor: userRegisterationViewModel.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "One Uppercase Letter", isStrikeThrough: userRegisterationViewModel.isPasswordCapitalLetter)
        }
        .padding()
    }
}
struct PasswordConfirmView : View {
    @ObservedObject var userRegisterationViewModel : UserRegisterationViewModel
    var body: some View {
        FormField(fieldName: "Confirm Password", fieldValue: $userRegisterationViewModel.passwordConfirm, isSecure: true)
        RequirmentText(iconColor: userRegisterationViewModel.isPasswordConfirmValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text:"Your confirm password should be the same as password", isStrikeThrough: userRegisterationViewModel.isPasswordConfirmValid)
            .padding()
            .padding(.bottom,50)
    }
}
struct LongButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Text("Sign Up")
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .bold()
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}
struct TextButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Text("Sign in")
            .font(.system(.body, design: .rounded))
            .bold()
            .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
    }
}
