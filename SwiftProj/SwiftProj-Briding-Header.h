//
//  SwiftProj-Briding-Header.h
//  SwiftProj
//
//  Created by suhyup02 on 2021/12/07.
//  Copyright © 2021 garajilpung. All rights reserved.
//

#ifndef SwiftProj_Briding_Header_h
#define SwiftProj_Briding_Header_h

#import "ObjCFunc.h"

typedef struct {
    unsigned char m1[64];
    unsigned char m2[32];
    unsigned char m3[8];
    unsigned char m4[16];
    unsigned char m5[16];
} __attribute__((__packed__)) HeaderStruct;


#endif /* SwiftProj_Briding_Header_h */
