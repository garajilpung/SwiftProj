//
//  CompilerViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/02/15.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import AFNetworking


@objc(CompilerViewController)
class CompilerViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        checkOS()
        checkArch()
        checkCompiler()
        checkSwift()
        checkCanImport()
        checkEnvironment()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func checkOS(){
        
#if os(macOS)
        print("macOS")
#elseif os(iOS)
        print("iOS")
#elseif os(watchOS)
        print("watchOS")
#elseif os(tvOS)
        print("tvOS")
#elseif os(Linux)
        print("Linux")
#elseif os(Windows)
        print("Windows")
#endif
        
    }
    
    func checkArch(){
        
#if arch(i386)
        print("macOS")
#elseif arch(x86_64)
        print("x86_64")
#elseif arch(arm)
        print("arm")
#elseif arch(arm64)
        print("arm64")
#endif
        
    }
    
    func checkCompiler(){
        //">=" or "<" 만 쓸수 있다.
#if compiler(>=5)
        print("compiler(Swift) 버전 5 이상")
#else
        print("compiler(Swift) 버전 5 미만")
#endif
    }
    
    func checkSwift(){
        //">=" or "<" 만 쓸수 있다.
#if swift(>=5)
        print("Swift 버전 5 이상")
#else
        print("Swift 버전 5 미만")
#endif
    }
    
    func checkEnvironment(){
#if targetEnvironment(simulator)
        print("simulator")
#elseif targetEnvironment(macCatalyst)
        print("macCatalyst")
#endif
    }
    
    func checkCanImport(){
#if canImport(AFNetworking)
        print("AFNetworking")
#endif
        
#if canImport(VVNetwork)
        print("VVNetwork")
#else
        print("not VVNetwork")
        
        
#endif
        
#sourceLocation(file:"myfile.swift", line:10)
    print("myfile.swift")
#sourceLocation()
    }
}
