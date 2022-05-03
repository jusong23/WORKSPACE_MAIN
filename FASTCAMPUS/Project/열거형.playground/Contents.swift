import UIKit


enum CompassPoint: String {
    case north = "북"
    case south = "남"
    case east = "동"
    case west = "서"
} // 원시값 초기화 시키기


var currentCompassPoint: CompassPoint = .north
currentCompassPoint

//switch direction {
//case .north:
//    print(direction.rawValue)
//case .south:
//    print(direction.rawValue)
//case .east:
//    print(direction.rawValue)
//case .west:
//    print(direction.rawValue)
//}
//
//let direction2 = CompassPoint(rawValue: "남")
//
//enum PhoneError {
//
}

