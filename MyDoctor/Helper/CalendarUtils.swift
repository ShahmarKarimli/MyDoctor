//
//  CalendarUtils.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 17.02.26.
//

import Foundation

enum CalendarUtils {
    static let cal: Calendar = {
        var c = Calendar(identifier: .gregorian)
        c.firstWeekday = 2
        return c
    }()

    static func daysInMonth(year: Int, month: Int) -> Int {
        let date = dateFrom(year: year, month: month, day: 1)
        return cal.range(of: .day, in: .month, for: date)?.count ?? 30
    }

    static func leadingBlanks(year: Int, month: Int) -> Int {
        let first = dateFrom(year: year, month: month, day: 1)
        let weekday = cal.component(.weekday, from: first)
        let mondayFirstIndex = (weekday + 5) % 7
        return mondayFirstIndex
    }

    static func dateFrom(year: Int, month: Int, day: Int) -> Date {
        cal.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
    }

    static func isWeekend(year: Int, month: Int, day: Int) -> Bool {
        let d = dateFrom(year: year, month: month, day: day)
        return cal.isDateInWeekend(d)
    }

    static func monthGrid(year: Int, month: Int) -> [Int?] {
        let blanks = leadingBlanks(year: year, month: month)
        let days = daysInMonth(year: year, month: month)

        var grid: [Int?] = Array(repeating: nil, count: blanks)
        grid += (1...days).map { Optional($0) }
        while grid.count < 42 { grid.append(nil) }
        return grid
    }

    static func prevMonth(year: inout Int, month: inout Int) {
        if month == 1 { month = 12; year -= 1 } else { month -= 1 }
    }

    static func nextMonth(year: inout Int, month: inout Int) {
        if month == 12 { month = 1; year += 1 } else { month += 1 }
    }
}
