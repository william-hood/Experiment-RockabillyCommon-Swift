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



public class RockabillyFoundation {
    //private static String quickDateFormatString = "yyyy-MM-dd kk-mm-ss.SSS";
    //private static SimpleDateFormat quickDateFormat = new SimpleDateFormat(quickDateFormatString);
    
    /*
    public static String getTimeStamp() {
    return quickDateFormat.format(new Date());
    }
    
    public static BufferedReader openForReading(String filePath)
    throws FileNotFoundException {
    return new BufferedReader(new FileReader(filePath));// (filePath,
    // FileMode.Open,
    // FileAccess.Read,
    // FileShare.Read);
    }
 */

/* Deferred
    // Based on http://stackoverflow.com/questions/24581517/read-a-file-url-line-by-line-in-swift
    public static func readLineFromInputStream (rawInputStream: FileHandle) -> String! {
        let buffer : NSMutableData!
        let delimData : NSData!
        let readLength = 10;
        let encoding : UInt = NSUTF8StringEncoding
    
        // Read data chunks from file until a line delimiter is found:
        var range = buffer.range(of: delimData as Data, options: [], in: NSMakeRange(0, buffer.length))
        while range.location == NSNotFound {
            let tmpData = rawInputStream.readData(ofLength: readLength)
            if tmpData.count == 0 {
                // EOF or read error.
                //atEof = true
                
                if buffer.length > 0 {
                    // Buffer contains last line in file (not terminated by delimiter).
                    let result = NSString(data: buffer as Data, encoding: encoding)
    
                    buffer.length = 0
                    return result as String?
                }
                
                // No more lines.
                return nil
            }
            buffer.append(tmpData)
            range = buffer.range(of: delimData as Data, options: [], in: NSMakeRange(0, buffer.length))
        }
    
        // Convert complete line (excluding the delimiter) to a string:
        let result = NSString(data: buffer.subdata(with: NSMakeRange(0, range.location)), encoding: encoding)
        // Remove line (and the delimiter) from the buffer:
        buffer.replaceBytes(in: NSMakeRange(0, range.location + range.length), withBytes: nil, length: 0)
    
        return result as String?
        
    }
    */
    
    
    
    
    
    

/* Deferred
    public static func readEntireInputStream (rawInputStream: FileHandle) -> String! {
        var check: String? = ""
        var result: String! = nil
        
        while (check != nil) {
            check = readLineFromInputStream(rawInputStream: rawInputStream)
            if (check != nil) {
                if (result == nil) { result = "" }
                result.append(check!)
            }
        }
        
        return result
    }
 */
    
    /*
    // Based on http://stackoverflow.com/questions/5713857/bufferedinputstream-to-string-conversion
    public static final int BUFFER_SIZE = 1024;
    public static String readEntireInputStream(BufferedInputStream rawInputStream) {
    byte[] buffer = new byte[BUFFER_SIZE];
    
    int bytesRead = 0;
    StringBuilder result = new StringBuilder();
    
    try {
    while((bytesRead = rawInputStream.read(buffer)) != -1) {
				result.append(new String(buffer, 0, bytesRead));
    }
    } catch (IOException dontCare) {
    // Deliberate NO-OP -- Assume EOF
    }
    
    return result.toString();
    }
    */
   
    public static func forceParentDirectoryExistence(fileName: String) throws {
        try FileManager.default.createDirectory(atPath: (fileName as NSString).deletingPathExtension, withIntermediateDirectories: true)
    }
    
    /*
    // Based on http://stackoverflow.com/questions/8668905/directory-does-not-exist-with-filewriter
    public static void forceParentDirectoryExistence(String fileName) {
    File file = new File(fileName);
    File parent_directory = file.getParentFile();
    
    if (null != parent_directory) {
    parent_directory.mkdirs();
    }
    
    parent_directory = null;
    file = null;
    }
 */
    
    
    /*
    private static let REPLACER: String  = "\u{25a2}"
    
    public static String filterOutNonPrintables(String candidate) {
    return candidate.replaceAll("\\p{C}", REPLACER);
    }
    
    private static final String nullString = "(null)";
    
    public static String robustGetString(Object candidate) {
    if (candidate == null)
    return nullString;
    try {
    return filterOutNonPrintables(candidate.toString());
    } catch (NullPointerException dontCare) {
    return nullString;
    } catch (Throwable dontCare) {
    return "(ERROR)";
    }
     }
     */
    
    
    #if os(iOS)
    public static var operatingSystemName: String {
        return UIDevice.current().systemName
    }
    
    public static var operatingSystemVersion: String {
        return UIDevice.current().systemVersion
    }
    #endif
    
    // Use FileManager.default.currentDirectoryPath instead
    /*
    public static String getCurrentWorkingDirectory() {
    return System.getProperty("user.dir");
    }
 */
    
