import Foundation

enum CSVError: LocalizedError {
    case convertionToDataFailed

    var localisedDescription: String {
        let base: String = "CSV operation couldn't be completed. "
        switch self {
        case .convertionToDataFailed: 
        return base + "Conversion to Data Failed"
        }
    }
}