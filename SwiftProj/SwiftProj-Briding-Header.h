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


// tiff-iOS lib 관련
#import "tiff_ios.h"
#import "TIFFFieldTagTypes.h"
#import "TIFFFieldTypes.h"
#import "TIFFFileDirectory.h"
#import "TIFFFileDirectoryEntry.h"
#import "TIFFImage.h"
#import "TIFFImageWindow.h"
#import "TIFFRasters.h"
#import "TIFFReader.h"
#import "TIFFWriter.h"
#import "TIFFCompressionDecoder.h"
#import "TIFFCompressionEncoder.h"
#import "TIFFDeflateCompression.h"
#import "TIFFLZWCompression.h"
#import "TIFFPackbitsCompression.h"
#import "TIFFRawCompression.h"
#import "TIFFUnsupportedCompression.h"
#import "TIFFByteReader.h"
#import "TIFFByteWriter.h"
#import "TIFFIOUtils.h"
#import "TIFFConstants.h"
#import "TIFFPredictor.h"

#endif /* SwiftProj_Briding_Header_h */
