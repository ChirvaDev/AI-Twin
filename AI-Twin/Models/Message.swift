//
//  Message.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 06/05/2025.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let sender: Sender
}

enum Sender {
    case user
    case ai
}
