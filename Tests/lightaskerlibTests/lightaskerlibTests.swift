import Testing
@testable import lightaskerlib
import Foundation

@Test func retrieve() {
    var taskList = TaskListManager(tasks: [])

    taskList.addTask(task: Task(id: "makeTests", name: "Make First Unit Test", isCompleted: true))
    
    guard var _ = taskList.getTask(id: "makeTests") else {
        print("This task doesn't exist.")
        #expect(Bool(false))
        return
    }
    #expect(Bool(true))
    
}

@Test func removeTest() {
    
}