//
//  Session+Extensions.swift
//  AI-Twin
//
//  Created by Dominic Kchau on 07/05/2025.
//

import Foundation

extension Session {
    // Спільний форматер для парсингу дати
    private static var parsingDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Формат, який приходить з сервера
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }

    // Спільний форматер для відображення дати
    private static var displayDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none 
        return formatter
    }

    // Форматована дата для відображення
    var formattedDate: String {
        guard let dateObj = Self.parsingDateFormatter.date(from: date) else {
            return "Invalid date"
        }
        return Self.displayDateFormatter.string(from: dateObj)
    }

    // Дата для сортування
    var dateForSorting: Date {
        return Self.parsingDateFormatter.date(from: date) ?? .distantPast
    }
}
