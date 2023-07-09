//
//  ObjCFunc.h
//  SwiftProj
//
//  Created by SMG on 2022/06/07.
//  Copyright © 2022 garajilpung. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 처음에 ObjectC 파일 추가
// 프로젝트에 따라 안내팝업 뜰 수도 있고 안 뜰수 도 있다.
// 팝업이 표시되면 "Create Brdiing Header" 선택
// 그리고 App-Name-Bridging-Header.h 에서 Object-c 파일 헤더 추가
// #import "objc.h"
// 그리고 사용한다.
@interface ObjCFunc : NSObject

@property(strong, nonatomic) NSString *aStr;


+ (void)log_ObjC:(NSString*)str;

@end

NS_ASSUME_NONNULL_END
