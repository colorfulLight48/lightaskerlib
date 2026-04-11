import Testing
@testable import lightaskerlib
import Foundation

@Test func lookup() {
    var taskList: Array<Task> = []

    taskList.addTask(task: Task(id: "makeTestOne", name: "Make First Unit Test", isCompleted: true))
    
    guard var _ = taskList.lookup(id: "makeTestOne") else {
        #expect(Bool(false))
        return
    }
    #expect(Bool(true))
    
}

@Test func complete() {
    
    var myTask: Task = Task(id: "makeTestTwo", name: "Make Second Unit Test", isCompleted: false)
    
    myTask.markComplete()
    
    #expect(myTask.isCompleted == true)
}

@Test func delete() {
    var taskList: Array<Task> = []
    taskList.addTask(task: Task(id: "makeKernelPanic", name: "Make Kernel Panic", isCompleted: false))
    taskList.deleteTask(id: "makeKernelPanic")
    guard var _ = taskList.lookup(id: "makeKernelPanic") else {
        #expect(Bool(true))
        return
    }
    #expect(Bool(false))
}

@Test func makeIncomplete() {
    var myTask: Task = Task(id: "incompleteTask", name: "This shouldn't be completed", isCompleted: true)
    
    myTask.markIncomplete()
    
    #expect(myTask.isCompleted == false)
}

