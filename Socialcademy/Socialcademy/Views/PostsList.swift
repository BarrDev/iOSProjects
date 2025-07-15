//
//  ContentView.swift
//  Socialcademy
//
//  Created by Joe L Barr on 3/10/24.
//

import SwiftUI
import Foundation

struct PostsList: View {
    @StateObject var viewModel = PostsViewModel()
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationStack {
                if viewModel.posts == .loading {
                    ContentView()
                }
            else if viewModel.posts == .error {
                    EmptyListView(
                        title: "Cannot Load Posts",
                        message: "error.localizedDescription",
                        retryAction: {
                            viewModel.fetchPosts()
                        }
                    )
                }
                else if viewModel.posts == .empty {
                    EmptyListView(
                        title: "EMPTY Load Posts",
                        message: "EMPTY",
                        retryAction: {
                            viewModel.fetchPosts()
                        }
                    )
                }
                else{
                    List(viewModel.posts) { post in
                        if searchText.isEmpty || post.contains(searchText) {
                            PostRow(post: post, deleteAction: {})
                        }
                    }
                    .searchable(text: $searchText)
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                Button {
                    showNewPostForm = true
                } label: {
                    Label("New Post", systemImage: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm(createAction: viewModel.makeCreateAction())
        }
    }
}

#if DEBUG
struct PostsList_Previews: PreviewProvider {
    static var previews: some View {
        ListPreview(state: .loaded([Post.testPost]))
        ListPreview(state: .empty)
        ListPreview(state: .error)
        ListPreview(state: .loading)
    }
    
    @MainActor
    private struct ListPreview: View {
        let state: Loadable<[Post]>
        
        var body: some View {
            let postsRepository = PostsRepositoryStub(state: state)
            let viewModel = PostsViewModel(postsRepository: postsRepository)
            PostsList(viewModel: viewModel)
        }
    }
}
#endif
