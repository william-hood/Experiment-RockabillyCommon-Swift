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

public class ConjoinedControls : WebInterfaceControl {
    private var orientation: ConjoinedControlsOrientation = ConjoinedControlsOrientation.AlphaAbove
    var contentAlpha: WebInterfaceControl! = nil
    var contentOmega: WebInterfaceControl! = nil
    
    init(alpha: WebInterfaceControl, omega: WebInterfaceControl, position: ConjoinedControlsOrientation) {
        contentAlpha = alpha;
        contentOmega = omega;
        orientation = position;
    }
    
    public var htmlRendition : String {
        var result: String = "<table border=\"0\">"
        
        switch (orientation) {
        case ConjoinedControlsOrientation.AlphaAbove:
            result.append("<tr>")
            result.append(contentAlpha.htmlRendition)
            result.append("</tr><tr>")
            result.append(contentOmega.htmlRendition)
            result.append("</tr>")
            break;
        case ConjoinedControlsOrientation.AlphaBelow:
            result.append("<tr>")
            result.append(contentOmega.htmlRendition)
            result.append("</tr><tr>")
            result.append(contentAlpha.htmlRendition)
            result.append("</tr>")
            break;
        case ConjoinedControlsOrientation.AlphaLeft:
            result.append("<tr><td>")
            result.append(contentAlpha.htmlRendition)
            result.append("</td><td>&nbsp;</td><td>")
            result.append(contentOmega.htmlRendition)
            result.append("</td></tr>")
            break;
        case ConjoinedControlsOrientation.AlphaRight:
            result.append("<tr><td>")
            result.append(contentOmega.htmlRendition)
            result.append("</td><td>&nbsp;</td><td>")
            result.append(contentAlpha.htmlRendition)
            result.append("</td></tr>")
            break;
        }
        
        result.append("</table>");
        
        return result
    }
}
