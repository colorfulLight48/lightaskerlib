import Foundation
extension Date {
    /// Strips milliseconds
    var toSeconds: Date {
        let timestamp = floor(self.timeIntervalSinceReferenceDate)
        return Date(timeIntervalSinceReferenceDate: timestamp)
    }

    /// Strips seconds and milliseconds
    var toMinutes: Date {
        let secondsInMinute: TimeInterval = 60
        let timestamp = floor(self.timeIntervalSinceReferenceDate / secondsInMinute) * secondsInMinute
        return Date(timeIntervalSinceReferenceDate: timestamp)
    }

    /// Strips minutes, seconds, and milliseconds
    var toHours: Date {
        let secondsInHour: TimeInterval = 3600
        let timestamp = floor(self.timeIntervalSinceReferenceDate / secondsInHour) * secondsInHour
        return Date(timeIntervalSinceReferenceDate: timestamp)
    }
    var toDays: Date {
        // We use ?? self as a fallback so it never returns an Optional.
        // It is virtually impossible for startOfDay to fail.
        return Calendar.current.startOfDay(for: self)
    }
}




public struct Task {
    public var id: String?
    public var name: String?    
    public var isCompleted: Bool = false
    public var dueDate: Date?
    public var startDate: Date?
    public var isOverdue: Bool {
        // 1. If there's no due date, it can't be overdue
        guard let dueDate = dueDate else { return false }
        
        // 2. Compare the due date with the current moment
        return dueDate < Date()
    }
    public var startSecond: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toSeconds
    }
    public var startMinute: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toMinutes
    }
    public var startHour: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toHours
    }
    public var startDay: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toDays
    }
    public var isStartSecond: Bool {
        guard let nstartDate = startDate else { return false } // e.g., 12:00:05.7
        let truncatedStartDate = nstartDate.toSeconds
        let now = Date() // e.g., 12:00:05.7
        let truncatedDate = Date(timeIntervalSinceReferenceDate: floor(now.timeIntervalSinceReferenceDate))
        return truncatedDate == truncatedStartDate
    }
    public var isStartMinute: Bool {
        let now: Date = Date() // 12:05:45
        let flooredToMinute: Date = now.toMinutes
        
        
        return flooredToMinute == startMinute

    }
    public var isStartHour: Bool {return Date().toHours == startHour}
    public var isStartDay: Bool {return Date().toHours == startDay}
    public var isInPeriod: Bool {
        if let unwrapped_startDate: Date = startDate, let unwrapped_dueDate: Date = dueDate {
            return Date() > unwrapped_startDate && Date() < unwrapped_dueDate
        } else if let unwrapped_startDate: Date = startDate {
            return Date() > unwrapped_startDate
        } else if let unwrapped_dueDate: Date = dueDate {
            return Date() < unwrapped_dueDate
        } else {
            return true
        }
    }
    public mutating func markComplete() {
        self.isCompleted = true
    }
    public mutating func markIncomplete() {
        self.isCompleted = false
    }
}
