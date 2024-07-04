//
//  CoreDataManager.swift
//  TestCoreData
//
//  Created by Vineeth on 04/07/24.
//

import CoreData

class CoreDataManager {
    private init() {
    }
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveDocuments(documents: [Document]) {
        let context = persistentContainer.viewContext
        documents.forEach { document in
            let userDocument = UserDocument(context: context)
            userDocument.title = document.title
            userDocument.discription = document.abstract
            userDocument.date = document.formattedDate
            userDocument.url = document.mediaUrl
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getDocuments() -> [UserDocument] {
        let context = persistentContainer.viewContext
        let request = UserDocument.fetchRequest()
        do {
            let userDocuments = try context.fetch(request) as [UserDocument]
            return userDocuments
        } catch {
            return []
        }
    }
    
    func deleteDocuments() {
        let context = persistentContainer.viewContext
        let userDocuments = getDocuments()
        userDocuments.forEach { document in
            context.delete(document)
        }
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
