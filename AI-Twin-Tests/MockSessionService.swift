//
//  MockSessionService.swift
//  AI-Twin-Tests
//
//  Created by Dominic Kchau on 07/05/2025.
//

import XCTest
@testable import AI_Twin

protocol SessionServiceProtocol {
    func fetchSessions() async throws -> [Session]
}

class MockSessionService: SessionServiceProtocol {
    var shouldThrowError = false

    func fetchSessions() async throws -> [Session] {
        if shouldThrowError {
            throw URLError(.badURL) // Генерація помилки для тестування
        }
        
        return [Session(id: "1", date: "2025-05-07", title: "Mock Session", category: "Test", summary: "This is a mock session.")]
    }
}
