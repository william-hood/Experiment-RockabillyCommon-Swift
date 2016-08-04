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



public class MatchList {
    public var contents: [String] = []
    
    public init() {
    }
    
    public init(arrayOfStrings: [String]) {
        self.contents.append(contentsOf: arrayOfStrings)
    }
    
    public func matches(candidateString: String) -> Bool {
        for thisListedString in contents {
            if candidateString.contains(thisListedString) {
                return true
            }
        }
        return false
    }
    
    public func contains(candidateString: String) -> Bool {
        for thisListedString in contents {
            if thisListedString == candidateString {
                return true
            }
        }
        return false
    }
    
    public func matchesCaseInspecific(candidateString: String) -> Bool {
        for thisListedString in contents {
            if candidateString.uppercased().contains(thisListedString.uppercased()) {
                return true
            }
        }
        return false
    }
    
    public func containsCaseInspecific(candidateString: String) -> Bool {
        for thisListedString in contents {
            if thisListedString.caseInsensitiveCompare(candidateString) == ComparisonResult.orderedSame {
                return true
            }
        }
        return false
    }
}

