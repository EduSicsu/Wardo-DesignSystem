import SwiftUI

public enum WardoCalendarGrid {
    /// Includes leading and trailing empty cells, using the user's first weekday and calendar.
    public static func dates(in month: Date, calendar: Calendar) -> [Date?] {
        guard let interval = calendar.dateInterval(of: .month, for: month), let days = calendar.range(of: .day, in: .month, for: month) else { return [] }
        let offset = (calendar.component(.weekday, from: interval.start) - calendar.firstWeekday + 7) % 7
        var result = Array<Date?>(repeating: nil, count: offset)
        result += days.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: interval.start) }.map(Optional.some)
        while result.count % 7 != 0 { result.append(nil) }
        return result
    }
}

/// Wardo's expanded visionOS calendar, including localized weekdays and constrained selection.
public struct WardoVisionDatePicker: View {
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    @Environment(\.layoutDirection) private var direction
    @Environment(\.wardoTheme) private var theme
    @Binding private var selection: Date
    @State private var visibleMonth: Date
    private let title: String
    private let bounds: ClosedRange<Date>?
    private let collapsed: Bool
    @State private var presented = false
    public init(_ title: String, selection: Binding<Date>, in bounds: ClosedRange<Date>? = nil, collapsed: Bool = false) {
        self.title = title; _selection = selection; self.bounds = bounds; self.collapsed = collapsed; _visibleMonth = State(initialValue: selection.wrappedValue)
    }
    public var body: some View {
        Group {
            if collapsed {
                Button { visibleMonth = selection; presented = true } label: { Text(selection, format: .dateTime.month().day().year()).font(WardoFonts.body()).padding(12) }
                    .buttonStyle(.bordered).accessibilityLabel(title).popover(isPresented: $presented) { calendarPanel }
            } else { calendarPanel }
        }.onChange(of: selection) { _, value in visibleMonth = value }
    }
    private var calendarPanel: some View {
        VStack(spacing: 16) {
            HStack {
                Menu {
                    ForEach(1...calendar.monthSymbols.count, id: \.self) { month in
                        Button(calendar.monthSymbols[month - 1]) {
                            var components = calendar.dateComponents([.era, .year], from: visibleMonth); components.month = month; components.day = 1
                            if let date = calendar.date(from: components) { visibleMonth = date }
                        }
                    }
                } label: { Text(visibleMonth, format: .dateTime.month(.wide).year()).font(WardoFonts.label(20)); Image(systemName: "chevron.down") }
                Spacer()
                Button { moveMonth(-1) } label: { Image(systemName: direction == .leftToRight ? "chevron.left" : "chevron.right").frame(width: 44, height: 44) }.accessibilityLabel("Previous month")
                Button { moveMonth(1) } label: { Image(systemName: direction == .leftToRight ? "chevron.right" : "chevron.left").frame(width: 44, height: 44) }.accessibilityLabel("Next month")
            }.buttonStyle(.plain)
            HStack {
                ForEach(0..<7, id: \.self) { index in
                    let day = (calendar.firstWeekday - 1 + index) % 7
                    Text(calendar.veryShortStandaloneWeekdaySymbols[day]).font(WardoFonts.label(14)).foregroundStyle(.secondary).frame(maxWidth: .infinity).accessibilityLabel(calendar.weekdaySymbols[day])
                }
            }
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7), spacing: 4) {
                ForEach(Array(WardoCalendarGrid.dates(in: visibleMonth, calendar: calendar).enumerated()), id: \.offset) { _, date in
                    if let date {
                        let selected = calendar.isDate(date, inSameDayAs: selection)
                        Button { select(date) } label: {
                            Text(date, format: .dateTime.day()).font(WardoFonts.label(20)).frame(maxWidth: .infinity, minHeight: 44)
                                .background(selected ? WardoColorToken.backgroundRaised.color(in: theme) : .clear, in: Circle())
                                .overlay { if calendar.isDateInToday(date) { Circle().stroke(WardoColorToken.borderStrong.color(in: theme), lineWidth: 1) } }
                        }.buttonStyle(.plain).disabled(!allowed(date)).accessibilityLabel(date.formatted(.dateTime.weekday(.wide).month(.wide).day().year().locale(locale))).accessibilityAddTraits(selected ? [.isSelected] : [])
                    } else { Color.clear.frame(height: 44).accessibilityHidden(true) }
                }
            }
            Stepper("Year \(calendar.component(.year, from: visibleMonth))", onIncrement: { moveMonth(12) }, onDecrement: { moveMonth(-12) }).font(WardoFonts.label(14))
        }.padding(24).frame(idealWidth: 436, maxWidth: 436)
            .foregroundStyle(WardoColorToken.textPrimary.color(in: theme))
            .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 32))
            .accessibilityElement(children: .contain).accessibilityLabel(title)
    }
    private func allowed(_ date: Date) -> Bool {
        guard let bounds else { return true }
        return calendar.startOfDay(for: date) >= calendar.startOfDay(for: bounds.lowerBound) && calendar.startOfDay(for: date) <= calendar.startOfDay(for: bounds.upperBound)
    }
    private func moveMonth(_ increment: Int) { if let date = calendar.date(byAdding: .month, value: increment, to: visibleMonth) { visibleMonth = date } }
    private func select(_ date: Date) {
        let time = calendar.dateComponents([.hour, .minute, .second], from: selection)
        let candidate = calendar.date(bySettingHour: time.hour ?? 0, minute: time.minute ?? 0, second: time.second ?? 0, of: date) ?? date
        selection = bounds.map { min($0.upperBound, max($0.lowerBound, candidate)) } ?? candidate
        if collapsed { presented = false }
    }
}
