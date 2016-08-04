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


// // These need to be treated separately because they go in the style section.
public protocol InStyleWebImage : WebImage {
    var cssClassName : String { get }
}

public class InStyleImage : WebInterfaceControl {
    var target: InStyleWebImage
    
    init(targetImage: InStyleWebImage) {
        target = targetImage
    }

    public var cssClassString : String {
        var result: String = "img."
        result.append(target.cssClassName)
        result.append(" {")
        result.append(Symbols.NewLine)
        result.append("content:")
        result.append(Symbols.NewLine)
        result.append("url(data:img/")
        result.append(target.imageType)
        result.append(";base64,")
        result.append(target.base64ImageData)
        result.append(");")
        result.append(Symbols.NewLine)
        result.append("}")
        return result
    }
    
    public var htmlRendition : String {
        var result: String = "<img class=\""
		result.append(target.cssClassName)
		result.append("\">")
		return result
    }
}

