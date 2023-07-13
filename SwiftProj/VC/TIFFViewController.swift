//
//  TIFFViewController.swift
//  SwiftProj
//
//  Created by SMG on 2022/06/24.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit
import ImageIO
import CoreImage


/*
 2022.07.13 에 내가 내린 결론
 일단 기본적으로 iOS tiff 이미지를 만드는 것을 지원한다. (단 압축을 지원하지 않아서 파일 용량이 기하 급수적으로 커진다.)
 UIImage to tiff 이미지로 만드는 것은 가능하다.
 
 외부 라이브러리도 일반적인 tiff 이미지를 만든 것만 지원한다.
 
 여기서의 내 생각은 아직 하지는 않았지만
 tiff 이미지를 직접을 만들면 가능하지 않을까 생각한다.
 헤더를 만들고 각 이미지를 JPEG 압출을 통하면은 가능할 것이라고 생각은 드는데 (일단 iOS 는 jpeg 압축을 지원한다. 그리고 손실 압축이다)
 여기에서는 문제는 tiff 이미지에 대한 헤더를 모두 내가 직접 구현 해야한다는 점이다.
 
 
 */



@objc(TIFFViewController)
class TIFFViewController: BasicViewController {
    
    @IBOutlet weak var vImg1: UIImageView!
    @IBOutlet weak var vImg2: UIImageView!
    @IBOutlet weak var vImg3: UIImageView!
    @IBOutlet weak var vImg4: UIImageView!
    @IBOutlet weak var vImg5: UIImageView!
    @IBOutlet weak var vImg6: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var images = Array<UIImage>()

        for i in 1 ..< 10 {
            let name = String(format: "loading_%02d", i)

            guard let image = UIImage(named: name), let cgImage = image.cgImage,
                  let data = cgImage.dataProvider?.data, let dataPtr = CFDataGetBytePtr(data) else {
                continue
            }

//            DFT_TRACE_PRINT(output: " \(cgImage.bitsPerPixel)") // 32bit
//            DFT_TRACE_PRINT(output: " \(cgImage.width)")
//            DFT_TRACE_PRINT(output: " \(cgImage.height)")
//            DFT_TRACE_PRINT(output: " \(cgImage.bitsPerComponent)") // 8bit 각 색당(rgba)
//            DFT_TRACE_PRINT(output: " \(String(describing: cgImage.colorSpace))") // 기본적으로 rgb
//            DFT_TRACE_PRINT(output: " \(dataPtr[0])")
//            DFT_TRACE_PRINT(output: " \(dataPtr[1])")
//            DFT_TRACE_PRINT(output: " \(dataPtr[2])")
//            DFT_TRACE_PRINT(output: " \(dataPtr[3])")

            images.append(image)
        }
        
        
        // 기본적으로는 UIImage to tiff 로 변경이 가능하다.
        // 단 문제는 압축을 시키지 못한다.

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let fileName1 = String.init(format: "%@/t11.tiff", paths[0])
        let fileName2 = String.init(format: "%@/t12.tiff", paths[0])
        let fileName3 = String.init(format: "%@/t13.tiff", paths[0])
        let fileName4 = String.init(format: "%@/t14.tiff", paths[0])
        let fileName5 = String.init(format: "%@/t15.tiff", paths[0])
        let fileName6 = String.init(format: "%@/t16.tiff", paths[0])

        // 기본 제공하는 라이브러리만 가지고 tiff를 만다.
        // macOS에서는 압축까지 제공하지만 iOS에서는 제공하지 않는다. 그래서 iOS에서는 외부라이브러리를 사용해야 한다.
        UIImage.makeTiffWithURL(images, URL(fileURLWithPath: fileName1))
        let img1 = UIImage.tiffImageWithURL(URL(fileURLWithPath: fileName1).absoluteString)
        self.vImg1.image = img1

        // 외부라이브러리를 사용하여 tiff 이미지를 만드는 부분
        // 흑과 백으로만 표시되는 tiff
        // libtiff를 사용하여 tiff를 만든다. 단 라이브러리 만드는 법이 복잡하여 따로 git 만들어 저장한다.
        ObjCFunc.makeGrayTiffUIImage(images[0], toTiff: fileName3, withThreshold: 1)
        let img3 = UIImage.tiffImageWithURL(URL(fileURLWithPath: fileName3).absoluteString)
        self.vImg3.image = img3
        
        // RGBA로 표시되는 tiff
        // libtiff를 사용하여 tiff를 만든다. 단 라이브러리 만드는 법이 복잡하여 따로 git 만들어 저장한다.
        ObjCFunc.makeTiffRGBAUIImage(images, toTiff: fileName4)
        let img4 = UIImage.tiffImageWithURL(URL(fileURLWithPath: fileName4).absoluteString)
        self.vImg4.image = img4
        
        
        // 외부라이브러리로 통한 tiff tag값을 가져온다.
        // 문제는 태그값이나 데이터가 다 다르기 때문에 tiff 스펙 문서를 보지 않으면 보기 힘들다.
        // 그냥 이런게 있다고 해서 넘어 가기로 한다.
        let tiffImage: TIFFImage = TIFFReader.readTiff(fromFile:fileName4)
        
        let directories: [TIFFFileDirectory] = tiffImage.fileDirectories()
        let directory: TIFFFileDirectory = directories[0]
        
