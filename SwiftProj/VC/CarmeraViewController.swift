//
//  CarmeraViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/18.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import AVKit
import Photos

@objc(CarmeraViewController)
class CarmeraViewController: BasicViewController, AVCapturePhotoCaptureDelegate {

    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    @objc var captureDevice: AVCaptureDevice?
    
    @IBOutlet weak var exposure: UILabel!
    @IBOutlet weak var iso: UILabel!
    @IBOutlet weak var lensPosition: UILabel!
    @IBOutlet var preView: UIView!

    @IBOutlet var capture: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = .photo
        self.capturePhotoOutput = AVCapturePhotoOutput()
        self.captureDevice = AVCaptureDevice.default(for: .video)
//        self.captureDevice = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front)
        
        
        let input = try! AVCaptureDeviceInput(device: self.captureDevice!)
        self.captureSession?.addInput(input)
        self.captureSession?.addOutput(self.capturePhotoOutput!)

        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
        self.previewLayer?.frame = self.preView.bounds
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.preView.layer.addSublayer(self.previewLayer!)

        self.captureSession?.startRunning()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UIButton Event
    @IBAction func capture(_ sender: Any) {
        let photoSettings : AVCapturePhotoSettings!
        photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.flashMode = .off
        photoSettings.isHighResolutionPhotoEnabled = false
        self.capturePhotoOutput?.capturePhoto(with: photoSettings, delegate: self)
    }
    
    
    // MARK: - AVCapturePhotoCaptureDelegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        let cgImage = photo.cgImageRepresentation()!.takeRetainedValue()
//        let orientation = photo.metadata[kCGImagePropertyOrientation as String] as! NSNumber
//        let uiOrientation = UIImage.Orientation(rawValue: orientation.intValue)!
//        let image = UIImage(cgImage: cgImage, scale: 1, orientation: uiOrientation)
//        self.imgView.image = image
    
        let imageData = photo.fileDataRepresentation()
        if let data = imageData, let img = UIImage(data: data) {
            imgView.image = img
        }
        
        
        
        PHPhotoLibrary.shared().performChanges( {
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: PHAssetResourceType.photo, data: photo.fileDataRepresentation()!, options: nil)
        }, completionHandler: nil )
    }

    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
            didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings,
            error: Error?) {

        guard error == nil else {
            print("Error in capture process: \(String(describing: error))")
            return
        }
    }
    
    // MARK: - Notification
    func addObservers() {
        self.addObserver(self, forKeyPath: "captureDevice.lensPosition" , options: .new, context: nil)
        self.addObserver(self, forKeyPath: "captureDevice.exposureDuration", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "captureDevice.ISO", options: .new, context: nil)
    }

    func removeObservers() {
        self.removeObserver(self, forKeyPath: "captureDevice.lensPosition")
        self.removeObserver(self, forKeyPath: "captureDevice.exposureDuration")
        self.removeObserver(self, forKeyPath: "captureDevice.ISO")
    }

    override func observeValue(forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey: Any]?,
        context: UnsafeMutableRawPointer?) {

        if keyPath == "captureDevice.lensPosition" {
            self.lensPosition.text = String(format: "%.1f", (self.captureDevice?.lensPosition)!)
        }

        if keyPath == "captureDevice.exposureDuration" {
            let exposureDurationSeconds = CMTimeGetSeconds( (self.captureDevice?.exposureDuration)! )
            self.exposure.text = String(format: "1/%.f", 1.0 / exposureDurationSeconds)
        }

        if keyPath == "captureDevice.ISO" {
            self.iso.text = String(format: "%.f", (self.captureDevice?.iso)!)
        }
    }
}
