import Glibc
import Foundation

public enum Token {
    case Define
    case Identifier(String)
    case Number(Float)
    case ParensOpen
    case ParensClose
    case Comma
    case Other(String)
}

typealias TokenGenerator = (String) -> Token?
let tokenList: [(String, TokenGenerator)] = [
    ("[ \t\n]", { _ in nil }),
    ("[a-zA-Z][a-zA-Z0-9]*", { $0 == "def" ? .Define : .Identifier($0) }),
    ("[0-9.]+", { (r: String) in .Number((r as NSString).floatValue) }),
    ("\\(", { _ in .ParensOpen }),
    ("\\)", { _ in .ParensClose }),
    (",", { _ in .Comma }),
]
var expressions = [String: NSRegularExpression]()
public extension String {
    public func match(regex: String) -> String? {
        let expression: NSRegularExpression
        if let exists = expressions[regex] {
            expression = exists
        } else {
            expression = try! NSRegularExpression(pattern: "^\(regex)", options: [])
            expressions[regex] = expression
        }
        
        let range = expression.rangeOfFirstMatchInString(self, options: [], range: NSMakeRange(0, self.utf16.count))
        if range.location != NSNotFound {
            return (self as NSString).substringWithRange(range)
        }
        return nil
    }
}
public class Lexer {
    let input: String
    init(input: String) {
        self.input = input
    }
    public func tokenize() -> [Token] {
        var tokens = [Token]()
        var content = input
        
        while (content.characters.count > 0) {
            var matched = false
            
            for (pattern, generator) in tokenList {
                if let m = content.match(regex:pattern) {
                    if let t = generator(m) {
                        tokens.append(t)
                    }
                    let index = content.index(content.startIndex, offsetBy: m.characters.count+1)
                    content = content.substring(from: index)
                    matched = true
                    break
                }
            }

            if !matched {
                let index = content.index(content.startIndex, offsetBy: 1)
                tokens.append(.Other(content.substring(to: index)))
                content = content.substring(from: index)
            }
        }
        return tokens
    }
}
