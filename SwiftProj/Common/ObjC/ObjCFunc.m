//
//  ObjCFunc.m
//  SwiftProj
//
//  Created by SMG on 2022/06/07.
//  Copyright © 2022 garajilpung. All rights reserved.
//

#import "ObjCFunc.h"
#import <ImageIO/ImageIO.h>
#include <QuartzCore/QuartzCore.h>
#include <CoreServices/CoreServices.h>
#import <CommonCrypto/CommonCryptor.h>
#include "tiffio.h"

@implementation ObjCFunc

+ (void)log_ObjC:(NSString*)str {
    NSLog(@"ObjC Print");
}


+ (BOOL) makeTiffImages:(NSMutableArray<UIImage*>*)images withURL:(NSURL*)url {
    
    float compression = 1.0; // Lossless compression if available.
    int orientation = 1; // Origin is at bottom, left.
    CFStringRef myKeys[3];
    CFTypeRef   myValues[3];
    CFDictionaryRef myOptions = NULL;
    myKeys[0] = kCGImagePropertyOrientation;
    myValues[0] = CFNumberCreate(NULL, kCFNumberIntType, &orientation);
    myKeys[1] = kCGImagePropertyHasAlpha;
    myValues[1] = kCFBooleanTrue;
    myKeys[2] = kCGImageDestinationLossyCompressionQuality;
    myValues[2] = CFNumberCreate(NULL, kCFNumberFloatType, &compression);
    myOptions = CFDictionaryCreate( NULL, (const void **)myKeys, (const void **)myValues, 3,
                          &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    // Release the CFNumber and CFDictionary objects when you no longer need them.

    CGImageDestinationRef myImageDest = CGImageDestinationCreateWithURL((CFURLRef)url, kUTTypeTIFF, images.count, nil);

    for (UIImage* image in images)  {
        CGImageDestinationAddImage(myImageDest, image.CGImage, myOptions);
    }
    
    CGImageDestinationFinalize(myImageDest);
    CFRelease(myImageDest);

    
    return false;
}

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)x andY:(int)y count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];

    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                    bitsPerComponent, bytesPerRow, colorSpace,
                    kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    // Now your rawData contains the image data in the RGBA8888 pixel format.
    NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
    for (int i = 0 ; i < count ; ++i)
    {
        CGFloat alpha = ((CGFloat) rawData[byteIndex + 3] ) / 255.0f;
        CGFloat red   = ((CGFloat) rawData[byteIndex]     ) / alpha;
        CGFloat green = ((CGFloat) rawData[byteIndex + 1] ) / alpha;
        CGFloat blue  = ((CGFloat) rawData[byteIndex + 2] ) / alpha;
        byteIndex += bytesPerPixel;

        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }

  free(rawData);

  return result;
}

// 흑백으로 컨버팅 됨
+ (void) makeGrayTiffUIImage:(UIImage *)uiImage toTiff:(NSString *)file withThreshold:(float)threshold {
    CGImageRef srcCGImage = [uiImage CGImage];
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(srcCGImage));
    unsigned char *pixelDataPtr = (unsigned char *)CFDataGetBytePtr(pixelData);

    TIFF *tiff;
    if ((tiff = TIFFOpen([file UTF8String], "w")) == NULL) {
        // error msg
        NSLog(@"%@", [NSString stringWithFormat:@"Unable to write to file %@.", file]);
//        [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Unable to write to file %@.", file] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        return;
    }

    size_t width = CGImageGetWidth(srcCGImage);
    size_t height = CGImageGetHeight(srcCGImage);

    TIFFSetField(tiff, TIFFTAG_IMAGEWIDTH, width);
    TIFFSetField(tiff, TIFFTAG_IMAGELENGTH, height);
    TIFFSetField(tiff, TIFFTAG_BITSPERSAMPLE, 1);
    TIFFSetField(tiff, TIFFTAG_SAMPLESPERPIXEL, 1);
    TIFFSetField(tiff, TIFFTAG_ROWSPERSTRIP, 1);

    TIFFSetField(tiff, TIFFTAG_COMPRESSION, COMPRESSION_CCITTFAX4);
