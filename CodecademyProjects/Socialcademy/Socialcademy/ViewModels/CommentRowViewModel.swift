//
//  CommentRowViewModel.swift
//  Socialcademy
//
//  Created by Joe Barr on 3/23/24.
//

import Foundation

@MainActor
@dynamicMemberLookup
class CommentRowViewModel: ObservableObject, StateManager {
    typealias Action = () async throws -> Void
    
    @Published var comment: Comment
    @Published var error: Error?
    
    var canDeleteComment: Bool { deleteAction != nil }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Comment, T>) -> T {
        comment[keyPath: keyPath]
    }
    
    private let deleteAction: Action?
    
    init(comment: Comment, deleteAction: Action?) {
        self.comment = comment
        self.deleteAction = deleteAction
    }
    
    func deleteComment() {
        guard let deleteAction = deleteAction else {
            preconditionFailure("Cannot delete comment: no delete action provided")
        }
        withStateManagingTask(perform: deleteAction)
    }
}
