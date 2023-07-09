//
//  Extension.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/12/23.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import Foundation
import UIKit

// UIApplication 상속받아 구현
// main.swift 파일 추가 -> 아래 구문 추가
//UIApplicationMain(
//CommandLine.argc,
//CommandLine.unsafeArgv,
//NSStringFromClass(Application.self),
//NSStringFromClass(AppDelegate.self)
//)
// AppDelegate.swift 에서 @UIApplicationMain 삭제, UIApplicationMain이 있으면 최상위 파일이라고 인식한다.
class Application : UIApplication {
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        
        
//        print("send event")
    }
}


extension String {
    
    func stringToDictionary() -> Dictionary<String, Any>? {
        if let data = self.data(using: .utf8) {
            do {
                let json =  try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                return json
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
    
    func stringToDicString() -> Dictionary<String, String>? {
        if let data = self.data(using: .utf8) {
            do {
                let json =  try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, String>
                return json
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
    
    var hexadecimal: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        
        guard data.count > 0 else { return nil }
        
        return data
    }
    
    var base64EncodedString: String {
        var encodedData = Data.init(base64Encoded: self)
        
        if(encodedData == nil) {
            encodedData = Data.init(base64Encoded: self.appending("="))
            
            if(encodedData == nil) {
                encodedData = Data.init(base64Encoded: self.appending("=="))
            }
        }
        
        if(encodedData != nil) {
            return String.init(data: encodedData!, encoding: .utf8)!.removingPercentEncoding!
        }else {
            return ""
        }
    }
}

extension Dictionary {
    
    
    func dictionaryToString() -> String {
        do {
            let jsonData =  try JSONSerialization.data(withJSONObject: self, options: [])
            let jsonTxt = String(data: jsonData, encoding: .utf8)
            
            return jsonTxt!
        } catch {
            print(error.localizedDescription)
        }
        
        return ""
    }
    
    func dictionaryToData() -> Data? {
        do {
            let jsonData =  try JSONSerialization.data(withJSONObject: self, options: [])
            
            return jsonData
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 15, *) {
            
            // Get connected scenes
            return UIApplication.shared.connectedScenes
                // Keep only active scenes, onscreen and visible to the user
                .filter { $0.activationState == .foregroundActive }
                // Keep only the first `UIWindowScene`
                .first(where: { $0 is UIWindowScene })
                // Get its associated windows
                .flatMap({ $0 as? UIWindowScene })?.windows
                // Finally, keep only the key window
                .first(where: \.isKeyWindow)
            
            
            
            
            
        }
        else if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UIApplication {
    func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

extension Data {
    
    /// Hexadecimal string representation of `Data` object.
    
    var hexadecimal: String {
        return map { String(format: "%02x", $0) }
            .joined()
    }
    
}

extension UIView {
    
    public func loadLoading(name : String = "loading", nTag : Int=8888) {
        self.tag = nTag
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        guard let image = UIImage.gifImageWithName(name) else {
            DFT_TRACE_PRINT(output: "Loading Image load fail")
            return
        }
        
        let imageView : UIImageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: GlobalData.sharedInstance.screenWidth, height: GlobalData.sharedInstance.screenHeight)
        
        imageView.contentMode = .center
        imageView.startAnimating()
        
        self.addSubview(imageView)
        self.isHidden = true
        
        guard let keyWindow = UIWindow.key else {
            return
        }
        
        keyWindow.addSubview(self)
    }
    
    
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        
        return animation
    }
}

extension UIDevice {

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let model = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return model
    }
    
//        switch identifier {
//        case "iPod5,1":                                 return "iPod Touch 5"
//        case "iPod7,1":                                 return "iPod Touch 6"
//        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
//        case "iPhone4,1":                               return "iPhone 4s"
//        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
//        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
//        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
//        case "iPhone7,2":                               return "iPhone 6"
//        case "iPhone7,1":                               return "iPhone 6 Plus"
//        case "iPhone8,1":                               return "iPhone 6s"
//        case "iPhone8,2":                               return "iPhone 6s Plus"
//        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
//        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
//        case "iPhone8,4":                               return "iPhone SE"
//        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
//        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
//        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
//        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
//        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
//        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
//        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
//        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
//        case "iPad6,11", "iPad6,12":                    return "iPad 5"
//        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
//        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
//        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
//        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
//        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
//        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
//        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
//        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
//        case "AppleT‎V5,3":                              return "Apple TV"
//        case "AppleT‎V6,2":                              return "Apple TV 4K"
//        case "AudioAccessory1,1":                       return "HomePod"
//        case "i386", "x86_64":                          return "Simulator"
//        default:                                        return identifier
//        }
}

