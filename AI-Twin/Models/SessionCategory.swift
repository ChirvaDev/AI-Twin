//
//  SessionCategory.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 05/05/2025.
//

import Foundation

enum SessionCategory: String, CaseIterable, Codable, Identifiable {
    case career
    case emotions
    case relationships
    case health
    case personalGrowth

    var id: String { rawValue }
    
    var title: String {
            switch self {
            case .career: return "Career"
            case .emotions: return "Emotions"
            case .relationships: return "Relationships"
            case .health: return "Health"
            case .personalGrowth: return "Personal Growth"
            }
        }
    
    var icon: String {
        switch self {
        case .career: return "briefcase.fill"
        case .emotions: return "face.smiling"
        case .relationships: return "heart.circle.fill"
        case .health: return "cross.case"
        case .personalGrowth: return "leaf.fill"
        }
    }

}

