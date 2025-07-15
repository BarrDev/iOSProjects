//
//  NewPostForm.swift
//  Socialcademy
//
//  Created by Joe L Barr on 3/10/24.
//

import SwiftUI

struct NewPostForm: View {
    typealias CreateAction = (Post) async throws -> Void
    let createAction: CreateAction
    
    @State private var post = Post(title: "", content: "", authorName: "")
    @State private var state = FormState.idle
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $post.title)
                    TextField("Author Name", text: $post.authorName)
                }
                Section("Content") {
                    TextEditor(text: $post.content)
                        .multilineTextAlignment(.leading)
                }
                Button(action: createPost) {
                    if state == .working {
                        ProgressView()
                    } else {
                        Text("Create Post")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.primary)
                            .padding()
                            .background(LinearGradient(colors: [Color.blue, Color.white, Color.accentColor], startPoint: UnitPoint(x: 0.1, y: 0.1), endPoint: UnitPoint(x: 1, y: 1)))
                    }
                }
                .onSubmit(createPost)
                .navigationTitle("New Post")
            }
        }
        .disabled(state == .working)
        .alert("Cannot Create Post", isPresented: $state.isError, actions: {}) {
            Text("Something went wrong!")
        }
    }
    private func createPost() {
        Task {
            state = .working
            do {
                try await createAction(post)
                dismiss()
            } catch {
                state = .error
                print("[NewPostForm] Cannot create post: \(error)")
            }
        }
    }
}

private extension NewPostForm {
    enum FormState {
        case idle, working, error
        
        var isError: Bool {
            get {
                self == .error
            }
            set {
                guard !newValue else { return }
                self = .idle
            }
        }
    }
}

#Preview {
    NewPostForm(createAction: {_ in })
}
