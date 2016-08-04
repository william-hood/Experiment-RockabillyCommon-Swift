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


public class TiledControl : WebInterfaceControl { 
	 var content: WebInterfaceControl
	public var foregroundColor: String? = "FFFFFF"
	public var backgroundColor: String? = "000000"

	public init(control: WebInterfaceControl) {
		content = control
	}

	public init(caption: String) {
		content = Label(text: caption, fontSize: 100)
	}

	public init(caption: String, fontSize: Int) {
		content = Label(text: caption, fontSize: fontSize)
	}

	public var htmlRendition : String {
		var result: String = "<table border=\"0\"><tr><td><div style=\"padding:25px;text-align:center;vertical-align:middle;"
		if backgroundColor != nil {
			result.append("background-color:#")
			result.append(backgroundColor!)
			result.append(";")
		}
		if foregroundColor != nil {
			result.append("color:#")
			result.append(foregroundColor!)
			result.append(";")
		}
		result.append("\">")
		result.append(content.htmlRendition)
		result.append("</div></td></tr></table>")
		return result
	}
}

