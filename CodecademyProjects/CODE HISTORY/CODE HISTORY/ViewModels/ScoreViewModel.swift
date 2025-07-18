//
//  ScoreViewModel.swift
//  CODE HISTORY
//
//  Created by Joe L Barr on 1/15/24.
//

import Foundation

struct ScoreViewModel {
  let correctGuesses: Int
  let incorrectGuesses: Int

  var percentage: Int {
    (correctGuesses * 100 / (correctGuesses + incorrectGuesses))
  }
}

