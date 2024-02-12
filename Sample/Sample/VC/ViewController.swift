//
//  ViewController.swift
//  Sample
//
//  Created by chandrashekhar_h on 12/02/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var postViewModel: PostViewModel!
           
    override func viewDidLoad() {
               super.viewDidLoad()
               self.postViewModel = PostViewModel()
            tableView.estimatedRowHeight = 100 // Use a reasonable estimate
            tableView.rowHeight = UITableView.automaticDimension
        
               self.postViewModel.bindPostsViewModelToController = {
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }
               self.postViewModel.fetchPosts()
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell else {
            fatalError("Could not dequeue cell with identifier: CellIdentifier")
        }
        let post = postViewModel.postAt(indexPath: indexPath)
        cell.titleLabel.text = post.title
        return cell
    }
}


class PostCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
}

