import Foundation

struct Review: Decodable {
    var name: String? = nil
    var avatar: String? = nil
    var score: UInt = 0
    var timepassed: String = "1 minute"
    var source: String = "hitta.se"
    var comment: String? = nil
}
