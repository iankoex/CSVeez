import Foundation 

public struct CSV: Codable, Equatable, Sendable {
    public var fields: [CSVField]
    public var rows: [CSVRow]
    public var delimiter: CSVDelimiter

    public init(fields: [CSVField], rows: [CSVRow], delimiter: CSVDelimiter = .comma) {
        self.fields = fields
        self.rows = rows
        self.delimiter = delimiter
    }
}

extension CSV {
    public func getRawValue(skipValidation: Bool = false) async throws -> String {
        var csvRawValue: String = ""
        let lastField: CSVField = self.fields.last ?? self.fields[0]
        for field in fields {
            csvRawValue.append(contentsOf: field.name)
            if field != lastField {
                csvRawValue.append(contentsOf: delimiter.rawValue)
            }
        }
        csvRawValue.append(contentsOf: "\n")
        for row in rows {
            let lastColumn: CSVRowColumn = row.columns.last ?? row.columns[0]
            for column in row.columns {
                csvRawValue.append(contentsOf: column.rawValue)
                if column != lastColumn {
                    csvRawValue.append(contentsOf: delimiter.rawValue)
                }
            }
            csvRawValue.append(contentsOf: "\n")
        }
        return csvRawValue
    }

    public func validate() {

    }

    public func saveToDisk(withFileName fileName: String) async throws {
        let directory: URL = FileManager.default.temporaryDirectory.appendingPathComponent("CSVeez")
        if !FileManager.default.fileExists(atPath: directory.path) {
            try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        }
        let fileURL: URL = directory.appendingPathComponent(fileName).appendingPathExtension("csv")
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try? FileManager.default.removeItem(at: fileURL)
        }
        let data: Data? = try await self.getRawValue().data(using: .utf8)
        guard let data = data else {
            throw CSVError.convertionToDataFailed
        }
        try data.write(to: fileURL)
    }
}