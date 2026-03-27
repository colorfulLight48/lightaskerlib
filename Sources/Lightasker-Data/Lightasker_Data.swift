

protocol TaskListManaging {
    var tasks: [String: Task] { get }

    mutating func addTask(id: String, task: Task)
    mutating func deleteTask(id: String)
    mutating func editTask(id: String, newTask: Task)
 
}


struct TaskListManager {
    var name: String
    var tasks: [String: Task]
    
}

extension TaskListManager: TaskListManaging {
    mutating func addTask(id: String, task: Task) {
        self.tasks[id] = task
    }
    mutating func deleteTask(id: String) {
        self.tasks[id] = nil
    }
    mutating func editTask(id: String, newTask: Task) {
        self.addTask(id: id, task: newTask)
    }
}

struct Task {
    var name: String
    var isCompleted: Bool
}
