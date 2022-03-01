import Glibc
import Foundation

struct Market {
   let transactionCount: Int
   let buyCount: Int
   let totalVolume: Double
   let totalPrice: Double

   var averagePrice: Double {
      totalPrice / Double(transactionCount)
   }
   var averageVolume: Double {
      totalVolume / Double(transactionCount)
   }
   var volumeWeightedAveragePrice: Double {
      totalVolume / averagePrice
   }
   var percentageBuy: Double {
      Double(buyCount) / Double(transactionCount)
   }
}

var begin = false // Track 'BEGIN' to start parsing
var markets: [Int: Market] = [:] // Dictionary, key = market id, value = struct Market 
var count = 0 // For debugging

// Read stdin in chunks
let length = 1024
let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: length)
let start = ProcessInfo.processInfo.systemUptime
while fgets(buffer, Int32(length), stdin) != nil {
   let content = String(cString: buffer)
      // "fgets() reads in at most one less than size characters from stream and stores them into the buffer pointed to by s. 
      // Reading stops after an EOF or a newline. If a newline is read, it is stored into the buffer. 
      // A terminating null byte (aq\0aq) is stored after the last character in the buffer."
      .dropLast()
   
   if content == "BEGIN" {
      begin = true
      continue
   }
   if content == "END" {
      break
   }
   if begin {
      do {
         guard let data = content.data(using: .utf8) else { fatalError("data == nil") }

         if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            //guard let id     = json["id"] as? Int else { fatalError("id == nil") }
            guard let market = json["market"] as? Int else { fatalError("market == nil") }
            guard let price  = json["price"] as? Double else { fatalError("price == nil") }
            guard let volume = json["volume"] as? Double else { fatalError("volume == nil") }
            guard let isBuy  = json["is_buy"] as? Bool else { fatalError("is_buy == nil") }

            // If the market exists in the dictionary, sum the data and save the new struct in the dictionary 
            if let m = markets[market] { 
               markets[market] = Market(transactionCount: m.transactionCount + 1, 
                                        buyCount: m.buyCount + (isBuy ? 1 : 0), 
                                        totalVolume: m.totalVolume + volume, 
                                        totalPrice: m.totalPrice + price)
            } 
            // New market; create a new entry in the dictionary
            else {
               markets[market] = Market(transactionCount: 1, buyCount: isBuy ? 1 : 0, totalVolume: volume, totalPrice: price)
            }
            // Uncomment to see real-time progress
            //print("\(id) \r", terminator: "")
            //fflush(stdout)
         } else {
            fatalError("json == nil")
         }
      } catch let e {
         fatalError(e.localizedDescription)
      }
   }
   //if count > 1_000_000 { break }; count += 1; // uncommnet to test 1_000_000 records
}
for (key, m) in markets {
   print("{\"market\":\(key),\"total_volume\":\(m.totalVolume),\"mean_price\":\(m.averagePrice),\"mean_volume\":\(m.averageVolume),\"volume_weighted_average_price\":\(m.volumeWeightedAveragePrice),\"percentage_buy\":\(m.percentageBuy)}")
}
print("It took: \(ProcessInfo.processInfo.systemUptime - start) secs.")
