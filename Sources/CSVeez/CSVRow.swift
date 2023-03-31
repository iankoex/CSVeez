public struct CSVRow: Codable, Equatable, Sendable {
    public var columns: [CSVRowColumn]

    public init(columns: [CSVRowColumn]) {
        self.columns = columns
    }
}

public enum CSVRowColumn: Codable, Equatable, Sendable {
    case int(Int)
    case double(Double)
    case string(String)
    // case date(Date)

    public typealias RawValue = String

    public var rawValue: String {
        switch self {
            case.int(let value): 
            return String(value)
            case.double(let value): 
            return String(value)
            case.string(let value): 
            return value
            // case.date(let value): 
            // return String(value)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // self.name = try container.decode(String.self, forKey: .name)
        if let value: Double = try? container.decode(Double.self, forKey: .double) {
            self = .double(value)
        } else if let value: Int = try? container.decode(Int.self, forKey: .int) {
            self = .int(value)
        } else if let value: String = try? container.decode(String.self, forKey: .string) {
            self = .string(value)
        } else {
            throw DecodingError.typeMismatch(CSVRowColumn.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CSVRowColumn"))
        }
    }

    // public init(from decoder: Decoder) throws {
    //     let container = try decoder.singleValueContainer()
    //     if let x: Int = try? container.decode(Int.self) {
    //         self = .int(x)
    //         return
    //     }
    //     if let x: String = try? container.decode(String.self) {
    //         self = .string(x)
    //         return
    //     }
    //     if let x: Double = try? container.decode(Double.self) {
    //         self = .double(x)
    //         return
    //     }
    //     throw DecodingError.typeMismatch(CSVRowColumn.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CSVRowColumn"))
    // }

    // public func encode(to encoder: Encoder) throws {
    //     var container = encoder.singleValueContainer()
    //     switch self {
    //     case .int(let x):
    //         try container.encode(x)
    //     case .string(let x):
    //         try container.encode(x)
    //     case .double(let x):
    //         try container.encode(x)
    //     }
        
    // }
}