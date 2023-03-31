import Foundation

public enum CSVDelimiter: Codable, Equatable, Sendable  {
    case comma, semicolon, tab
    case character(String)

    init(rawValue: String) {
        switch rawValue {
        case ",":  self = .comma
        case ";":  self = .semicolon
        case "\t": self = .tab
        default:   self = .character(rawValue)
        }
    }

    public var rawValue: String {
        switch self {
        case .comma: return ","
        case .semicolon: return ";"
        case .tab: return "\t"
        case .character(let character): return character
        }
    }
}