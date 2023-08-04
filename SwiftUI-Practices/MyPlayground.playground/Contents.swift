import UIKit


//MARK: - class vs struce
//class Person{
//    var name : String
//
//    init(name : String){
//        self.name = name
//    }
//}
//
//var personOne  = Person(name: "Hello")
//var personTwo  = personOne
//personTwo.name = "World"
//
//print(personOne.name)
//print(personTwo.name)
//
//
////MARK: - Struct
//struct User{
//    var name : String
//}
//
//var userOne  = User(name: "Hello")
//var userTwo  = userOne
//userTwo.name = "World"
//
//print(userOne.name)
//print(userTwo.name)

//MARK: why we use "mutating" keyword in a struct method
//struct Counter {
//    var count: Int
//
//    mutating func increment() {
//        count += 1
//    }
//}
//
//var counter = Counter(count: 0)
//print("Before: \(counter.count)")  // Before: 0
//
//counter.increment()
//print("After: \(counter.count)")  // After: 1


struct Counter {
    var count: Int

    static func staticMethod() {
        // Implementation of static method
    }

    mutating func mutatingMethod() {
        // Implementation of mutating method
        count += 1
    }
}

//can be accessed directly on the type itself
Counter.staticMethod()

// Creating an instance
var counter = Counter(count: 0)

// modify the properties and state of an instance of the struct.
counter.mutatingMethod()
print("Count : \(counter.count)")  // Count : 1 -> count value is incremented by 1
