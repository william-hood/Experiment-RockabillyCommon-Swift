/*******************************************************************************
 * Copyright (c) 2016 William Arthur Hood
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 ******************************************************************************/

public class DelimitedDataManager {
    public static let DEFAULT_DELIMITER: Character = ","
    public static let DEFAULT_SPACING: Int = 1
    // public let DEFAULT_EXTENSION: String = "csv"
    
    private var headers: [String] = []
    private var data:[[String]] = [[]]
    
    public var delimiter: Character = DEFAULT_DELIMITER
    public var spacing = DEFAULT_SPACING
    
    public init (delimitingChar: Character = DEFAULT_DELIMITER, spacesAfterDelimitingChar: Int = DEFAULT_SPACING, columnNames: String...) {
        headers.append(contentsOf: columnNames)
        delimiter = delimitingChar
        spacing = spacesAfterDelimitingChar
    }
    
    private init() {
        // Default initializer for internal use only
    }
    
    public func stripDelimiters(input: String) -> String {
            return input.replacingOccurrences(of: String(delimiter), with: " ")
    }
    
    public var allData: [[String]] {
        return data;
    }
    
    public func addDataRow(newDataRow: [String]) {
        data.append(newDataRow)
    }
    
    public func removeDataRow(columnName: String, value: String) {
    let dataRow: Int! = getDataRowIndex(columnName: columnName, value: value)
        if (dataRow != nil) {
            data.remove(at: dataRow)
        }
    }

    public var headerCount: Int {
        return headers.count
    }
    
    public func getDataRow(columnName: String, value: String) -> [String]? {
        let row: Int! = getDataRowIndex(columnName: columnName, value: value)
        if (row == nil) { return nil }
        return data[row]
    }
    
    public func getDataRowIndex(columnName: String, value: String) -> Int? {
        var selectedColumn: Int! = nil
    
        for columnCursor in 0 ..< headers.count {
            if (headers[columnCursor] == columnName) {
                selectedColumn = columnCursor
                break
            }
        }
    
        if (selectedColumn == nil) { return nil }
        
        for rowCursor in 0 ..< data.count {
            if data[rowCursor][selectedColumn] == value {
                return rowCursor
            }
        }
        
    return nil
    }
    
    public func hasDataRow(columnName: String, value: String) -> Bool {
        return (getDataRowIndex(columnName: columnName, value: value) != nil)
    }
    
    public func dataRowFromTextLine(textLine: String) -> [String] {
        var result: [String] = []
        
        for thisColumnValue: String in textLine.characters.split(separator: delimiter).map(String.init) {
            result.append(thisColumnValue.replacingOccurrences(of: String(delimiter), with: ""))
        }
        
        return result
    }
    
    private func lineOut(dataRow: [String]) -> String {
        var result: String = ""
        for thisString: String in dataRow {
            if result.characters.count > 0 {
                result.append(delimiter)
                result.append(String.createFromBasisChar(basisChar: " ", count: spacing))
            }
            
            result.append(thisString)
        }
    
    return result
    }
    
    public func toFile(completeFilePath: String, append: Bool = true) throws {
        let thisOutputManager = TextOutputManager(filename: completeFilePath, append: append)
        
        try thisOutputManager.textOut(output: lineOut(dataRow: headers))
    
        for thisData: [String] in data {
            try thisOutputManager.textOut(output: lineOut(dataRow: thisData))
        }
    
        thisOutputManager.close()
    }
    
    
    public static func fromFile(completeFilePath: String, delimitingCharacter: Character = DEFAULT_DELIMITER) throws -> DelimitedDataManager {
        
        let dataFromFile = DelimitedDataManager()
        dataFromFile.delimiter = delimitingCharacter
        
        var gotHeaders = false
        for currentLine in try String(contentsOfFile: completeFilePath).characters.split(separator: "\n").map(String.init) {
            if gotHeaders {
                dataFromFile.addDataRow(newDataRow: dataFromFile.dataRowFromTextLine(textLine: currentLine.replacingOccurrences(of: String("\r"), with: "")))
            } else {
                dataFromFile.headers = dataFromFile.dataRowFromTextLine(textLine: currentLine.replacingOccurrences(of: String("\r"), with: ""))
                gotHeaders = true
            }
        }
        
        return dataFromFile
    }
}
