//
//  Session.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import Foundation

struct Session: Identifiable, Codable {
    let id: String
    let date: String
    let title: String
    let category: String
    let summary: String
    
    var uuid: UUID {
            UUID(uuidString: id) ?? UUID() // Перетворює рядок id на UUID
        }
}
