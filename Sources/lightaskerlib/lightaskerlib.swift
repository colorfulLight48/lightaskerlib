

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