        DFT_TRACE_PRINT(output: " tagCount \(directory.numEntries())")
        
        DFT_TRACE_PRINT(output: " samplesPerPixel \(directory.samplesPerPixel())")
        DFT_TRACE_PRINT(output: " bitPerSample \(directory.bitsPerSample())")
        DFT_TRACE_PRINT(output: " perStrip \(directory.rowsPerStrip())")
        
        var i = 0
        for element in directory.entries() {
            guard let entry = element as? TIFFFileDirectoryEntry else {
                break
            }
            DFT_TRACE_PRINT(output: "fieldTag \(entry.fieldTag())")
            DFT_TRACE_PRINT(output: "fieldType \(entry.fieldType())")
            DFT_TRACE_PRINT(output: "typeCount \(entry.typeCount())")
            
            if(entry.fieldTag() == TIFF_TAG_PHOTOMETRIC_INTERPRETATION) {
                let value : NSNumber = (entry.values() as? NSNumber)!
                DFT_TRACE_PRINT(output: "TIFF_TAG_PHOTOMETRIC_INTERPRETATION value \(value)")
            }
            DFT_TRACE_PRINT(output: "values \(entry.values())")
            i = i + 1
        }
        
//        DFT_TRACE_PRINT(output: "count : \(i)")
        
//        let rasters: TIFFRasters = directory.readRasters()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    CIImage* inputImage = [self createInputImage];
//
//    NSError* superError = nil;
//    CIContext* ciContext = [self createCiContext];
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//
//    NSURL* superURL = [NSURL fileURLWithPath: [documentsDirectory stringByAppendingPathComponent:fileName] ];
//    CGColorSpaceRef superColorSpace = CGColorSpaceCreateDeviceRGB();
//    [ciContext writeTIFFRepresentationOfImage:inputImage
//                                        toURL:superURL
//                                       format:format
//                                   colorSpace:superColorSpace
//                                      options:@{} // CIImageRepresentationOption
//                                        error:&superError];

    // tiff-iOS 라이브러리 사용
    // 이것도 사용이 가능하나 압축이 역시나 되지 않는다.
    // 만들만 라이브러리 인 것 같다.
    private func makeTiffLib(_ arr : Array<UIImage>) {
        let tiffImage: TIFFImage = TIFFImage()
        
        for image in arr {
            let width: UInt16 = UInt16(image.cgImage!.width)
            let height: UInt16 = UInt16(image.cgImage!.height)
            let samplesPerPixel: UInt16 = 1
            let bitsPerSample: UInt16 = UInt16(image.cgImage?.bitsPerPixel ?? 32)

            let rasters: TIFFRasters = TIFFRasters(width: Int32(width), andHeight: Int32(height), andSamplesPerPixel: Int32(samplesPerPixel), andSingleBitsPerSample: Int32(bitsPerSample))

            let rowsPerStrip: UInt16 = UInt16(rasters.calculateRowsPerStrip(withPlanarConfiguration: Int32(TIFF_PLANAR_CONFIGURATION_CHUNKY)))

            let directory: TIFFFileDirectory = TIFFFileDirectory()
            directory.setImageWidth(width)
            directory.setImageHeight(height)
            directory.setBitsPerSampleAsSingleValue(bitsPerSample)
            
//            directory.setCompression(UInt16(TIFF_COMPRESSION_LZW))
            directory.setCompression(UInt16(TIFF_COMPRESSION_NO))
            
            directory.setPhotometricInterpretation(UInt16(TIFF_PHOTOMETRIC_INTERPRETATION_BLACK_IS_ZERO))
            directory.setSamplesPerPixel(samplesPerPixel)
            directory.setRowsPerStrip(rowsPerStrip)
            directory.setPlanarConfiguration(UInt16(TIFF_PLANAR_CONFIGURATION_CHUNKY))
            directory.setSampleFormatAsSingleValue(UInt16(TIFF_SAMPLE_FORMAT_FLOAT))
            directory.writeRasters = rasters
            
            guard let cgImage = image.cgImage, let data = cgImage.dataProvider?.data, let bytes = CFDataGetBytePtr(data) else {
                fatalError("Couldn't access image data")
            }
            assert(cgImage.colorSpace?.model == .rgb)
            
            let bytesPerPixel = cgImage.bitsPerPixel / cgImage.bitsPerComponent
            
            for y in 0..<height {
                for x in 0..<width {
                    let offset = (Int(y) * cgImage.bytesPerRow) + (Int(x) * bytesPerPixel)
                    let pixelValue = UInt32(bytes[offset]) | UInt32(bytes[offset + 1]) << 8 | UInt32(bytes[offset + 2]) << 16 | UInt32(bytes[offset + 3]) << 24
                    DFT_TRACE_PRINT(output: "pixcelValue \(pixelValue)")
//                    let pixelValue: Float = 1.0 // any pixel value
                    rasters.setFirstPixelSampleAtX(Int32(x), andY: Int32(y), withValue: NSDecimalNumber(value: pixelValue))
                }
            }
            
            tiffImage.addFileDirectory(directory)
        }
        
        DFT_TRACE_PRINT(output: "sucess")
        
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fileName = String.init(format: "%@/t30.tiff", paths[0])
        TIFFWriter.writeTiff(withFile: fileName, andImage: tiffImage)
    }
    
}