    public static var userHomeFolder: String {
    return String(FileManager.default.urlsForDirectory(.userDirectory, inDomains: .userDomainMask))
    }
    
    /* Deferred
    public static String getShortFileName(String completeFilePath) {
    String baseExt = completeFilePath.substring(completeFilePath
				.lastIndexOf(File.separatorChar) + 1);
    if (completeFilePath.contains(".")) {
    return baseExt.substring(0, baseExt.lastIndexOf('.'));
    } else
    return baseExt;
    }
    */
    
    //public static String depictFailure(Throwable thisFailure) {
    //StringWriter stacktraceWriter = new StringWriter();
    //thisFailure.printStackTrace(new PrintWriter(stacktraceWriter));
    ///*
    // * Throwable cause = thisFailure.getCause(); if (cause != null) {
    // * stacktraceWriter.append(Symbols.NewLine);
    // * stacktraceWriter.append("Caused by " + FX.arrow());
    // * stacktraceWriter.append(depictFailure(cause)); }
    // */
    //
    //return stacktraceWriter.toString();
    //}
    
    
    /*
    // From
    // http://stackoverflow.com/questions/2546078/java-random-long-number-in-0-x-n-range
    public static long nextLong(Random rng, long n) {
    // error checking and 2^x checking removed for simplicity.
    long bits, val;
    do {
    bits = (rng.nextLong() << 1) >>> 1;
    val = bits % n;
    } while (bits - val + (n - 1) < 0L);
    return val;
}

public static int randomInt(int min, int max) {
    return min + new Random().nextInt(max - min);
}

public static Integer randomInteger(int min, int max) {
    return randomInt(min, max);
}
 */

    public static func stringIsEmpty (candidate: String! ) -> Bool {
    if candidate == nil { return true }
    if candidate == "" { return true }
    // OBSOLETE in Swift: if (candidate.compareTo(Values.DefaultString) == 0) return true;
    if (candidate.characters.count < 1) { return true }
    return false
    }

    public static func stringsMatch (x: String!, y: String!) -> Bool  {
        if ((x == nil) && (y == nil)) { return true }
        if ((x == nil) && (y != nil)) { return false }
        if ((x != nil) && (y == nil)) { return false }
        return x.compare(y) == ComparisonResult.orderedSame
    }
    
    public static func stringsMatchCaseInspecific (x: String!, y: String!) -> Bool  {
        if ((x == nil) && (y == nil)) { return true }
        if ((x == nil) && (y != nil)) { return false }
        if ((x != nil) && (y == nil)) { return false }
        return x.caseInsensitiveCompare(y) == ComparisonResult.orderedSame
    }
    
    // StringArrayContains (case specific version) is obsolete in Swift
    
    public static func stringArrayContainsCaseInspecific (targetArray: [String], candidate: String) -> Bool {
        for thisTarget: String in targetArray {
            if stringsMatchCaseInspecific(x: thisTarget, y: candidate) { return true }
        }
        
        return false
    }

    
/* Deferred
public static void hardDelete(String fullPath) {
    File check = new File(fullPath);
    if (check.isDirectory()) {
        String[] contents = check.list();
        for (String thisFile : contents) {
            hardDelete(fullPath + File.separator + thisFile);
        }
    }
    
    check.delete();
}
*/
    
/* Deferred
public static void copyCompletely(String sourcePath, String destinationPath) throws IOException {
    File check = new File(sourcePath);
    if (check.isDirectory()) {
        String[] contents = check.list();
        for (String thisFile : contents) {
            copyCompletely(sourcePath + File.separator + thisFile, destinationPath + File.separator + thisFile);
        }
    } else {
        Foundation.forceParentDirectoryExistence(destinationPath);
        Files.copy(check.toPath(), new File(destinationPath).toPath());
    }
}
 */

    public static func sortMarkupTags (target: String) -> [String] {
        var result: [String] = []
        var thisString: String  = ""
        var levelsIn: Int = 0
    
    for thisChar in target.characters {
        if (levelsIn > 0) {
            if (thisChar == "<") { levelsIn += 1; }
            else if (thisChar == ">") { levelsIn -= 1; }
            
            thisString.append(thisChar);
            
            if (levelsIn == 0) {
                if (thisString.characters.count > 0) {
                    result.append(thisString)
                    thisString = ""
                }
            }
        } else {
            if (thisChar == "<") {
                if (thisString.characters.count > 0) {
                    result.append(thisString)
                    thisString = ""
                }
                levelsIn = 1;
            }
            
            thisString.append(thisChar);
        }
    }
    
        if (thisString.characters.count > 0) {
            result.append(thisString)
            thisString = ""
    }
    
    return result;
}
    
    public static func getDimensional(x: Int, y: Int) -> String {
        return "\(x) x \(y)".inParentheses
    }
}
