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

import Foundation


// Deprecated: Use replaceCharacters instead of filterString
//public static String filterString(String message) {
//    return message.replace("\r", "");
//}

public extension String {
    
    
    
    public func justify(columns: Int = 75) -> String {
        var justifiedMessage = ""
        
        // Before splitting the message into words, illegal characters must be stripped out.
        // Probably best to remake the func in RockabillyFoundation that strips away
        // unprintable chars and use that.
        
        var parsedMessage: [String] = self.filterOutNonPrintables(replacement: "").characters.split(separator: " ").map(String.init)
        
        var columnIndex: Int = 0
        
        for cursor in 0 ..< parsedMessage.count {
            if (parsedMessage[cursor].characters.count >= columns) {
                //parsedMessage[cursor] = parsedMessage[cursor].substring(0, columns - 1);
                //string1.index(string1.endIndex, offsetBy: -4)
                //let range = parsedMessage[cursor].startIndex ... parsedMessage[cursor].index(parsedMessage[cursor].startIndex, offsetBy: columns)
                parsedMessage[cursor] = parsedMessage[cursor].substring(to: parsedMessage[cursor].index(parsedMessage[cursor].startIndex, offsetBy: columns))//columns - 1)
            }
            
            parsedMessage[cursor] += " "
            if ((columnIndex + parsedMessage[cursor].characters.count) > columns) {
                // This word will exceed the number of columns. Add a line break
                // before the word.
                justifiedMessage += Symbols.NewLine;
                columnIndex = 0
            }
            
            justifiedMessage += parsedMessage[cursor];
            columnIndex += parsedMessage[cursor].characters.count
        }
        
        return justifiedMessage
    }
    
    
    public func padVertical(justification: VerticalJustification, addHorizontalSpaces: Bool, totalRows: Int) -> String {
        var paddedMessage: String = self
    
        let splitMessage: [String] = self.replacingOccurrences(of: "\r", with: "").characters.split(separator: "\n").map(String.init)
        
    if (totalRows <= splitMessage.count) {
    return paddedMessage;
    }
    
        var emptyLine: String = Symbols.NewLine
    if (addHorizontalSpaces) {
        var maxHorz: Int = 0
    for cursor in 0 ..< splitMessage.count {
        if splitMessage[cursor].characters.count > maxHorz {
            maxHorz = splitMessage[cursor].characters.count
        }
    }
    
    emptyLine = String.createFromBasisChar(basisChar: " ", count: maxHorz) + Symbols.NewLine
    }
    
        var topPadding: Int = (totalRows - splitMessage.count) / 2
    paddedMessage = ""
    
    switch (justification) {
    case VerticalJustification.BOTTOM:
    topPadding = totalRows - splitMessage.count
    
    case VerticalJustification.TOP:
    topPadding = 0
    
    default:
    topPadding = (totalRows - splitMessage.count) / 2
        
        }
    
        var pads: Int = topPadding
    
    for _ in 1 ... pads {
        paddedMessage.append(emptyLine)
    }
    
    for cursor in 0 ..< splitMessage.count {
        paddedMessage.append(splitMessage[cursor] + Symbols.NewLine)
        pads = pads + 1
    }
    
    while (pads < totalRows) {
        paddedMessage.append(emptyLine)
        pads = pads + 1
    }

    // Deliberate
    // for (pads = pads; pads < totalRows; pads++)
    // {
    // paddedMessage += emptyLine;
    // }
    
    return paddedMessage
    }
    
    public func prependAllLinesWith(prependString: String) -> String {
        return prependString + self.replacingOccurrences(of: Symbols.NewLine, with: Symbols.NewLine + prependString)
    }
    
    public func indent(indentSize: Int) -> String {
        return String.createFromBasisChar(basisChar: " ", count: indentSize) + self
    }
    
    public func pad(whichSide: PaddingSide = PaddingSide.BOTH_SIDES, paddingCharacter: Character = " ", totalWidth: Int) -> String {
        let surplus = totalWidth - self.characters.count
        if surplus < 1 { return self }
        
        var result = ""
        
        switch whichSide {
        case PaddingSide.LEFT:
            result.append(String.createFromBasisChar(basisChar: paddingCharacter, count: totalWidth))
            result.append(self)
            
        case PaddingSide.RIGHT:
            result.append(self)
            result.append(String.createFromBasisChar(basisChar: paddingCharacter, count: totalWidth))
            
        default:
            let halfSurplus: Int = surplus / 2
            result.append(String.createFromBasisChar(basisChar: paddingCharacter, count: halfSurplus))
            result.append(self)
            result.append(String.createFromBasisChar(basisChar: paddingCharacter, count: halfSurplus))
        }
        
        while (result.characters.count < totalWidth) {
    if (whichSide == PaddingSide.LEFT) {
    result = "\(paddingCharacter)\(self)"
    } else {
    result.append(paddingCharacter)
    }
    }
    
    return result
    }
    
    
    
    // Java version: ("\n\t\r\f\b"); // \v \a // also in the C# version
    private static let DEFAULT_REPLACEMENT: String = "\u{25a2}" // Shows as a square with rounded edges
    
    public func filterOutNonPrintables(replacement: String = String.DEFAULT_REPLACEMENT) -> String {
        return self.replacingOccurrencesOfAnyOfTheseCharacters(targets: ["\n", "\r", "\t", "\0"], replacement: replacement)
    }
    
    
    
    public func replacingOccurrencesOfAnyOfTheseCharacters(targets: [Character], replacement: String = String.DEFAULT_REPLACEMENT) -> String {
        var result = ""
        for thisCharacter in self.characters {
            if targets.contains(thisCharacter) {
                result.append(replacement)
            } else {
                result.append(thisCharacter)
            }
        }
        return result
    }
    
    public static func createFromBasisChar (basisChar: Character, count: Int) -> String {
        return String(Array(repeating: basisChar, count: count))
    }
    
    public func repeated(times: Int) -> String{
        var result = ""
        for _ in 1 ... times {
            result.append(self)
        }
        
        return result
    }
    
    public var inParentheses: String {
        return "(\(self))"
    }
    
    public var inQuotes: String {
        return "\"" + self + "\""
    }
    
    public var inSingleQuotes: String {
        return "'\(self)'"
    }
    
    
}
