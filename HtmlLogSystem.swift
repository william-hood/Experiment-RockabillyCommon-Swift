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
public class HtmlLogSystem {
    public static let HTML__LINE_BREAK: String = LineBreak().htmlRendition + Symbols.NewLine
    public static let HTML__DIVIDER: String = Divider().htmlRendition
    public static let HTML__TABLE_BEGIN_DATA_CELL: String = "<td style=\"text-align:left\">"
    public static let HTML__TABLE_END_DATA_CELL: String = "</td>"
    public static let HTML__TABLE_DIVISION: String = HTML__TABLE_END_DATA_CELL + HTML__TABLE_BEGIN_DATA_CELL
    public static let HTML__ROW_START: String = "<tr>"
    public static let HTML__ROW_END: String = "</tr>"
    public static let HTML__TABLE_START: String = "<table class=rockabilly_log_system>" + HTML__ROW_START
    public static let HTML__TABLE_END: String = HTML__ROW_END + "</table>" + HTML__LINE_BREAK
    public static let HTML__SPACE: String = "&nbsp;"
    //private static var LogDateFormatString: String = "[yyyy-MM-dd] [kk:mm:ss.SSS]"
    //private static var LogDateFormat: SimpleDateFormat = SimpleDateFormat(LogDateFormatString)
    public var SHOW_TIME_STAMPS: Bool = true
    //private var autoFlush: Bool = true
    private var resources: HtmlLogSystemResources! = nil
    private var outputs: [String : HtmlLogSystemOutput] = [:]
    
    /*
    public func setManualFlush() {
        autoFlush = false
    }
    
    public func setAutomaticFlush() {
        autoFlush = true
    }
    */
    
    public func addOutput(headLine: String, newOutputWriter: TextOutputManager, newLevel: LoggingLevel = LoggingLevel.Standard, newMode: LoggingMode = LoggingMode.Minimum) throws -> String {
        let newOutput: HtmlLogSystemOutput = try HtmlLogSystemOutput(resources: resources, title: headLine/*RockabillyFoundation.getTimeStamp()*/, newOutputWriter: newOutputWriter, newLevel: newLevel, newMode: newMode)
        outputs[newOutput.identifier] = newOutput
        if !RockabillyFoundation.stringIsEmpty(candidate: headLine) {
            try logHeader(outputIdentifier: newOutput.identifier, headLine: headLine)
        }
        return newOutput.identifier
    }
    
    public func addDefaultOutput() throws -> String! {
        return try addOutput(headLine: "DEFAULT", newOutputWriter: TextOutputManager(), newLevel: LoggingLevel.Standard, newMode: LoggingMode.Minimum)
    }
    
    public func clearSpecificOutput(specificOutputIdentifier: String) throws {
        //var notFound: Bool = true
        //flush()
        
        
        try outputs[specificOutputIdentifier]!.outputWriter.textOut(output: HtmlLogSystem.HTML__TABLE_END)
        try outputs[specificOutputIdentifier]!.outputWriter.textOut(output: (outputs[specificOutputIdentifier]!.outputWebInterface.htmlFooter))
        outputs[specificOutputIdentifier]!.outputWriter.close()
        //outputs[specificOutputIdentifier]?.outputWriter = nil
        outputs.removeValue(forKey: specificOutputIdentifier)    }
    
    public func clearOutputs() throws {
        //flush()

        for thisKey in outputs.keys {
            try clearSpecificOutput(specificOutputIdentifier: thisKey)
        }
        
        outputs.removeAll()
        //System.gc()
    }
    
    // Deliberate -- logToHtml with no OutputIdentifier specified means go to all of them.
    public func logHeader(outputIdentifier: String, headLine: String) throws {
        try logToHtml(outputIdentifier: outputIdentifier, newString: resources.getHtmlLogHeader(headLine: headLine), requestedLevel: LoggingLevel.Critical)
    }
    
    // Deliberate -- logToHtml with no OutputIdentifier specified means go to all of them.
    public func logHeader(headLine: String) throws {
        try logToHtml(newString: resources.getHtmlLogHeader(headLine: headLine), requestedLevel: LoggingLevel.Critical)
    }
    
    // Deliberate -- logToHtml with no OutputIdentifier specified means go to all of them.
    public func logToHtml(newString: String, requestedLevel: LoggingLevel = LoggingLevel.Standard) throws {
        if outputs.count < 1 {
            try addDefaultOutput()
        }
        for thisOutput: HtmlLogSystemOutput in outputs.values {
            if thisOutput.allows(requestedLevel: requestedLevel) {
                try thisOutput.outputWriter.textOut(output: newString)
            }
        }
        /*
        if autoFlush {
            flush()
        }
         */
    }
    
