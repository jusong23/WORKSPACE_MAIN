import UIKit

let number = [1,2,3,4,5]
let mapArray = number.map {(number)->Int in
return number + 2
}
print("map \(mapArray)")


let intNumber = [2,24,231,124,3]
let filterArray = intNumber.filter{ $0 > 100 }
print("\(filterArray)")

let someArray = [0,1,2,3,5]
let reduce = someArray.reduce(2) {
    (result: Int, element: Int) -> Int in
    print("\(result) + \(element)")
    return result + element
}
print("\(reduce)")
