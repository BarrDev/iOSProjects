//
//  ContentView.swift
//  ContactForm
//
//  Created by Joe L Barr on 1/18/24.
//

import SwiftUI
import Foundation

enum ContactMethods: String, CaseIterable {
    case email, phone
}

enum Subjects: String, CaseIterable {
    case Help, Suggestions, Bug
}


struct UpdateContentView: View {
    @State private var contactInfo = ""
    @State private var number = ""
    @State private var message = "Enter your message here: "
    @State private var subject = Subjects.Help
    @State private var includeLogs = false
    @State private var preferredContactMethod = ContactMethods.phone
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(content: {
                        Picker("Contact Method", selection: $preferredContactMethod) {
                            ForEach(ContactMethods.allCases, id: \.self) { method in
                                Text(method.rawValue)
                            }
                        }.pickerStyle(PalettePickerStyle())
                        
                        switch preferredContactMethod {
                        case .email:
                            TextField("Enter your email", text: $contactInfo)
                                .autocorrectionDisabled()
                                .textContentType(.emailAddress)
                        case .phone:
                            TextField("Enter your number", text: $number)
                                .keyboardType(.numberPad)
                        }
                    }, header: {Text("How should we contact you?")})
                    
                    Section(content: {
                        Picker("Subjects", selection: $subject) {
                            ForEach(Subjects.allCases, id: \.self) { subject in
                                Text(subject.rawValue)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }, header: {Text("What can we help you with?")})
                    
                    Section(content: {
                        TextEditor(text: $message)
                    }, header: {Text("Briefly explain the issue")})
                    
                    Section(content: {Toggle("Include Logs", isOn: $includeLogs)}, footer: {Text("This information will be sent anonymously")})
                    
                    Button("Submit") {
                        print("Submit Button Pressed")
                    }
                }
                .navigationTitle("Contact Us")
            }
        }
    }
}
/*
struct ContentView: View {
  @State private var emailAddress = ""
  @State private var phoneNumber = ""
  @State private var message = "Write your message here..."
  @State private var subject = "Help"
  @State private var includeLogs = false
  
  @State private var preferredContactMethod = ContactMethod.email
  
  enum ContactMethod {
    case email, phone
  }
  
  var body: some View {
    NavigationView {
      Form() {
        Section(header: Text("How can we reach you?")) {
          Picker("Contact Method", selection: $preferredContactMethod) {
            Text("Email").tag(ContactMethod.email)
            Text("Phone").tag(ContactMethod.phone)
          }
          .pickerStyle(SegmentedPickerStyle())
          switch preferredContactMethod {
          case .email:
            TextField("Email Address", text: $emailAddress)
              .textContentType(.emailAddress)
              .disableAutocorrection(true)
          case .phone:
            TextField("Phone Number", text: $phoneNumber)
          }
        }
        Section(header: Text("What can we help you with?")) {
          Picker("Subject", selection: $subject) {
            ForEach(["Help", "Suggestion", "Bug Report"], id: \.self) { subject in
              Text(subject)
            }
          }
          .pickerStyle(InlinePickerStyle())
        }
        Section(header: Text("Briefly explain what‘s going on.")) {
          TextEditor(text: $message)
        }
        Section(footer: Text("This information will be sent anonymously.")) {
          Toggle("Include Logs", isOn: $includeLogs)
        }
        Button("Submit", action: {
          print("Submit button tapped")
        })
      }
      .navigationTitle("Contact Us")
    }
  }
}

#Preview {
   ContentView()
}
*/

#Preview {
    UpdateContentView()
}
