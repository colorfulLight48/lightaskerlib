public struct Task<ExtraData> {
    public var name: String?    
    public var isCompleted: Bool = false
     
   
    public mutating func markComplete() {
        self.isCompleted = true
    }
    public mutating func markIncomplete() {
        self.isCompleted = false
    }
}
