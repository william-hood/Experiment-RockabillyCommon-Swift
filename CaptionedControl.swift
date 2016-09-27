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

public class CaptionedControl : WebInterfaceControl {
    private var orientation: CaptionedControlOrientation = CaptionedControlOrientation.AboveCaption
    private var text: Label! = nil
    private var content: WebInterfaceControl! = nil
    private var textAlignment: HorizontalJustification = HorizontalJustification.CENTER

    
    init(control: WebInterfaceControl, caption: Label, position: CaptionedControlOrientation) {
        content = control;
        text = caption;
        orientation = position;
        guessJustification();
    }
    
    convenience init(control: WebInterfaceControl, caption: String, position: CaptionedControlOrientation) {
        self.init(control: control, caption: Label(text: caption, fontSize: 100), position: position)
    }
    
    convenience init(control: WebInterfaceControl, caption: String, fontSize: Int, position: CaptionedControlOrientation) {
        self.init(control: control, caption: Label(text: caption, fontSize: fontSize), position: position)
    }
    
    
    public var caption: Label {
        return text
    }
    
    private func guessJustification() {
        switch (orientation) {
        case CaptionedControlOrientation.AboveCaption:
            textAlignment = HorizontalJustification.CENTER
            break

        case CaptionedControlOrientation.BelowCaption:
            textAlignment = HorizontalJustification.CENTER
            break
        case CaptionedControlOrientation.LeftOfCaption:
            textAlignment = HorizontalJustification.RIGHT
            break
        case CaptionedControlOrientation.RightOfCaption:
            textAlignment = HorizontalJustification.RIGHT
            break
        }
    }
    
    private func contentAlignment() -> HorizontalJustification {
        if textAlignment == HorizontalJustification.LEFT {
            return HorizontalJustification.RIGHT
        }
        
        if textAlignment == HorizontalJustification.RIGHT {
            return HorizontalJustification.LEFT
        }
        
    return textAlignment
    }
    
    private func renderLabel() -> String {
        var result: String = "<td><div style=\"text-align:"
        result.append(textAlignment.rawValue)
        result.append(";\">")
        result.append(text.htmlRendition)
        result.append("</div></td>")
        return result
    }
    
    private func renderContent() -> String {
        var result: String = "<td><div style=\"text-align:"
        result.append(contentAlignment().rawValue)
        result.append(";\">")
        result.append(content.htmlRendition)
        result.append("</div></td>")
        return result
    }
    
    public var htmlRendition: String {
        var result: String = "<table border=\"0\">"
        
        switch (orientation) {
        case CaptionedControlOrientation.AboveCaption:
            result.append("<tr>")
            result.append(renderContent())
            result.append("</tr><tr>")
            result.append(renderLabel())
            result.append("</tr>")
            break
        case CaptionedControlOrientation.BelowCaption:
            result.append("<tr>")
            result.append(renderLabel())
            result.append("</tr><tr>")
            result.append(renderContent())
            result.append("</tr>")
            break
        case CaptionedControlOrientation.LeftOfCaption:
            result.append("<tr>")
            result.append(renderContent())
            result.append("<td>&nbsp;</td>")
            result.append(renderLabel())
            result.append("</tr>")
            break
        case CaptionedControlOrientation.RightOfCaption:
            result.append("<tr>")
            result.append(renderLabel())
            result.append("<td>&nbsp;</td>")
            result.append(renderContent())
            result.append("</tr>")
            break
        }
        
        result.append("</table>")
        return result
    }
}
