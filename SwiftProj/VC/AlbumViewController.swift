//
//  AlbumViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/09.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import AVKit
import Photos

@objc(AlbumViewController)
class AlbumViewController: BasicViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lbContent.layer.borderWidth = 2.0
        lbContent.layer.borderColor = UIColor.black.cgColor
        
//        CacheManager.shared.images.object(forKey: "")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Button Event
    
    @IBAction func onBtnCarmera(_ sender: Any) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        if (status == .notDetermined) {
            
        }else if(status == .authorized) {
            
        }else if(status == .denied) {
            
        }else {
            
        }
    }
    
    @IBAction func onBtnOpenAlbum(_ sender: Any) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (_status) in
                DispatchQueue.main.async {
                    if(_status == .authorized) {
                        self.showImagePicker(pType: .photoLibrary)
                    }else {
                        self.showImagePicker(pType: .savedPhotosAlbum)
                    }
                }
            }
            
        }else if(status == .authorized) {
            self.showImagePicker(pType: .camera)
        }else {
            self.showImagePicker(pType: .savedPhotosAlbum)
        }
    }
    
    @IBAction func onBtnOpenAlbumMulti(_ sender: Any) {
        
    }
    
    // MARK: - user Interface
    func showImagePicker(pType: UIImagePickerController.SourceType) {
     
        if(!(UIImagePickerController.isSourceTypeAvailable(pType))){
            print("사용불가")
            return;
        }
        
        if(pType == .camera) {
            let imgPickerVC = UIImagePickerController.init()
            
            imgPickerVC.delegate = self
            imgPickerVC.allowsEditing = true
            imgPickerVC.sourceType = pType
            imgPickerVC.showsCameraControls = true
            imgPickerVC.cameraCaptureMode = .photo
            
            self.present(imgPickerVC, animated: true) {
                
            }
            
        }else if(pType == .savedPhotosAlbum || pType == .photoLibrary ) {
            let imgPickerVC = UIImagePickerController.init()
            
            imgPickerVC.delegate = self
            imgPickerVC.allowsEditing = true
            
            imgPickerVC.sourceType = pType
            
            self.present(imgPickerVC, animated: true) {
                
            }
            
        }else {
            
        }
    }
    
    // MARK: - UIImagePikcerViewControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("select \(info)")
        
        let img = info[.originalImage] as? UIImage
        let imgUrl = info[.imageURL] as? URL
        
        print("img Url \(imgUrl!.absoluteString)")

        
        do {
            let user = try Data.init(contentsOf: imgUrl!)
            let img = UIImage.init(data: user)
            imgView.image = img
        } catch {
            
        }
        
        self.dismiss(animated: true) {
            
        }
    }
}
