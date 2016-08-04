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


public class Label : WebInterfaceControl { 
	private var textSize: Int
	private var labelText: String! = nil

	public init(text: String, fontSize: Int = 100) {
		labelText = text
        textSize = fontSize
	}
    
    public var fontSize: Int {
        get {
            return textSize
        }
        set {
            textSize = newValue
            if textSize < 1 {
                textSize = 1
            }
        }
    }

    public var htmlRendition: String {
		var result = "<div style=\"font-size:"
		result.append(String(textSize))
		result.append("%;\">")
		result.append(labelText)
		result.append("</div>")
		return result
	}
}

