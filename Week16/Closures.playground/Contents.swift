import UIKit

var str = "Hello, playground"

// Standard function
func myFunction() {
    print("message")
}
myFunction()

// Saving function to variable
// It takes a string and returns nothing.
var printGreeting: (String) -> () = {val in
    print("Hi there \(val)")
}
printGreeting("Bob")

// It takes a string + int and returns a string.
var createGreeting: (String, Int) -> (String) = {val, days in
    return "How are you doing, \(val) and happy \(days) birthday."
}

createGreeting("Jimmy", 12)

