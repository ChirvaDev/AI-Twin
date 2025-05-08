//
//  AI_Twin_Tests.swift
//  AI-Twin-Tests
//
//  Created by Dominic Kchau on 05/05/2025.
//

import XCTest
@testable import AI_Twin


final class AI_Twin_Tests: XCTestCase {
    var sessionService: SessionServiceProtocol!

        override func setUp() {
            super.setUp()
            sessionService = MockSessionService()
        }

    // Тест на успішне отримання сесій
    func testFetchSessions_Success() async throws {
        do {
            let sessions = try await sessionService.fetchSessions()
            XCTAssertGreaterThan(sessions.count, 0, "Має бути хоча б одна сесія")
        } catch {
            XCTFail("Тест не має кидати помилку, але кинута: \(error)")
        }
    }

    // Тест на помилку: невірний URL
    func testFetchSessions_BadURL() async throws {
        
        let badService = MockSessionService()
        badService.shouldThrowError = true
        
        do {
            _ = try await badService.fetchSessions()
            XCTFail("Має бути помилка через поганий URL")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .badURL, "Має бути помилка через поганий URL")
        } catch {
            XCTFail("Очікувана помилка не виникла")
        }
    }
}
