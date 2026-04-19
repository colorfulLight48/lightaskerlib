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

public extension Array<Task> {
    
    func getIndexById(id: String, occurrence: Int = 1) -> Int? {
        // 1. Find all indices where the ID matches
        let matchingIndices = self.enumerated().compactMap { (index, task) in
            task.id == id ? index : nil
        }
        
        // 2. Check if the requested occurrence exists (convert 1-based to 0-based index)
        let occurrenceIndex = occurrence - 1
        
        guard matchingIndices.indices.contains(occurrenceIndex) else {
            return nil
        }
        
        return matchingIndices[occurrenceIndex]
    }

    func lookup(id: String, occurrence: Int = 1) -> Task? { return self.getIndexById(id: id, occurrence: occurrence).map { self[$0] } }

    mutating func addTask(task: Task) {
        if let id = task.id {
            // If it HAS an ID, make sure that ID isn't already there
            guard !self.contains(where: { $0.id == id }) else { return }
        } else {
            // If it HAS NO ID, make sure we don't already have a "no-id" task
            guard !self.contains(where: { $0.id == nil }) else { return }
        }
        
        self.append(task)
    }


    mutating func deleteTask(id: String) {
        
        guard let indexToRemove = self.getIndexById(id: id) else {
            return
        }
        if self.indices.contains(indexToRemove) {
            self.remove(at: indexToRemove)
        }
    }
}



public struct Task {
    var id: String?
    var name: String?    
    var isCompleted: Bool = false
    var dueDate: Date?
    var startDate: Date?
    var isOverdue: Bool {
        // 1. If there's no due date, it can't be overdue
        guard let dueDate = dueDate else { return false }
        
        // 2. Compare the due date with the current moment
        return dueDate < Date()
    }
    var startSecond: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toSeconds
    }
    var startMinute: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toMinutes
    }
    var startHour: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toHours
    }
    var startDay: Date? {
        guard let nstartDate = startDate else { return nil } // e.g., 12:00:05.7
        return nstartDate.toDays
    }
    var isStartSecond: Bool {
        guard let nstartDate = startDate else { return false } // e.g., 12:00:05.7
        let truncatedStartDate = nstartDate.toSeconds
        let now = Date() // e.g., 12:00:05.7
        let truncatedDate = Date(timeIntervalSinceReferenceDate: floor(now.timeIntervalSinceReferenceDate))
        return truncatedDate == truncatedStartDate
    }
    var isStartMinute: Bool {
        let now: Date = Date() // 12:05:45
        let flooredToMinute: Date = now.toMinutes
        
        
        return flooredToMinute == startMinute

    }
    var isStartHour: Bool {return Date().toHours == startHour}
    var isStartDay: Bool {return Date().toHours == startDay}
    var isInPeriod: Bool {
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
