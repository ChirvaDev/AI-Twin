//
//  ChatService.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import Foundation

class ChatService {
    // Функція для надсилання повідомлення
    func sendMessage(_ message: String, to id: String) async throws -> String {
        // Імітація асинхронного запиту до сервера
        let aiResponse = "AI: \(message)"
        // Імітуємо затримку для асинхронного запиту
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
        return aiResponse
    }
    
    // Функція для отримання історії повідомлень
    func fetchMessages(sessionId: String) async throws -> [Message] {
        // Імітація запиту до сервера
        let sampleMessages = [
            Message(text: "Привіт! Як я можу допомогти?", sender: .ai),
            Message(text: "Привіт! Я шукаю допомогу з ментальним здоровям.", sender: .user)
        ]
        // Імітуємо затримку для асинхронного запиту
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 секунда
        return sampleMessages
    }
}