    // Deliberate -- logToHtml with no OutputIdentifier specified means go to all of them.
    public func logToHtml(outputIdentifier: String, newString: String, requestedLevel: LoggingLevel = LoggingLevel.Standard) throws {
        for thisOutput: HtmlLogSystemOutput in outputs.values {
            if thisOutput.identifier == outputIdentifier {
                if thisOutput.allows(requestedLevel: requestedLevel) {
                    try thisOutput.outputWriter.textOut(output: newString)
                }
            }
        }
    }
    
    public func skipLine(logLevel: LoggingLevel = LoggingLevel.Critical) throws {
        try message(message: HtmlLogSystem.HTML__SPACE, requestedLevel: logLevel)
    }
    
    /*
    public func flush() {
        if outputs.count < 1 {
            addDefaultOutput()
        }
        for thisOutput in outputs.values {
            thisOutput.outputWriter.flush()
        }
    }
    */
    
    private static func timeStamp(isPlain: Bool) -> String {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.components([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date)
        
        if isPlain {
            return "\(components.year)-\(components.month)-\(components.day) \(components.hour):\(components.minute):\(components.second):\(components.nanosecond)"
        }

        return "<small>\(components.year)-\(components.month)-\(components.day)</small>\(HtmlLogSystem.HTML__TABLE_DIVISION)\(HtmlLogSystem.HTML__TABLE_DIVISION)<small>\(components.hour):\(components.minute):\(components.second):\(components.nanosecond)</small>"
    }
    
    public static var plainTimeStamp: String {
        return timeStamp(isPlain: true)
    }
    
    public static var htmlTimeStamp: String {
        return timeStamp(isPlain: false)
        //return LogDateFormat.format(Date()).replace(" ", HtmlLogSystem.HTML__TABLE_DIVISION + HtmlLogSystem.HTML__TABLE_DIVISION).replace("[", "<small>").replace("]", "</small>")
    }
    
    private func normalLine(icon: InlineImage!, message: String) -> String {
        var result: String = String(HtmlLogSystem.HTML__ROW_START + HtmlLogSystem.HTML__TABLE_BEGIN_DATA_CELL)
        if SHOW_TIME_STAMPS {
            result.append(HtmlLogSystem.HTML__TABLE_BEGIN_DATA_CELL)
            result.append(HtmlLogSystem.htmlTimeStamp)
            result.append(HtmlLogSystem.HTML__TABLE_END_DATA_CELL)
        }
        result.append(HtmlLogSystem.HTML__TABLE_BEGIN_DATA_CELL)
        if icon == nil {
            result.append(HtmlLogSystem.HTML__SPACE)
        } else {
            result.append(icon.htmlRendition)
        }
        result.append(HtmlLogSystem.HTML__TABLE_DIVISION)
        // // DEBUG
        // // ArrayList<String> messageSorted = RockabillyFoundation.sortMarkupTags(message);
        // // For loop below is to properly handle embedded HTML tags.
        for thisString: String in RockabillyFoundation.sortMarkupTags(target: message) {
            if thisString.hasPrefix("<") {
                if thisString.characters.count > 60 {
                    result.append(Symbols.NewLine + thisString + Symbols.NewLine)
                } else {
                    result.append(thisString)
                }
            } else {
                result.append(thisString.justify(columns: 120).replacingOccurrences(of: Symbols.NewLine, with: "<br>" + Symbols.NewLine))
            }
        }
        result.append(HtmlLogSystem.HTML__TABLE_END_DATA_CELL)
        result.append(HtmlLogSystem.HTML__ROW_END)
        return result
    }
    
    public func message(icon: InlineImage! = nil, message: String, requestedLevel: LoggingLevel = LoggingLevel.Standard) throws {
        try logToHtml(newString: normalLine(icon: icon, message: message), requestedLevel: requestedLevel)
    }
    
    public func showAssertion(assertionMessage: String, mustBeTrue: Bool, requestedLevel: LoggingLevel = LoggingLevel.Critical) throws -> Bool {
        if mustBeTrue {
            try message(icon: resources.passIcon, message: assertionMessage, requestedLevel: requestedLevel)
        } else {
            try message(icon: resources.failIcon, message: assertionMessage, requestedLevel: requestedLevel)
            //flush()
        }
        return mustBeTrue
    }
    
    // leaving out default value for inlineImage      = resources.criticalFailureIcon
    public func showFailure(icon: InlineImage, loggedException: ErrorProtocol, requestedLevel: LoggingLevel = LoggingLevel.Critical) throws {
        // Hack b/c the compiler kept crashing with the default value.
        /*
        if icon == nil {
            icon = resources.criticalFailureIcon
        }
         */

        try message(icon: icon, message: String(loggedException).replacingOccurrences(of: "\t", with: HtmlLogSystem.HTML__SPACE + HtmlLogSystem.HTML__SPACE + HtmlLogSystem.HTML__SPACE + HtmlLogSystem.HTML__SPACE + HtmlLogSystem.HTML__SPACE).replacingOccurrences(of: Symbols.NewLine, with: HtmlLogSystem.HTML__LINE_BREAK), requestedLevel: requestedLevel)
        //flush()
    }
}
