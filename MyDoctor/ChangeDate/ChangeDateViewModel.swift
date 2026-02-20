//
//  ChangeDateViewModel.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 17.02.26.
//

import SwiftUI
import Combine

final class ChangeDateViewModel: ObservableObject {
    @Published var month: Int = 1
    @Published var year: Int = 2026

    @Published var selectedDay: Int = 30
    @Published var selectedTime: String = "10:00"

    let weekTitles = ["B.e", "Ç.a", "Ç.", "Ç.a", "C.", "Ş.", "B."]

    var monthName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMM"

        let date = CalendarUtils.dateFrom(year: year, month: month, day: 1)
        return formatter.string(from: date)
    }
    
    var grid: [Int?] {
        CalendarUtils.monthGrid(year: year, month: month)
    }

    func isDisabled(day: Int) -> Bool {
        let blocked: Set<Int> = [14, 22]
        return blocked.contains(day)
    }

    func isWeekend(day: Int) -> Bool {
        CalendarUtils.isWeekend(year: year, month: month, day: day)
    }

    func prevMonth() {
        var y = year, m = month
        CalendarUtils.prevMonth(year: &y, month: &m)
        year = y; month = m
    }

    func nextMonth() {
        var y = year, m = month
        CalendarUtils.nextMonth(year: &y, month: &m)
        year = y; month = m
    }

    let timesBeforeNoon = ["9:00", "9:30", "10:00", "10:30", "11:30"]
    let timesAfterNoon  = ["12:30", "13:30", "14:00", "14:30", "15:30"]
}
