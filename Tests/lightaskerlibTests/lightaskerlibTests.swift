import Testing
@testable import lightaskerlib
import Foundation

@Test func lookup() {
    var taskList: Array<LightaskerLibrary.Task> = []

    taskList.addTask(task: Task(id: "makeTestOne"))
    
    guard var _ = taskList.lookup(id: "makeTestOne") else {
        #expect(Bool(false))
        return
    }
    #expect(Bool(true))
    
}

@Test func complete() {
    
    var myTask: LightaskerLibrary.Task = LightaskerLibrary.Task()
    
    myTask.markComplete()
    
    #expect(myTask.isCompleted == true)
}

@Test func delete() {
    var taskList: Array<LightaskerLibrary.Task> = []
    taskList.addTask(task: Task(id: "makeKernelPanic"))
    taskList.deleteTask(id: "makeKernelPanic")
    guard var _ = taskList.lookup(id: "makeKernelPanic") else {
        #expect(Bool(true))
        return
    }
    #expect(Bool(false))
}

@Test func makeIncomplete() {
    var myTask: LightaskerLibrary.Task = LightaskerLibrary.Task(isCompleted: true)
    
    myTask.markIncomplete()
    
    #expect(myTask.isCompleted == false)
}

@Test func makeNonOverdueTask() {
    let calendar = Calendar.current
    let tomorrow = calendar.date(byAdding: .day, value: 1, to: .now)
    let myTask: LightaskerLibrary.Task = LightaskerLibrary.Task(dueDate: tomorrow)
    #expect(myTask.isOverdue == false)
}

@Test func makeOverdueTask() {
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    // Now use it in your test
    let overdueTask = LightaskerLibrary.Task(dueDate: yesterday)
    #expect(overdueTask.isOverdue == true)

}
