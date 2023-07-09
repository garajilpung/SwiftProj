//
//  avCC.swift
//  SwiftProj
//
//  Created by SMG on 2021/03/07.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import Foundation
import ImageIO
import UIKit
import AVKit


final class RecorderView: UIView{
  //Your next steps will be implemented here :]
    
    
    fileprivate lazy var cameraSession = AVCaptureSession()
    fileprivate lazy var videoDataOutput = AVCaptureVideoDataOutput()
    fileprivate lazy var audioDataOutput = AVCaptureAudioDataOutput()
    
    fileprivate func setupCamera() {
        //The size of output video will be 720x1280
        cameraSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
          
        //Setup your camera
        //Detect which type of camera should be used via `isUsingFrontFacingCamera`
        let captureDevice: AVCaptureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
          
          //Setup your microphone
        let audioDevice = AVCaptureDevice.default(for: AVMediaType.audio)
          
          do {
              cameraSession.beginConfiguration()
                  
              // Add camera to your session
              let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
              if cameraSession.canAddInput(deviceInput) {
                  cameraSession.addInput(deviceInput)
              }
          
              // Add microphone to your session
              let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
              if cameraSession.canAddInput(audioInput) {
                  cameraSession.addInput(audioInput)
              }
              
              //Now we should define your output data
              let queue = DispatchQueue(label: "com.hilaoinc.hilao.queue.record-video.data-output")
              
              //Define your video output
              videoDataOutput.videoSettings = [
                  kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
              ]
              videoDataOutput.alwaysDiscardsLateVideoFrames = true
              if cameraSession.canAddOutput(videoDataOutput) {
                  videoDataOutput.setSampleBufferDelegate(self, queue: queue)
                  cameraSession.addOutput(videoDataOutput)
              }
              
              //Define your audio output
              if cameraSession.canAddOutput(audioDataOutput) {
                  audioDataOutput.setSampleBufferDelegate(self, queue: queue)
                  cameraSession.addOutput(audioDataOutput)
              }
              
              cameraSession.commitConfiguration()
              
              //Present the preview of video
              previewLayer = AVCaptureVideoPreviewLayer(session: cameraSession)
              previewLayer.bounds = bounds
              previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
              layer.addSublayer(previewLayer)
              
              //Don't forget start running your session
              //this doesn't mean start record!
              cameraSession.startRunning()
          }
          catch let error {
              debugPrint(error.localizedDescription)
          }
      }
}

extension RecorderView: AVCaptureVideoDataOutputSampleBufferDelegate,
                      AVCaptureAudioDataOutputSampleBufferDelegate {
  //There is only one same method for both of these delegates
  func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {
    //Overlay means processing on the images, not audio
      if captureOutput == videoDataOutput {
          //Important: Correct your video orientation from your device orientation
          switch UIDevice.current.orientation {
              case .landscapeRight:
                  connection.videoOrientation = .landscapeLeft
              case .landscapeLeft:
                  connection.videoOrientation = .landscapeRight
              case .portrait:
                  connection.videoOrientation = .portrait
              case .portraitUpsideDown:
                  connection.videoOrientation = .portraitUpsideDown
              default:
                  connection.videoOrientation = .portrait //Make `.portrait` as default (should check will `.faceUp` and `.faceDown`)
          }
          
          //Convert current frame to `CIImage`
          let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let attachments = CMCopyDictionaryOfAttachments(allocator: kCFAllocatorDefault,
                                                        target: pixelBuffer,
                                                        attachmentMode: CMAttachmentMode(kCMAttachmentMode_ShouldPropagate)) as? [String: Any]
          let ciImage = CIImage(cvImageBuffer: pixelBuffer, options: attachments)
          
          //Detects faces base on your `ciImage`
          let features = faceDetector.features(in: ciImage, options: [
                    CIDetectorSmile: true,
                    CIDetectorEyeBlink: true,
                    ]).flatMap ({ $0 as? CIFaceFeature })

          //Retreive frame of your buffer
          let desc = CMSampleBufferGetFormatDescription(sampleBuffer)!
        let bufferFrame = CMVideoFormatDescriptionGetCleanAperture(desc, originIsAtTopLeft: false)

          //Draw faces masks
          DispatchQueue.main.async { [weak self] in
              self?.drawFaceMasksFor(features: features, bufferFrame: bufferFrame)
          }
      }
  }
}
