//
//  ImageCacheManager.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/31.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import Foundation
import UIKit

class CacheManager {
    
    public static let shared = CacheManager()
    
    public let images : NSCache<NSString, UIImage>
    
    private init() {
        images = NSCache<NSString, UIImage>()
        // 각종 초기화
        // imageShared
    }
    
}
