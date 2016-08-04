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

public class WebInterface {
    public let HTML_BODY_START: String = "\t<body>"
    public let HTML_BODY_END: String = "\t</body>"
    public var styles: String? = nil
    private var refreshInterval: Int? = nil
    private var pageTitle: String = "Web Interface"
    private var redirectionUrlString: String? = nil
    public var controlsInOrder: [WebInterfaceControl] = []
    public var externalStyleSheetName: String? = nil

    public var refreshIntervalSeconds: Int? {
        get {
            return refreshInterval
        }
        set {
            refreshInterval = newValue
        }
    }

    public func clearRefreshInterval() {
        refreshIntervalSeconds = nil
    }

    public var hasRefreshInterval: Bool {
        get {
            return refreshInterval != nil
        }
    }
    
    public var title: String {
        get {
            return pageTitle
        }
        set {
            pageTitle = newValue
        }
    }
    
    public var style: String? {
        get {
            return styles
        }
        set {
            styles = newValue
        }
    }
    
    public var redirectionURL: String? {
        get {
            return redirectionUrlString
        }
        set {
            redirectionUrlString = newValue
        }
    }

    public func clearRedirectionUrl() {
        redirectionURL = nil
    }

    public var hasRedirectionUrl: Bool {
        return redirectionUrlString != nil
    }

    public var cssStyle: String {
        get {
            var result = ""
            if styles != nil {
                result.append(styles!)
                result.append(Symbols.NewLine)
            }
            return result
        }
    }

    public var hasStyle: Bool {
        return styles != nil
    }

    public var htmlHeader: String {
        var result: String = "<!DOCTYPE html>"
        result.append(Symbols.NewLine)
        result.append("<html>")
        result.append(Symbols.NewLine)
        result.append("\t<head>")
        result.append(Symbols.NewLine)
        result.append("\t\t<title>")
        result.append(pageTitle)
        result.append("</title>")
        result.append(Symbols.NewLine)
        if hasRefreshInterval {
            result.append("\t\t<META HTTP-EQUIV=\"refresh\" CONTENT=\"")
            result.append(String(refreshInterval))
            if hasRedirectionUrl {
                result.append(";URL=\'")
                result.append(redirectionUrlString!)
                result.append("\'")
            }
            result.append("\">")
            result.append(Symbols.NewLine)
        }
        if hasStyle {
            if externalStyleSheetName == nil {
                result.append("<style type=\"text/css\">")
                result.append(Symbols.NewLine)
                result.append(cssStyle)
                result.append("</style>")
            } else {
                result.append("<link rel = \"stylesheet\"")
                result.append("type = \"text/css\"")
                result.append("href = \"")
                result.append(externalStyleSheetName!)
                result.append("\" />")
            }
        }
        result.append("\t</head>")
        result.append(Symbols.NewLine)
        result.append(HTML_BODY_START)
        result.append(Symbols.NewLine)
        return result
    }

    public var htmlFooter: String {
        return HTML_BODY_END + Symbols.NewLine + "</html>"
    }

    
    
    
    public var htmlRendition: String {
        var result = htmlHeader;
        
        for index in 0 ..< controlsInOrder.count {
            result.append("\t\t");
            result.append(controlsInOrder[index].htmlRendition);
            result.append("<br>");
            result.append(Symbols.NewLine);
        }
        
        result.append(htmlFooter);
        return result;
    }
    
    
    
}
