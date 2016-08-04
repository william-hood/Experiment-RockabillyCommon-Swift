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

public enum CantOutput: ErrorProtocol {
    case ToStdOut
    case ToCreateFile
    case ToExistingStream
}

public class TextOutputManager {
    
    /*
 
    This and/or Logger will need redesign for Swift 3.0

    Initially create using Cocoa. Port to generic CoreLibs when they're ready.
     */
    
    
    
    // // Creates a file with header only if the first call to write is made.
    // // Delimited data to use???
    // // Need method to properly flush and close.
    private var internalOutputStream: NSOutputStream! = nil
    private var expectedFileName: String! = nil
    private var shouldAppend: Bool! = nil
    
    public init() {
    }
    
    init(outputStream: NSOutputStream) {
        internalOutputStream = outputStream
    }
    
    convenience init(filename: String) {
        self.init(filename: filename, append: false)
    }
    
    init(filename: String, append: Bool) {
        expectedFileName = filename
        shouldAppend = append    }
    
    private func createOutputStreamIfNeeded() throws {
        if internalOutputStream == nil {
            if expectedFileName == nil {
                print("TextOutputManager to stdout is not supported");
                throw CantOutput.ToStdOut
            } else {
                //try RockabillyFoundation.forceParentDirectoryExistence(expectedFileName)
                internalOutputStream = NSOutputStream(toFileAtPath: expectedFileName, append: shouldAppend)
               
                
                //print("WARNING: Could not create output file \(expectedFileName)");
                //throw CantOutput.ToCreateFile
            }
        }
    }
    
    public func textOut(output: String) throws {
        try createOutputStreamIfNeeded()
        let outputData: NSData = (output + Symbols.NewLine).data(using: String.Encoding.utf8)!
        internalOutputStream!.write(UnsafePointer<UInt8>(outputData.bytes), maxLength: outputData.length)
    }
    
    // public func flush() { }
    
    public func close() {
        internalOutputStream!.close()
        internalOutputStream = nil    }
}

