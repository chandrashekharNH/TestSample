//
//  NetworkService.swift
//  Sample
//
//  Created by chandrashekhar_h on 12/02/24.
//

import Foundation
class NetworkService {
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(posts, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}

struct PostModel: Codable {
    let id: Int
    let title: String
    let body: String
    var isExpanded: Bool 
}
