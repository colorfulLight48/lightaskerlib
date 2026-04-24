import Foundation
public protocol LightaskerLibraryProtocol {
    associatedtype Task: LightaskerLibrary.TaskProtocol
}
public enum LightaskerLibrary {
    public protocol TaskProtocol: Codable {
        var id: String?
        var name: String? 
        var isCompleted: Bool
        var dueDate: Date?
        var startDate: Date?
        var isOverDue: Bool
        var startSecond: Date?
        var startMinute: Date?
        var startHour: Date?
        var startSecond: Date?
        var isInPeriod: Bool
        mutating func markComplete()
        mutating func markIncomplete()
        init(id: String? = nil, name: String? = nil, dueDate: Date? = nil, startDate: Date? = nil)
    }
    // Nested Task struct
    public struct Task: LightaskerLibrary.TaskProtocol {
        public var id: String?
        public var name: String?    
        public var isCompleted: Bool = false
        public var dueDate: Date?
        public var startDate: Date?
        
        public var isOverdue: Bool {
            guard let dueDate = dueDate else { return false }
            return dueDate < Date()
        }
        
        public var startSecond: Date? { startDate?.toSeconds }
        public var startMinute: Date? { startDate?.toMinutes }
        public var startHour: Date? { startDate?.toHours }
        public var startDay: Date? { startDate?.toDays }
        
        public var isStartSecond: Bool { Date().toSeconds == startSecond }
        public var isStartMinute: Bool { Date().toMinutes == startMinute }
        public var isStartHour: Bool { Date().toHours == startHour }
        public var isStartDay: Bool { Date().toDays == startDay }
        
        public var isInPeriod: Bool {
            if let start = startDate, let due = dueDate {
                return Date() > start && Date() < due
            } else if let start = startDate {
                return Date() > start
            } else if let due = dueDate {
                return Date() < due
            }
            return true
        }
        
        public mutating func markComplete() { self.isCompleted = true }
        public mutating func markIncomplete() { self.isCompleted = false }
        
        public init(id: String? = nil, name: String? = nil, dueDate: Date? = nil, startDate: Date? = nil) {
            self.id = id
            self.name = name
            self.dueDate = dueDate
            self.startDate = startDate
        }
    }
}

// Extensions must be at the top level
extension Date {
    var toSeconds: Date {
        Date(timeIntervalSinceReferenceDate: floor(self.timeIntervalSinceReferenceDate))
    }

    var toMinutes: Date {
        let step: TimeInterval = 60
        return Date(timeIntervalSinceReferenceDate: floor(self.timeIntervalSinceReferenceDate / step) * step)
    }

    var toHours: Date {
        let step: TimeInterval = 3600
        return Date(timeIntervalSinceReferenceDate: floor(self.timeIntervalSinceReferenceDate / step) * step)
    }
    
    var toDays: Date {
        Calendar.current.startOfDay(for: self)
    }
}

// Extend Array specifically for your namespaced Task
public extension Array where Element == LightaskerLibrary.Task {
    
    func getIndexById(id: String, occurrence: Int = 1) -> Int? {
        let matchingIndices = self.enumerated().compactMap { (index, task) in
            task.id == id ? index : nil
        }
        let occurrenceIndex = occurrence - 1
        guard matchingIndices.indices.contains(occurrenceIndex) else { return nil }
        return matchingIndices[occurrenceIndex]
    }

    func lookup(id: String, occurrence: Int = 1) -> LightaskerLibrary.Task? {
        getIndexById(id: id, occurrence: occurrence).map { self[$0] }
    }

    mutating func addTask(task: LightaskerLibrary.Task) {
        let exists = self.contains { $0.id == task.id }
        guard !exists else { return }
        self.append(task)
    }

    mutating func deleteTask(id: String) {
        if let index = getIndexById(id: id) {
            self.remove(at: index)
        }
    }
}
