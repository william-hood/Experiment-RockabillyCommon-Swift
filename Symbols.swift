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

// VALUES CLASS IS DEPRECATED
//private static var random: Random! = Random()

// NO NEED FOR DEFAULT VALUES IN SWIFT
// An implicitly unwrapped String! can start as nil, but never be nil
// again once assigned a value.
//
// ALL DefaultType VALUES ARE DEPRECATED FOR THE SWIFT REWRITE
//public static let DefaultString: String! = "---UNSET---"
//public static let DefaultInt: Int = Int.min
//public static let DefaultFloat: Double = Double.infinity
//public static let DefaultDate: NSDate = NSDate.distantPast

public class Symbols {
    
    public static let π = Double.pi
    
    // PlatformNewLine
    // Will need to define a property that spits out
    // \r\n for Windows and just \n otherwise
    
    
    public static let NewLine: String! = "\r\n"
    public static let Copyright = "\u{00a9}"
    public static let RegisteredTM = "\u{00ae}"
    public static let Yen = "\u{00a5}"
    public static let Pound = "\u{00a3}"
    public static let Cent = "\u{00a2}"
    public static let Dollar = "$"
    public static let Paragraph = "\u{00b6}"
    public static let OpenAngleQuote = "\u{00ab}"
    public static let CloseAngleQuote = "\u{00bb}"
    public static let Degree = "\u{00b0}"
    public static let Space = " "
    public static let ERASER = "\u{0008}"
    
    
    
    
    public static let DEFAULT_DIVIDER_LENGTH: Int = 79
    public static let SINGLE_DIVIDER = "_"
    public static let DOUBLE_DIVIDER = "="
    
    public static func Divider(typeToUse: DividerTypes = DividerTypes.SINGLE, length: Int = DEFAULT_DIVIDER_LENGTH) -> String {
        var dividerChar = DOUBLE_DIVIDER
        var dividerString = ""
        
        if (typeToUse == DividerTypes.SINGLE) {
            dividerChar = SINGLE_DIVIDER
        }
        
        for _ in 1...length {
            dividerString += dividerChar
        }
        
        return dividerString
    }
}
