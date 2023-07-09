//
//  main.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/13.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import Foundation
import UIKit

let argc = CommandLine.argc
let argv = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

//Z3NyeXQ(1)

DFT_TRACE_PRINT(output: "UIApplicationMain")

UIApplicationMain(argc, CommandLine.unsafeArgv, NSStringFromClass(MyApplication.self) , NSStringFromClass(AppDelegate.self))
