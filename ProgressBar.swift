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


public class ProgressBar : WebInterfaceControl { 
	private var value: Int! = nil
	private var max: Int! = nil

	public init() {
		// Indeterminate Throbber
		max = 100
	}

	public init(currentProgress: Int, maximum: Int) {
        var progress = currentProgress
		value = progress
		max = maximum
		if progress < 0 {
			progress = 0
		}
		if max < progress {
			max = progress
		}
	}

    public var widthPixels: Int {
		return 600
	}

    public var heightPixels: Int {
		return 50
	}

	public var htmlRendition : String {
		var result: String = "<progress "
		result.append("style=\"border:0; width:")
		result.append(String(widthPixels))
		result.append("px; height:")
        result.append(String(heightPixels))
		result.append("px;\" ")
		if value != nil {
			result.append("value=\"")
			result.append(String(value))
			result.append("\" ")
		}
		result.append("max=\"")
		result.append(String(max))
		result.append("\"")
		result.append("></progress>")
		return result
	}
}

