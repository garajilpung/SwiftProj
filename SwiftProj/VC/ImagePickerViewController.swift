//
//  ImagePickerViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/12/20.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

@objc(ImagePickerViewController)
class ImagePickerViewController: BasicViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let vc1 = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func onBtn(_ sender: Any) {
        vc1.sourceType = .photoLibrary
        vc1.delegate = self

        self.present(vc1, animated: true) {
            
        }
    }
    
    @IBAction func onBtn2(_ sender: Any) {
        
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        UIImagePickerControllerReferenceURL
        print("uiimagepickerviewcontroller \(info)")
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        vc1.dismiss(animated: true) {
            
        }
    }
    
}
