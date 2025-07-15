//
//  ContentView.swift
//  Binding
//
//  Created by Joe L Barr on 1/14/24.
//

import SwiftUI

struct ContentView: View {
    @State var backgroundColor: Color = Color.green
    @State var buttonPressed: Bool = false
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            ButtonView(backgroundColor: $backgroundColor, pressed: $buttonPressed)
        }
    }
}

struct ButtonView: View {
    @Binding var backgroundColor: Color
    @State var buttonColor: Color = .blue
    @Binding var pressed: Bool
    
    var body: some View {
        Button {
            if pressed {
                buttonColor = .cyan
                backgroundColor = .yellow
            }
        } label: {
            Text("Button")
                .foregroundStyle(.white)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 4)
                .background(buttonColor)
        }    }
}

#Preview {
    ContentView()
}
