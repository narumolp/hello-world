
import Foundation

public enum printError: Error {
  case invalidArray
}

//
// Description: To left justify each item in array with a padding
// parameter:
//  inArray- the input array whose item will be left justified.
//  totalWidth- The total with of each string in the output array


public func prettyPrint(array inArray: [Int], title: String?) -> printError? {

  let t = (title ?? "").padding(toLength: 7, withPad: " ", startingAt: 0)
  
  guard inArray.count > 0 else {
    print("\(t)  Is something wrong ? I can't find integers collection")
    return printError.invalidArray
  }
  
  let totalWidth = 3
  let str_positions = inArray.map { item -> String in
    let str = "\(item)"
    let str_padded = str.padding(toLength: totalWidth, withPad: " ", startingAt: 0)
    return str_padded.replacingOccurrences(of: "\"", with: "")
  }
  print("\(t) \(str_positions)")
  return nil
}


