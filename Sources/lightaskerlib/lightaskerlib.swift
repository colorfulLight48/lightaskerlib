

public extension Array<Task> {
    
    func getIndexById(id: String) -> Int? {
        // Finding the index where id equals 2
        if let index = self.firstIndex(where: { $0.id == id }) {
            return index
        }
        return nil
    }
    func lookupById(id: String) -> Task? {
        guard let value = self.getIndexById(id: id) else {
            return nil
        }
        return self[value]
    }
}

public struct TaskListManager {
    var tasks: [Task]
    
    
    public mutating func addTask(task: Task) {
        self.tasks.append(task)
    }
    public mutating func deleteTask(id: String) {
        
        guard let indexToRemove = self.tasks.getIndexById(id: id) else {
            return
        }
        if self.tasks.indices.contains(indexToRemove) {
            self.tasks.remove(at: indexToRemove)
        }
    }
    public mutating func getTask(id: String) -> Task? {
        return self.tasks.lookupById(id: id)
    }

}

public struct Task {
    var id: String
    var name: String
    var isCompleted: Bool

    public mutating func markComplete() {
        self.isCompleted = true
    }
    public mutating func markIncompltete() {
        self.isCompleted = false
    }
}