//    TIFFSetField(tiff, TIFFTAG_COMPRESSION, COMPRESSION_LZW);
    TIFFSetField(tiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_MINISWHITE);
    TIFFSetField(tiff, TIFFTAG_FILLORDER, FILLORDER_MSB2LSB);
    TIFFSetField(tiff, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG);

    TIFFSetField(tiff, TIFFTAG_XRESOLUTION, 200.0);
    TIFFSetField(tiff, TIFFTAG_YRESOLUTION, 200.0);
    TIFFSetField(tiff, TIFFTAG_RESOLUTIONUNIT, RESUNIT_INCH);

    unsigned char *ptr = pixelDataPtr; // initialize pointer to the first byte of the image buffer
    unsigned char red, green, blue, gray, eightPixels;
    tmsize_t bytesPerStrip = ceil(width/8.0);
    unsigned char *strip = (unsigned char *)_TIFFmalloc(bytesPerStrip);

    for (int y=0; y<height; y++) {
        for (int x=0; x<width; x++) {
            red = *ptr++; green = *ptr++; blue = *ptr++;
            ptr++; // discard fourth byte by advancing the pointer 1 more byte
            gray = .3 * red + .59 * green + .11 * blue; // http://answers.yahoo.com/question/index?qid=20100608031814AAeBHPU
            eightPixels = strip[x/8];
            eightPixels = eightPixels << 1;
            if (gray < threshold) eightPixels = eightPixels | 1; // black=1 in tiff image without TIFFTAG_PHOTOMETRIC header
            strip[x/8] = eightPixels;
        }
        TIFFWriteEncodedStrip(tiff, y, strip, bytesPerStrip);
    }

    TIFFClose(tiff);
    if (strip) _TIFFfree(strip);
    if (pixelData) CFRelease(pixelData);
}


// RGB로 됨 이미지 어레이를 받아 처리한다.
+ (void) makeTiffRGBAUIImage:(NSArray<UIImage*> *)uiImages toTiff:(NSString *)file{
    TIFF *tiff;
    if ((tiff = TIFFOpen([file UTF8String], "w")) == NULL) {
        // error msg
        NSLog(@"%@", [NSString stringWithFormat:@"Unable to write to file %@.", file]);
//        [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Unable to write to file %@.", file] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        return;
    }
    
    int page = 0;
    for (UIImage* image in uiImages) {
        
        CGImageRef srcCGImage = [image CGImage];
        CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(srcCGImage));
        
        unsigned char *pixelDataPtr = (unsigned char *)CFDataGetBytePtr(pixelData);

        size_t width = CGImageGetWidth(srcCGImage);
        size_t height = CGImageGetHeight(srcCGImage);
        
        size_t bitsPerPixel = CGImageGetBitsPerPixel(srcCGImage);
        size_t bytesPerPixel = bitsPerPixel / 8;
//        size_t bytesPerRow = CGImageGetBytesPerRow(srcCGImage);
        
//        NSLog(@"sizse [%zu] [%zu] [%zu]", bitsPerPixel, bytesPerPixel, bytesPerRow);
        
        TIFFSetField(tiff, TIFFTAG_IMAGEWIDTH, width);
        TIFFSetField(tiff, TIFFTAG_IMAGELENGTH, height);
        TIFFSetField(tiff, TIFFTAG_BITSPERSAMPLE, 8,8,8,8); // 32 로 하면 왠지 모르지만 이미지 가로길이가 1/4이 된다.
        TIFFSetField(tiff, TIFFTAG_SAMPLESPERPIXEL, bytesPerPixel);

        TIFFSetField(tiff, TIFFTAG_COMPRESSION, COMPRESSION_JPEG);
        TIFFSetField(tiff, TIFFTAG_PHOTOMETRIC, PHOTOMETRIC_RGB);
        TIFFSetField(tiff, TIFFTAG_FILLORDER, FILLORDER_MSB2LSB);
        TIFFSetField(tiff, TIFFTAG_PLANARCONFIG, PLANARCONFIG_CONTIG);

        TIFFSetField(tiff, TIFFTAG_RESOLUTIONUNIT, RESUNIT_INCH);

        TIFFSetField(tiff, TIFFTAG_SUBFILETYPE, FILETYPE_PAGE);
        TIFFSetField(tiff, TIFFTAG_PAGENUMBER, page, uiImages.count);
        
        unsigned char *ptr = pixelDataPtr; // initialize pointer to the first byte of the image buffer
        unsigned char *strip = (unsigned char *)_TIFFmalloc(width*4);

        for (int y=0; y<height; y++) {
            memcpy(strip, ptr, width * bytesPerPixel); // RGBA 이다
            ptr += width * bytesPerPixel; // RGBA 이다
            TIFFWriteScanline(tiff, strip, y, 0);
        }
        
        if (strip) _TIFFfree(strip);
        if (pixelData) CFRelease(pixelData);
        
        TIFFWriteDirectory(tiff);
        
        page++;
    }
    
    TIFFClose(tiff);
}


+ (NSData *)AES128DecryptWithKey:(NSString *)key encData:(NSData *)encData {
    
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES128+1]; // room for terminator (unused) // oorspronkelijk 256
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [encData length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode +kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES128, // oorspronkelijk 256
                                          NULL /* initialization vector (optional) */,
                                          [encData bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    } else {
        free(buffer); //free the buffer;
        return nil;
    }
}


@end
