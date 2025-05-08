//
//  ChatViewModel.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import SwiftUI

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [] // Список повідомлень
    private var chatService: ChatService
    
    init(chatService: ChatService = ChatService()) {
        self.chatService = chatService
    }
    
    // Завантаження повідомлень з сервера
    func loadMessages(sessionId: String) async {
        do {
            let fetchedMessages = try await chatService.fetchMessages(sessionId: sessionId)
            self.messages = fetchedMessages
        } catch {
            print("❌ Помилка завантаження повідомлень: \(error)")
        }
    }
    
    // Надсилання повідомлення
    func sendMessage(_ message: String, sessionId: String) async {
        // Спочатку додаємо повідомлення користувача
        self.messages.append(Message(text: message, sender: .user))
        
        // Чекаємо на відповідь від AI
        do {
            let aiResponse = try await chatService.sendMessage(message, to: sessionId)
            
            // Додаємо відповідь від AI тільки якщо отримано реальну відповідь
            self.messages.append(Message(text: aiResponse, sender: .ai))
        } catch {
            print("❌ Помилка надсилання повідомлення: \(error)")
        }
    }
}
