//
//  SessionsViewModel.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import SwiftUI

@MainActor
class SessionsViewModel: ObservableObject {
    @Published var sessions: [Session] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var sortedSessions: [Session] {
        sessions.sorted { $0.dateForSorting > $1.dateForSorting }
    }
    
    func fetchSessions() async {
        isLoading = true

        // Завантажуємо кешовані сесії
        let cached = CoreDataManager.shared.fetchCachedSessions()
        print("✅ Loaded \(cached.count) sessions from Core Data")
        
        // Показуємо їх одразу
        DispatchQueue.main.async {
            self.sessions = cached
        }
        
        defer { isLoading = false }

        do {
            // Завантажуємо сесії з API
            let loadedSessions = try await SessionService.shared.fetchSessions()
            print("✅ Loaded \(loadedSessions.count) sessions from API")
            
            // Зберігаємо та оновлюємо
            // Перевіряємо, чи є сесії з API, яких ще немає в кеші, і додаємо їх
            let newSessions = loadedSessions.filter { apiSession in
                !self.sessions.contains { $0.id == apiSession.id }
            }
            
            if !newSessions.isEmpty {
                CoreDataManager.shared.saveSessions(newSessions)
            }
            
            // Оновлюємо список сесій
            DispatchQueue.main.async {
                self.sessions.append(contentsOf: newSessions)
                self.errorMessage = nil
            }
        } catch {
            print("❌ Error fetching sessions:", error)
            DispatchQueue.main.async {
                self.errorMessage = "Showing offline data"
            }
        }
    }

    func addSession(title: String, category: SessionCategory) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: Date())

        let newSession = Session(
            id: UUID().uuidString,
            date: formattedDate,
            title: title,
            category: category.rawValue,
            summary: ""
        )
        // Додаємо нову сесію до сесій
        sessions.insert(newSession, at: 0) // Додаємо на початок
        
        // Зберігаємо нову сесію в CoreData
        CoreDataManager.shared.saveSession(newSession)
    }
}
