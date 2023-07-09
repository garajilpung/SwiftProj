//
//  ClipboardViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/09.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(ClipboardViewController)
class ClipboardViewController: BasicViewController {
    
    @IBOutlet weak var tv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // struct read  test
        
        var str = ""
        
        for _ in 0..<40 {
            str.append("1234")
        }
        
        print(" str \(str)")
        
        print(" str[43] \(str.index(str.startIndex, offsetBy: 34))")
        
        var bb = str.data(using: .utf8)
        
        let vv = bb?.withUnsafeMutableBytes{
            return $0.load(as: HeaderStruct.self)
        }
        
        let name = withUnsafePointer(to: vv?.m1) {
            $0.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout.size(ofValue: $0)) {
                String(cString: $0)
            }
        }
        
        print("vv \(name)")
        
//        print("vv \( String(cString: UnsafeRawPointer(vv?.m1).assumingMemoryBound(to: CChar.self)) )")
        
//        print("vv \(String(cString: UnsafePointer(&(vv?.m1))))")
                print("vv \(String(describing: vv?.m2))")
        print("vv \(String(describing: vv?.m4))")
        print("vv \(String(describing: vv?.m5))")
        
        
        var dd = Data.init(repeating: 0, count: 200)
        
        let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))

        let str1 = str.data(using: encoding) ?? Data.init()
        
        dd.replaceSubrange(0..<str1.count, with: str1)
        
        
        let hello  = "안녕하세요"
        print("length :\(hello.count)")
        
        let helloData = hello.data(using: encoding) ?? Data.init()
        print("Data length :\(helloData.count)")
        
        let vf = "vf123\0\0\0\t"
        print("\\0 [\(vf)] count :\(vf.count)")
        
        if vf == "vf" {
            print("equal")
        }else {
            print("not equal")
        }
        
        let  vfTrim = vf.trimmingCharacters(in: .whitespacesAndNewlines)
        print("vf trim [\(vfTrim)] count \(vfTrim.count)")
        
        let  vfTrim2 = vf.trimmingCharacters(in: .controlCharacters)
        print("vf trim2 [\(vfTrim2)] coun2t \(vfTrim2.count)")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Button Event
    
    @IBAction func onBtnMoveSetting(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:]) { (Bool) in
            
        }
    }
    
    @IBAction func onBtnPaste(_ sender: Any) {
        // 클립보드를 사용하면 화면이 멈추니 원인을 모르겠음
        // 시뮬레이터에서만 테스트
        if let myString = UIPasteboard.general.string {
            tv.text = myString
        }
    }
    
    @IBAction func onBtnCopy(_ sender: Any) {
        UIPasteboard.general.string = "슈퍼로봇대전 Z"
    }
}
