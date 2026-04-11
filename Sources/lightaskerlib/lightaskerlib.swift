import Foundation


public extension Array<Task> {
    
    func getIndexById(id: String) -> Int? {
        // Finding the index where id equals 2
        if let index = self.firstIndex(where: { $0.id == id }) {
            return index
        }
        return nil
    }
    func lookup(id: String) -> Task? {
        guard let value = self.getIndexById(id: id) else {
            return nil
        }
        return self[value]
    }
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
    var isOverdue: Bool {
        // 1. If there's no due date, it can't be overdue
        guard let dueDate = dueDate else { return false }
        
        // 2. Compare the due date with the current moment
        return dueDate < Date()
    }

    public mutating func markComplete() {
        self.isCompleted = true
    }
    public mutating func markIncomplete() {
        self.isCompleted = false
    }
}
