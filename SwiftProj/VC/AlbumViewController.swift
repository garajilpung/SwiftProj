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
import PhotosUI
import AssetsPickerViewController

@objc(AlbumViewController)
class AlbumViewController: BasicViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    
    
    
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
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (_status) in
                DispatchQueue.main.async {
                    if(_status == .authorized) {
                        // 카메라는 UIImagePickerViewController 에서만 가능하다.
                        self.showImagePicker(pType: .camera)
                    }
                }
            }
            
        }else if(status == .authorized) {
            self.showImagePicker(pType: .camera) // 카메라 바로 찍은 것을 선택하는게 가능하다.
        }else {
            
        }
    }
    
    @IBAction func onBtnOpenAlbum(_ sender: Any) {
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (_status) in
                DispatchQueue.main.async {
                    if(_status == .authorized) {
                        if #available(iOS 14.0, *)  {
                            self.showPHPicker(pType: .images, multi: false)
                        }else {
                            self.showImagePicker(pType: .photoLibrary)
//                        self.showImagePicker(pType: .savedPhotosAlbum)
                        }
                    }else {
                        
                    }
                }
            }
            
        }else if(status == .authorized) {
            if #available(iOS 14.0, *)  {
                self.showPHPicker(pType: .images, multi: false)
            }else {
                self.showImagePicker(pType: .photoLibrary)
//                        self.showImagePicker(pType: .savedPhotosAlbum)
            }
        }else {
            
        }
    }
    
    @IBAction func onBtnOpenAlbumMulti(_ sender: Any) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == .notDetermined) {
            PHPhotoLibrary.requestAuthorization { (_status) in
                DispatchQueue.main.async {
                    if(_status == .authorized) {
                        if #available(iOS 14.0, *)  {
                            self.showPHPicker(pType: .images, multi: true)
                        }else {
                            let picker = AssetsPickerViewController()
                            picker.pickerDelegate = self
                            self.present(picker, animated: true, completion: nil)
//                        self.showImagePicker(pType: .savedPhotosAlbum)
                        }
                    }else {
                        
                    }
                }
            }
            
        }else if(status == .authorized) {
            if #available(iOS 14.0, *)  {
                self.showPHPicker(pType: .images, multi: true)
            }else {
                let picker = AssetsPickerViewController()
                picker.pickerDelegate = self
                present(picker, animated: true, completion: nil)
            }
        }else {
            
        }
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
    
    //MARK: - UIImagePikcerViewControllerDelegate
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
    
    @available(iOS 14, *)
    func showPHPicker(pType: PHPickerFilter, multi : Bool) {
        var configuration = PHPickerConfiguration() // 1.
        configuration.selectionLimit = multi ? 0 : 1 // 2.
        configuration.filter = pType
        
        let vc = PHPickerViewController.init(configuration: configuration)
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
    
    //MARK: - PHPickerViewController Delegate
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        if(results.count == 0) {
            // 선택한 것이 존재하지 않는다.
        }else {
            for result in results {
                DFT_TRACE_PRINT(output: "assetIdentifier \(result.assetIdentifier ?? "")")
                DFT_TRACE_PRINT(output: "itemProvider \(result.itemProvider.suggestedName ?? "")")
                
                result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                    DispatchQueue.main.async {
                        guard let image = object as? UIImage else{
                            return
                        }
                        
                        self.imgView.image = image
                    }
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
}

// to handle
extension AlbumViewController : AssetsPickerViewControllerDelegate {
    
    func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {
        DFT_TRACE_PRINT(output: "assetsPicker assetsPickerCannotAccessPhotoLibrary")
    }
    
    func assetsPickerDidCancel(controller: AssetsPickerViewController) {
        DFT_TRACE_PRINT(output: "assetsPicker assetsPickerDidCancel")
    }
    
    func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
        // do your job with selected assets
        DFT_TRACE_PRINT(output: "assetsPicker selected \(assets.count)")
        
        for asset in assets {
            let requestImageOption = PHImageRequestOptions()
            requestImageOption.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            
            let imageManager = PHImageManager.default()
            
            imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: requestImageOption) { (image:UIImage?, _) in

                guard let img = image else {
                    return
                }
                
                self.imgView.image = img
            }
        }
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        DFT_TRACE_PRINT(output: "assetsPicker shouldSelect")
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {
        DFT_TRACE_PRINT(output: "assetsPicker didSelect")
    }
    
    func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
        DFT_TRACE_PRINT(output: "assetsPicker shouldDeselect")
        return true
    }
    
    func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {
        DFT_TRACE_PRINT(output: "assetsPicker didDeselect")
    }
}
