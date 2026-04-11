import Testing
@testable import lightaskerlib
import Foundation

@Test func lookup() {
    var taskList: Array<Task> = []

    taskList.addTask(task: Task(id: "makeTestOne"))
    
    guard var _ = taskList.lookup(id: "makeTestOne") else {
        #expect(Bool(false))
        return
    }
    #expect(Bool(true))
    
}

@Test func complete() {
    
    var myTask: Task = Task()
    
    myTask.markComplete()
    
    #expect(myTask.isCompleted == true)
}

@Test func delete() {
    var taskList: Array<Task> = []
    taskList.addTask(task: Task(id: "makeKernelPanic"))
    taskList.deleteTask(id: "makeKernelPanic")
    guard var _ = taskList.lookup(id: "makeKernelPanic") else {
        #expect(Bool(true))
        return
    }
    #expect(Bool(false))
}

@Test func makeIncomplete() {
    var myTask: Task = Task(isCompleted: true)
    
    myTask.markIncomplete()
    
    #expect(myTask.isCompleted == false)
}

