//
//  SessionService.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import Foundation

// Сервіс для взаємодії з сесіями (отримання та створення).

class SessionService {
    static let shared = SessionService() // Singleton
    
    private init() {}
    
    // Асинхронно отримує список сесій з віддаленого API.
    // - Returns: Масив об'єктів `Session`
    // - Throws: `URLError` або помилка декодування JSON
    
    func fetchSessions() async throws -> [Session] {
        guard let url = URL(string: "https://run.mocky.io/v3/d9796311-5e1a-40fc-bb23-3ef392a4b402") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode([Session].self, from: data)
        } catch {
            print("❌ JSON decoding error:", error)
            throw error
        }
    }
    
    
    // Створює нову сесію через POST-запит.
    // - Parameters:
    //   - title: Назва сесії
    //   - category: Категорія сесії
    // - Returns: Створений об'єкт `Session`
    // - Throws: `URLError` або помилка декодування JSON
    
    func createSession(title: String, category: String) async throws -> Session {
        guard let url = URL(string: "https://mock.api/api/sessions") else {
            throw URLError(.badURL)
        }
        
        let payload: [String: Any] = [
            "title": title,
            "category": category
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: payload)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(Session.self, from: data)
    }
}


