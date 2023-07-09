//
//  QRCodeViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/17.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import AVKit

@objc(QRCodeViewController)
class QRCodeViewController: BasicViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var photoOutput : AVCapturePhotoOutput!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let carmeraAuth = AVCaptureDevice.authorizationStatus(for: .video)
        
        if(carmeraAuth == .authorized) {
            setData()
            
        }else if(carmeraAuth == .denied){
            
            let alertVC = UIAlertController.init(title: "알림", message: "설정에서 카메라를 허용해 주세요", preferredStyle: UIAlertController.Style.alert)
            let btnOK = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default) { (UIAlertAction) in
                alertVC.dismiss(animated: true) {
                    
                }
            }
            
            let MoveOK = UIAlertAction.init(title: "앋ㅎㅇ", style: UIAlertAction.Style.default) { (UIAlertAction) in
                alertVC.dismiss(animated: true) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:]) { (Bool) in
                        
                    }
                }
            }
            
            alertVC.addAction(btnOK)
            alertVC.addAction(MoveOK)
            
            self.present(alertVC, animated: true, completion: {
                
            })
            
        }else { // notDetermined, restricted
            
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if(granted) {
                    self.setInit()
                }else {
                    let alertVC = UIAlertController.init(title: "알림", message: "설정에서 카메라를 허용해 주세요", preferredStyle: UIAlertController.Style.alert)
                    let btnOK = UIAlertAction.init(title: "확인", style: UIAlertAction.Style.default) { (UIAlertAction) in
                        alertVC.dismiss(animated: true) {
                            
                        }
                    }
                    
                    alertVC.addAction(btnOK)
                    
                    self.present(alertVC, animated: true, completion: {
                        
                    })
                }
            }
        }
        
        
//        imgView.image = generateQRCode(from: "vvewersdf zdf ")
        self.view.bringSubviewToFront(imgView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        /*
         
        CIAztecCodeGenerator
        CICheckerboardGenerator
        CICode128BarcodeGenerator
        CIConstantColorGenerator
        CILenticularHaloGenerator
        CIPDF417BarcodeGenerator
        CIQRCodeGenerator
        CIRandomGenerator
        CIStarShineGenerator
        CIStripesGenerator
        CISunbeamsGenerator
        */
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - User Method
    
    func setData() {
        self.view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = view.layer.bounds
        previewLayer.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func found(code: String) {
        print(code)
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            
            
            print("ccc \(readableObject.type)")
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            
//            photoOutput = AVCapturePhotoOutput()
//            let photoSettings = AVCapturePhotoSettings()
//            captureSession.addOutput(photoOutput)
//            photoOutput.capturePhoto(with: photoSettings, delegate: self)
            
//            captureSession.startRunning()
        }

//        dismiss(animated: true)
    }
}
