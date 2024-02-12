//
//  CoreDataManager.swift
//  Sample
//
//  Created by chandrashekhar_h on 12/02/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Sample")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func savePost(id: Int64, title: String, body: String) {
        let context = persistentContainer.viewContext
        let post = CDPost(context: context)
        post.id = id
        post.title = title
        post.body = body
        do {
            try context.save()
        } catch {
            print("Failed to save post: \(error)")
        }
    }
    
    func fetchPosts() -> [CDPost] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CDPost> = CDPost.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch posts: \(error)")
            return []
        }
    }
    
    func convertToPosts(cdPosts: [CDPost]) -> [Post] {
        return cdPosts.map { cdPost in
            // Assuming 'id', 'title', and 'body' are non-optional in Post, provide default values if nil
            Post(id: Int(cdPost.id),
                 title: cdPost.title ?? "Untitled",
                 body: cdPost.body ?? "No content")
        }
    }
}


