//: Playground - noun: a place where people can play

import UIKit


var array = Array<AnyObject>()
array.append(12)
array.append(13)
array.append("nihao")

var copy1 = array

copy1.removeFirst()

for a in array  where a is String {
    print(a)
}
print(array.count)
print(copy1.count)


for (n ,element) in array.enumerate() {
    print("index\(n):\(element)")
}



enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.Ace
let aceRawValue = ace.rawValue




enum ServerResponse{
    case Result(String, String)
    case Error(String)
}

var  success = ServerResponse.Result("6:00 am", "8:09 pm")
var  failure = ServerResponse.Error("Out of cheese.")



switch success {
case  let .Result(sunrise,sunset):
    let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Error(error):
    let serverResponse = "Failure...  \(error)"
}




