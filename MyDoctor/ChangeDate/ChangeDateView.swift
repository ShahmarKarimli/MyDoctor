//
//  ChangeDateView.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 17.02.26.
//

import SwiftUI

struct ChangeDateView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ChangeDateViewModel()

    let booking: BookingInfo = .init(
        dateBadge: "Jan\n30",
        title: "Ginekoloq müayinəsi - Liv Bona...",
        subtitle: "Sabah,10:00, Dr.K Doğa Seçkin"
    )

    var body: some View {
        ZStack {
            HekimimColors.background.ignoresSafeArea()

            VStack(spacing: 14) {

                ChangeDateTopBar() {
                    dismiss()
                }

                Text("Növbəti həkim qəbulu")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(HekimimColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)

                VStack {
                    BookingCard(info: booking)
                        .padding(.horizontal, 10)
                    
                    CalendarAndTimeCard(vm: vm)
                        .padding(.horizontal, 20)
                    
                    Spacer(minLength: 0)
                }
                .background(.white)
                .cornerRadius(14)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ChangeDateTopBar: View {
    let onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44, alignment: .leading)
            }

            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct BookingCard: View {
    let info: BookingInfo

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            DateBadge(text: info.dateBadge)

            VStack(alignment: .leading, spacing: 6) {
                Text(info.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(1)

                Text(info.subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(HekimimColors.textSecondary)
                    .lineLimit(1)
            }

            Spacer()

            Image(systemName: "bell")
                .font(.system(size: 20))
                .foregroundColor(HekimimColors.primary)
                .padding(.top, 4)
        }
        .padding(16)
        .background(HekimimColors.card)
    }
}

struct CalendarAndTimeCard: View {
    @ObservedObject var vm: ChangeDateViewModel

    var body: some View {
        VStack(spacing: 16) {

            MonthHeader(vm: vm)

            WeekHeader(weekTitles: vm.weekTitles)

            DaysGrid(vm: vm) { day in
                vm.selectedDay = day
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Günortaya qədər")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(HekimimColors.primary)

                TimeRow(times: vm.timesBeforeNoon, selected: vm.selectedTime) { vm.selectedTime = $0 }

                Text("Günortadan sonra")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(HekimimColors.primary)
                    .padding(.top, 2)

                TimeRow(times: vm.timesAfterNoon, selected: vm.selectedTime) { vm.selectedTime = $0 }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 14) {
                DisabledWideButton(title: "Tarixi dəyiş") { }
                DangerOutlineButton(title: "Ləğv et") { }
            }
            .padding(.top, 8)
        }
        .padding(16)
        .background(HekimimColors.card)
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(HekimimColors.primary.opacity(0.6), lineWidth: 1)
        )
    }
}

struct MonthHeader: View {
    @ObservedObject var vm: ChangeDateViewModel

    var body: some View {
        HStack(spacing: 12) {
            Button { vm.prevMonth() } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 32, height: 32)
            }

            Spacer()

            Menu {
                ForEach(1...12, id: \.self) { m in
                    Button(CalendarUtils.cal.shortMonthSymbols[m-1]) {
                        vm.month = m
                    }
                }
            } label: {
                DropdownPill(title: vm.monthName)
            }

            Menu {
                ForEach(2020...2035, id: \.self) { y in
                    Button("\(y)") { vm.year = y }
                }
            } label: {
                DropdownPill(title: "\(vm.year)")
            }

            Spacer()

            Button { vm.nextMonth() } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 32, height: 32)
            }
        }
    }
}

struct DropdownPill: View {
    let title: String
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            Image(systemName: "chevron.down")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black.opacity(0.7))
        }
        .padding(.horizontal, 14)
        .frame(height: 34)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.15), lineWidth: 1)
        )
        .cornerRadius(10)
    }
}

struct WeekHeader: View {
    let weekTitles: [String]

    var body: some View {
        HStack {
            ForEach(weekTitles, id: \.self) { t in
                Text(t)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(HekimimColors.textSecondary)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 2)
    }
}

struct DaysGrid: View {
    @ObservedObject var vm: ChangeDateViewModel
    let onSelect: (Int) -> Void

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 7)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(0..<vm.grid.count, id: \.self) { i in
                if let day = vm.grid[i] {
                    DayCell(
                        day: day,
                        isSelected: day == vm.selectedDay,
                        isDisabled: vm.isDisabled(day: day),
                        isWeekend: vm.isWeekend(day: day),
                        onTap: { onSelect(day) }
                    )
                } else {
                    Color.clear.frame(height: 1)
                }
            }
        }
    }
}

struct DayCell: View {
    let day: Int
    let isSelected: Bool
    let isDisabled: Bool
    let isWeekend: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text("\(day)")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(fg)
                .frame(width: 40, height: 40)
                .background(bg)
                .cornerRadius(12)
        }
        .disabled(isDisabled)
    }

    private var fg: Color {
        if isSelected { return .white }
        if isDisabled { return Color.gray.opacity(0.45) }
        return .black
    }

    private var bg: Color {
        if isSelected { return HekimimColors.primary }
        if isWeekend { return Color.black.opacity(0.05) }
        return Color.clear
    }
}

struct TimeRow: View {
    let times: [String]
    let selected: String
    let onSelect: (String) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ForEach(times, id: \.self) { t in
                Button {
                    onSelect(t)
                } label: {
                    Text(t)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(selected == t ? .white : .black)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(selected == t ? HekimimColors.primary : Color.clear)
                        .cornerRadius(28)
                }
            }
        }
    }
}

struct DisabledWideButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.gray.opacity(0.75))
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(Color.black.opacity(0.06))
                .cornerRadius(8)
        }
        .disabled(true)
    }
}

struct DangerOutlineButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color.red)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                )
                .cornerRadius(8)
        }
    }
}

#Preview {
    ChangeDateView()
}
