import XCTest
@testable import CSVeez

final class CSVeezTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CSVeez().text, "Hello, World!")
    }

    func testRawValue() async throws {
        let csvRawValue: String = "name,number\nsam,1\n"
        let fields: [CSVField] = [CSVField(name: "name"), CSVField(name: "number")]
        let row: CSVRow = CSVRow(columns: [CSVRowColumn.string("sam"), CSVRowColumn.int(1)])
        let csv: CSV = CSV(fields: fields, rows: [row], delimiter: .comma)
        let generatedRaw: String = try await csv.getRawValue()
        
        XCTAssertEqual(csvRawValue, generatedRaw)
    }

    func testCSVDecode() throws {
        let csvData: Data? = """
        {
            "fields":[{
                "name":"name"
            },{
                "name":"number"
            }],
            "rows":[{
                "column":["sam", "1"]
            }],
            "delimiter":","
        }
        """.data(using: .utf8)
        guard let csvData: Data = csvData else {
            throw XCTestError(.init(rawValue: 2)!)
        }
        let fields: [CSVField] = [CSVField(name: "name"), CSVField(name: "number")]
        let row: CSVRow = CSVRow(columns: [CSVRowColumn.string("sam"), CSVRowColumn.string("1")])
        let csv: CSV = CSV(fields: fields, rows: [row], delimiter: .comma)
        let decodedCSV: CSV = try JSONDecoder().decode(CSV.self, from: csvData)

        XCTAssertEqual(csv, decodedCSV)
    }
}
