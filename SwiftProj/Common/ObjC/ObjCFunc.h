//
//  ObjCFunc.h
//  SwiftProj
//
//  Created by SMG on 2022/06/07.
//  Copyright © 2022 garajilpung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    Hash_MD2,
    Hash_MD4,
    Hash_MD5,
    Hash_SHA1,
    Hash_SHA256,
    Hash_SHA512
} HashAlg;

// 처음에 ObjectC 파일 추가
// 프로젝트에 따라 안내팝업 뜰 수도 있고 안 뜰수 도 있다.
// 팝업이 표시되면 "Create Brdiing Header" 선택
// 그리고 App-Name-Bridging-Header.h 에서 Object-c 파일 헤더 추가
// #import "objc.h"
// 그리고 사용한다.



@interface ObjCFunc : NSObject

@property(strong, nonatomic) NSString *aStr;


+ (void)log_ObjC:(NSString*)str;

+ (BOOL) makeTiffImages:(NSMutableArray<UIImage*>*)images withURL:(NSURL*)url;

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)x andY:(int)y count:(int)count;


+ (void) makeGrayTiffUIImage:(UIImage *)uiImage toTiff:(NSString *)file withThreshold:(float)threshold;

+ (void) makeTiffRGBAUIImage:(NSArray<UIImage*> *)uiImages toTiff:(NSString *)file;

+ (NSData *)AES128DecryptWithKey:(NSString *)key encData:(NSData *)encData;

+ (NSString *)makeAESKey:(NSString *)str;


+ (NSData *)getHash:(NSData *)data hashAlg:(HashAlg)hashAlg;
+ (NSData *)getHash:(NSData *)data hashAlg:(HashAlg)hashAlg length:(UInt32)length;

/**
 Hash를 hexString으로 반환합니다.

 @since 1.0.0
 @param data 대상 데이터
 @param hashAlg (Hash) 알고리즘
 @return Hash Data (hexString Type)
 */
+ (NSString *)getHashAsHexString:(NSData *)data hashAlg:(HashAlg)hashAlg;
+ (NSString *)getHashAsHexString:(NSData *)data hashAlg:(HashAlg)hashAlg length:(UInt32)length;
/**
 Hash를 base64String으로 반환합니다.
 
 @since 1.0.0
 @param data 대상 데이터
 @param hashAlg (Hash) 알고리즘
 @return Hash Data (base64String Type)
 */
+ (NSString *)getHashAsBase64String:(NSData *)data hashAlg:(HashAlg)hashAlg;
+ (NSString *)getHashAsBase64String:(NSData *)data hashAlg:(HashAlg)hashAlg length:(UInt32)length;
@end




NS_ASSUME_NONNULL_END
