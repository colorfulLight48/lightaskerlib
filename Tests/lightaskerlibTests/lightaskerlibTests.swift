import Testing
@testable import lightaskerlib
import Foundation

@Test func lookup() {
    var taskList: Array<Task> = []

    taskList.addTask(task: Task(id: "makeTestOne", name: "Make First Unit Test", isCompleted: true))
    
    guard var _ = taskList.lookup(id: "makeTestOne") else {
        print("This task doesn't exist.")
        #expect(Bool(false))
        return
    }
    #expect(Bool(true))
    
}

@Test func complete() {
    var violations = 0
    var myTask: Task = Task(id: "makeTestTwo", name: "Make Second Unit Test", isCompleted: false)
    if myTask.isCompleted == false {} else {
        print("Violation: isCompleted was set to false in init.")
        violations += 1
    }
    myTask.markComplete()
    if myTask.isCompleted == true {} else {
        print("Violation: myTask was marked completed but not really.")
        violations += 1
    }
    print("Violations: \(violations)")
    #expect(violations == 0)
}