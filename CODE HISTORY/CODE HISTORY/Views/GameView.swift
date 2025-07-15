//
//  ContentView.swift
//  CODE HISTORY
//
//  Created by Joe L Barr on 1/13/24.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                GameColor.main.ignoresSafeArea()
                VStack {
                    Text(viewModel.questionProgressText)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .padding()
                    QuestionView(question: viewModel.currentQuestion)
                }
                .foregroundColor(.white)
                .navigationBarHidden(true)
                .environmentObject(viewModel)
            }
            .navigationDestination(isPresented: .constant(viewModel.gameIsOver), destination: { ScoreView(viewModel: ScoreViewModel(correctGuesses: viewModel.correctGuesses, incorrectGuesses: viewModel.incorrectGuesses))})
        }
    }
}
#Preview {
    GameView()
}
