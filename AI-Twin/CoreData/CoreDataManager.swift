//
//  CoreDataManager.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import Foundation
import CoreData

// Синглтон-клас для роботи з Core Data
class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    // Ініціалізація контейнера Core Data
    private init() {
        container = NSPersistentContainer(name: "SessionModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ Core Data failed to load: \(error)")
            }
        }
    }
    // Контекст для взаємодії з бд
    var context: NSManagedObjectContext {
        container.viewContext
    }
    // Збереження змін у контексті
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}



