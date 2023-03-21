# Registration Form Using Swift UI & Combine Framework

![enter image description here](https://i.postimg.cc/FzNn3SJJ/Screen-Shot-2023-03-21-at-6-14-26-PM.png)

## Table of Contents

**1**  **Introduction For Application and Document**
**2**  **Implementation of the application interface**
**3**  **About  MVVM Design Pattern**
**4**  **Brief about Combine Framework**
**5**  **User Registration View Model**
**6**  **Connect view model with view**

## Introduction For Application and Document
It's very common to have a user registration Form for people to sign up an account. This Repo Represent how you will implement the form validation Using Combine Frame Work and MVVM Design Pattern.

The most Important thing you get to know before we dive into code demonstration that combine framework provides a declarative API for processing values over time.

This document will discuss every line of code regarding the implementation of the application interface "View", and how to check the Validation of data "View Model" Finally how we connect the view with view model.

## Implementation of the Application Interface
First there’s 3 Variables annotated with @State  private

Swift UI comes with built in features for state management in particular it introduce a property wrapper named @state,

When state changes swift UI will recompute these views and update application.
![enter image description here](https://i.postimg.cc/T30MG6yg/Picture3.png)
(Username, Password, Password Confirm) hold data that User will enter in Text fields.

You can only access @state property from inside the view’s body or from function called by it for this reason you should declare your @state properties as private to prevent clients of your view from accessing it.

Then you start Implementing layout inside view’s body with VStack Container That’s contain all Objects each object is customized by modifiers.

Text --> Object Represent Read Only information on Screen.
Form Field --> Struct represent view of Text Field.
Requirement Text --> Struct Represent view of text under Text Field.

The reason for prefixing username with $Username to get binding from state variable and you will get to know what’s mean by binding when I came to demonstrate Form Field View.
![enter image description here](https://i.postimg.cc/6qfvW0DH/Picture4.png)

**Form Field**
I will just focus on @binding var fieldValue Property

When property is annotate by @binding it indicates that the caller must provide the binding of the state variable by doing so it’s just like creating two way connection between (username) variables in content view and fieldValue in FormField View.

Then It comes with VStack Container. Represent Secure Field or Text Field based on isSecure Boolean value.

Text Field --> is initiated with field name and binding this renders an editable text field with the user’s input stored in your given binding.
Secure Field --> same as text field except that Secure field automatically masks the user’s input.
Divider --> Create a line use frame modifier to control it’s dimensions.
![enter image description here](https://i.postimg.cc/QM7kLpxz/Picture6.png)

**Requirement Text View**
Hstack Container contains Image and text and also Spacer

Spacer --> In UIKit, you would define auto layout constraints to position the views Swift UI doesn’t have auto layouts instead it provides view called spacer.
![enter image description here](https://i.postimg.cc/TwGkCkq0/Picture7.png)

**Sign Up Button**

Buttons In Swift UI --> As known Buttons initiate app Specific actions.

You can write app action in closure after action argument.

Then start Implement Button Interface,

Text with white color and Gradient Background, the order of modifiers is very Important One thing I want to highlight is that the padding modifier should be placed before the background modifier.

In Swift UI you can easily add Gradient background all you need is to add Linear Gradient argument for background.

![enter image description here](https://i.postimg.cc/0QMpGDhn/Picture8.png)
**Sign In Button**
Finally Inside H-Stack Container there’s Text and Button.
![enter image description here](https://i.postimg.cc/fRSDNL4F/Picture9.png)
Enough about Interface and let's dive into Code Actions which will be written in User Registration View model but First I will introduce to you brief about MVVM and Combine Frame work.

## About MVVM Design Pattern
MVVM (Model-View-ViewModel) is a design pattern that separates the user interface (UI) from the business logic of an application. It can solve several issues, including: 
1. Separation of Concerns: MVVM separates the UI from the business logic, making it easier to maintain and test each component separately. 
2. Scalability: MVVM allows for easy scaling of applications by adding new views and view models without affecting the existing code. 
3. Code Reusability: MVVM promotes code reusability as the same view model can be used across multiple views. 
4. Improved Collaboration: MVVM allows developers to work on different parts of an application simultaneously, improving collaboration and productivity. 
5. Enhanced User Experience: By separating the UI from business logic, MVVM can improve user experience by making applications more responsive and efficient. 

MVVM should be used because it provides a clear separation between UI and business logic, making it easier to maintain, test, and scale applications. It also promotes code reusability and collaboration among developers, resulting in better productivity and faster development cycles.

## Brief about Combine Framework

The Combine Frame work provides declarative approach for how your app processes events rather than Implementing multiple delegate call backs or completion handler closures, you can create single processing chain for a given event Source each part of chain is distinct action on the elements received from the Previous step.

**Publishers and subscribers are the two core elements of the framework**

Publisher sends event and subscriber subscribe to receive values from that Publisher.


## User Registration View Model
First let’s state what we need to do We have 3 text fields username, password , confirm password
 - User Name (Must be consist of Minimum of 4 characters)
 - Password (Must be consist of Minimum of 8 characters)
 - Password (Must have at least one upper case letter)
 - Confirm Password (Must be same as password)

To Get more understanding for combine frame work read this before we dive in code demonstration.

**It is possible to have both publishers and subscribers in the same class in Combine framework.**

In Combine, publishers and subscribers are used to create and manage streams of data. Publishers emit values that can be subscribed to by subscribers, which then receive and process those values.

A class can have multiple properties that act as publishers, allowing it to emit multiple streams of data. Similarly, a class can have multiple properties that act as subscribers, allowing it to receive and process multiple streams of data.

Having both publishers and subscribers in the same class can be useful in cases where the class needs to manage the flow of data between different parts of the application. However, it is important to ensure that the class is designed in a way that is easy to understand and maintain, and that the responsibilities of each property are clearly defined.

**Let’s start know about  User Registration view model class**

Observable object --> this is a protocol of the Combine framework.

By implementing this protocol, the object can serve as a publisher that emits the changed value.

Those subscribers that monitor the value change will get notified.

The first three Properties (username, Password, Password Confirm) are annotated by @Published You may wonder @Published works pretty much like @State in SwiftUI. While it works pretty much the same for this example, @State can only apply to properties that belong to a specific SwiftUI view. If you want to create a custom type that doesn't belong to a specific view or that can be used among multiple views, you need to create a class that conforms to ObservableObject and mark those properties with the @Published annotation. Those properties will be the binding values of text fields and subscriber will receive these values listen to changes and triggers event based on the publisher value.
![enter image description here](https://i.postimg.cc/nzvxgwDP/Picture10.png)
The other Boolean values are output values computed based on input values, The output values are also annotated with @Published. This is because when the view subscribes to these values, get notified and recomputes itself and updates the view accordingly.

**Let’s define the process again briefly before we discuss the Validation Function.**

What we need to do is to Update view when User Enters value in Text fields using Publisher and subscriber concept.
![enter image description here](https://i.postimg.cc/ZqSVj7JR/Picture11.png)
**Validation Function is the Missing Piece**

_username_ and _isUsernameLengthValid are both annotated by @Published but they are found in two different places in block diagram_

The username publisher emits value changes whenever the user keys in a keystroke in the username field. The isUsernameLengthValid publisher informs the subscriber ( Registration View) about the validation status of the user input.

Nearly all controls in SwiftUI are subscribers, so the requirement text view will listen to the change of validation result and update its style

**Validation Function**
![enter image description here](https://i.postimg.cc/RFc4wgQ4/Picture12.png)
The First line sets up the publisher to listen for changes in the `$username` value, and ensures that the subscriber receives values on the main thread.

The `map` operator takes the input value and transforms it into a Boolean value that indicates whether the length of the username is greater than or equal to 4 characters.

The line assigns the Boolean value to the `isUserNameLengthValid` property of the current object.

The `store` function saves the cancellable reference into a set, which allows it to be canceled later when it is no longer needed.

## Connect view model with view

![enter image description here](https://i.postimg.cc/x8c5W4xS/Picture13.png)
We Substitute all state properties by @ObservedObject to User Registration view model
In the Combine framework, `@ObservedObject` is a property wrapper that allows a SwiftUI view to observe changes to an instance of an observable object. An observable object is a class that conforms to the `ObservableObject` protocol, which allows it to publish changes to its properties when they are updated.

When a view is marked with `@ObservedObject`, it subscribes to the observable object and is automatically updated whenever the object's properties change. This allows the view to stay in sync with the object's state and update its contents accordingly.

After the View Subscribe to View Model Properties
![enter image description here](https://i.postimg.cc/kGvSYF9d/Picture14.png)

The View Could easily subscribe to publisher properties and update it self accordingly.
