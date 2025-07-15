//
//  WelcomeView.swift
//  CODE HISTORY
//
//  Created by Joe L Barr on 1/13/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                GameColor.main.ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Select the correct answers to the following questions.")
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding()
                    }
                    Spacer()
                    Spacer()
                    NavigationLink(destination: GameView(), label: {
                        BottomTextView(str: "Okay let's go!")
                    })
                }
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
