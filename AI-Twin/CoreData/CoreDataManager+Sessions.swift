//
//  CoreDataManager+Sessions.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 07/05/2025.
//

import Foundation
import CoreData

extension CoreDataManager {
    // Зберігаємо сесію
    func saveSession(_ session: Session) {
        // Перевіряємо, чи вже є така сесія в Core Data за її ID
        let request: NSFetchRequest<SessionEntity> = SessionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", session.id) // Фільтруємо по ID

        do {
            let existingSessions = try context.fetch(request)
            
            if let existingSession = existingSessions.first {
                // Якщо сесія вже існує, оновлюємо її дані
                existingSession.date = session.date
                existingSession.title = session.title
                existingSession.category = session.category
                existingSession.summary = session.summary
                print("✅ Updated existing session: \(session.title) on \(session.date)")
            } else {
                // Якщо сесія не існує, створюємо нову
                let entity = SessionEntity(context: context)
                entity.id = session.id
                entity.date = session.date
                entity.title = session.title
                entity.category = session.category
                entity.summary = session.summary
                print("✅ New session cached: \(session.title) on \(session.date)")
            }
            
            saveContext()
            
        } catch {
            print("❌ Failed to fetch or save session: \(error)")
        }
    }

    // Зберігаємо масив сесій
    func saveSessions(_ sessions: [Session]) {
        for session in sessions {
            saveSession(session)
        }
    }

    // Отримуємо кешовані сесії
    func fetchCachedSessions() -> [Session] {
        let request: NSFetchRequest<SessionEntity> = SessionEntity.fetchRequest()
        do {
            let entities = try context.fetch(request)
            print("✅ Loaded \(entities.count) cached sessions")
            
            return entities.map {
                Session(
                    id: $0.id ?? "",
                    date: $0.date ?? "",
                    title: $0.title ?? "",
                    category: $0.category ?? "",
                    summary: $0.summary ?? ""
                )
            }
        } catch {
            print("❌ Failed to fetch cached sessions: \(error)")
            return []
        }
    }
}


