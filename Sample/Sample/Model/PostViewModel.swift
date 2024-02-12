//
//  PostViewModel.swift
//  Sample
//
//  Created by chandrashekhar_h on 12/02/24.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}

class PostViewModel {
    private var posts: [Post] = [] {
        didSet {
            self.bindPostsViewModelToController()
        }
    }
    var bindPostsViewModelToController : (() -> ()) = {}
    func fetchPosts() {
        NetworkService().fetchPosts { [weak self] (posts, error) in
            guard let self = self, let posts = posts else { return }
            DispatchQueue.main.async {
                          for post in posts {
                              CoreDataManager.shared.savePost(id: Int64(post.id), title: post.title, body: post.body)
                          }
                          let post = CoreDataManager.shared.fetchPosts()
                         self.posts = CoreDataManager.shared.convertToPosts(cdPosts: post)
                      }
        }
    }
    func numberOfRowsInSection(section: Int) -> Int {
        return posts.count
    }
    func postAt(indexPath: IndexPath) -> Post {
        return posts[indexPath.row]
    }
}
