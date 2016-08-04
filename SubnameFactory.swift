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

// // Based on http://en.wikipedia.org/wiki/Hexavigesimal
public class SubnameFactory {
    private static let DEFAULT_PLACE_HOLDER: Character = "."
	private var index: Int! = nil
    public var places: Int! = nil
	public var placeholder: Character = DEFAULT_PLACE_HOLDER

	public init(startingIndex: Int = 0, totalPlaces: Int = 3) {
        index = startingIndex
        places = totalPlaces
	}
    
    public var nextIndex: Int {
        advance()
        return index
    }

    public var currentIndex: Int {
		return index
	}

	public func advance() {
        index = index + 1
	}
    
    public var nextSubname: String {
        advance()
        return currentSubname
    }
    
    public var currentSubname: String! {
        var result: String = ""
        var cursor: Int = index
        while cursor > 0 {
            cursor -= 1
            
            
            result.append(Character(UnicodeScalar(Int(("A" as UnicodeScalar).value) + (cursor % 26))))
            cursor = cursor / 26
        }
        return prepend(result: String(result.characters.reversed()))
    }

	private func prepend(result: String) -> String! {
		var prefix: String = ""
		if places > 0 {
			if result.characters.count < places {
				prefix = String.createFromBasisChar(basisChar: placeholder, count: places - result.characters.count)
			}
		}
		return prefix + result
	}
}

