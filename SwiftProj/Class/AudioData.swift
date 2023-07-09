//
//  AudioData.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/22.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import Foundation



struct AudioData {
    let AD_00 : Array<UInt8> = Array.init(repeating: 0x00, count: 30)
    let AD_01 : Array<UInt8> = Array.init(repeating: 0x00, count: 30)
    let AD_02 : Array<UInt8> = Array.init(repeating: 0x00, count: 800)
    let AD_03 : Array<UInt8> = Array.init(repeating: 0x00, count: 30)
    let AD_04 : Array<UInt8> = Array.init(repeating: 0x00, count: 30)
}
