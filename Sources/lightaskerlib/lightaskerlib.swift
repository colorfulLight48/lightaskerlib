
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
   
    public mutating func markComplete() {
        self.isCompleted = true
    }
    public mutating func markIncomplete() {
        self.isCompleted = false
    }
}
