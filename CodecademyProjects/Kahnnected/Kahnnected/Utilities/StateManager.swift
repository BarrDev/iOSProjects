//
//  StateManager.swift
//  Kahnnected
//
//  Created by Joe Barr on 6/21/23.
//

import Foundation
import FirebaseStorage

@MainActor
protocol StateManager: AnyObject {
    var error: Error? { get set }
    var isWorking: Bool { get set }
}

extension StateManager {
    var isWorking: Bool {
        get { false }
        set {}
    }
}

extension StateManager {
    typealias Action = () async throws -> Void
    
    nonisolated func withStateManagingTask(perform action: @escaping Action) {
        Task {
            await withStateManagement(perform: action)
        }
    }
    
    private func withStateManagement(perform action: @escaping Action) async {
        isWorking = true
        do {
            try await action()
        } catch {
            print("[\(Self.self)] Error: \(error)")
            self.error = error
        }
        isWorking = false
    }
}
