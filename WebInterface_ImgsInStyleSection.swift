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

public class WebInterface_ImgsInStyleSection : WebInterface {
    private var images: [String: InStyleImage] = [:]

	public func useInStyleImage(thisImage: InStyleImage) -> InStyleImage! {
        let key = String(thisImage.dynamicType)
		if images[key] != nil {
			images[key] = thisImage
		}
        
		return thisImage
	}

	public func clearInStyleImages() {
		images.removeAll()
	}

    public override var hasStyle: Bool {
		return (styles != nil) || (images.count > 0)
    }
    
    public override var cssStyle: String {
        get {
            var result: String = super.cssStyle
            if images.count > 0 {
                for thisImage in images.values {
                    result.append(thisImage.cssClassString)
                    result.append(Symbols.NewLine)
                }
            }
            return result
        }
    }
}

