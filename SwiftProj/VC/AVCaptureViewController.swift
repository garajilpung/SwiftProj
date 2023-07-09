//
//  AVCaptureViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/03/05.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit
import AVKit

@objc(AVCaptureViewController)
class AVCaptureViewController: BasicViewController {
    var captureSession: AVCaptureSession?
    var captureDeviceInput: AVCaptureInput?
    var captureVideoOutput : AVCaptureMovieFileOutput?
    var captureVideoOutput2 : AVCaptureOutput?
    var captureDevice : AVCaptureDevice?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var vCapture: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .high // defualt .high
        captureVideoOutput = AVCaptureMovieFileOutput()
        captureDevice = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInDualCamera, for: .video, position: .front)
        
        captureDeviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
        captureSession?.addInput(captureDeviceInput!)
        captureSession?.addOutput(captureVideoOutput!)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.frame = vCapture.bounds
        previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        vCapture.layer.addSublayer(self.previewLayer!)
        
        captureSession?.startRunning()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
