//
//  FormViewModel.swift
//  Socialcademy
//
//  Created by Joe Barr on 3/23/24.
//

import Foundation

@MainActor
@dynamicMemberLookup
class FormViewModel<Value>: ObservableObject, StateManager {
    typealias Action = (Value) async throws -> Void
    
    @Published var value: Value
    @Published var error: Error?
    @Published var isWorking = false
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> T {
        get { value[keyPath: keyPath] }
        set { value[keyPath: keyPath] = newValue }
    }
    
    private let action: Action
    
    init(initialValue: Value, action: @escaping Action) {
        self.value = initialValue
        self.action = action
    }
    
    nonisolated func submit() {
        withStateManagingTask { [self] in
            try await action(value)
        }
    }
}
