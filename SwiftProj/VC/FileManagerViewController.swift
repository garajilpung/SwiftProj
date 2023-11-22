//
//  FileManagerViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/11/24.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit
import Zip

@objc(FileManagerViewController)
class FileManagerViewController: BasicViewController {

    @IBOutlet weak var lbText: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        saveFile()
        
//        loadResource()
//
//        saveFile()
//        loadFile()
//
//        createDir()
//
//        saveUserDefaults()
//        loadUserDefaults()
        
        
        
//        appendFile(data: "v1v2v3".data(using: .utf8)!)
//
//        loadFile()
//
        createFile(pFileName: "v3.txt")
    }


    /*
    // MARK: - Navigation
    //TODO:    '지금 당장은 못하지만 나중에 해야 할 작업'
    //FIXME:    '고쳐야 할 사항'

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - User Method
    func loadResource() -> Void {
        let path = Bundle.main.path(forResource:"app_download", ofType:"txt")
        
        if(path == nil){
            print("data [","파일 없음", "]")
            return
        }
        
        let data = NSData.init(contentsOfFile: path!)
        
        if(data == nil) {
            print("data [","데이터 없음", "]")
        }else {
            
        }
    }
    
    func saveFile() -> Void {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let fileName = String.init(format: "%@/t1.txt", paths[0])
        let content : String = "One\nTwo\nThree\nFour\nFive"
        
        do{
            print("성공")
           try content.write(toFile: fileName, atomically: false, encoding: String.Encoding.utf8)
        }catch{
            print("실패")
        }
        
    }
    
    func createDir() -> Void {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let documentsDirectory : String = paths[0]
        
        let filePathAndDirectory = documentsDirectory.appending("/gh")
        
        let fileExists = FileManager.default.fileExists(atPath: filePathAndDirectory)
        if(fileExists){
            print("있다.")
        }else {
            print("없다.")
            
            do {
                try FileManager.default.createDirectory(atPath: filePathAndDirectory, withIntermediateDirectories: false, attributes: nil)
                print("폴더 생성")
            }catch {
                print("폴더 생성 안됨.")
            }
        }
    }
    
    func loadFile() -> Void {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let fileName = String.init(format: "%@/t1.txt", paths[0])
        
        do {
            let ss = try String.init(contentsOfFile: fileName, encoding: .utf8)
            lbText.text = ss
            
            print("파일 읽기 tjdrhd. \(ss)")
        }catch {
            print("파일 읽기 실패.")
        }
    }
    
    func saveUserDefaults() -> Void {
        let user = UserDefaults.standard
        
        user.set("1234-1234", forKey: "Tel")
        user.synchronize()
    }
    
    
    func loadUserDefaults() -> Void {
        let user = UserDefaults.standard
        let rec : String = user.object(forKey: "Tel") as! String
        
        print("rec [",rec,"]")
    }
    
    func appendFile(data :Data) {
        
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        print("fileName \(documentURL.absoluteString)")
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let fileName = String.init(format: "%@/t1.txt", paths[0])
        
        print("fileName \(fileName)")
        if let fileHandle = FileHandle(forWritingAtPath: fileName) {
             defer {
                 fileHandle.closeFile()
             }
             fileHandle.seekToEndOfFile()
             fileHandle.write(data)
        }else {
            print("data Wriet 실패")
        }
    }
    
    func createFile(pFileName : String) {
        let data : Data = Data.init()
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)
        let fileName = String.init(format: "%@/\(pFileName)", paths[0])
        
        do {
            try data.write(to: URL(fileURLWithPath: fileName))
            
            print("file create 성공")
        }catch {
            print("file create 실패")
        }
        
        print("\(URL(fileURLWithPath: fileName).absoluteString)")
        
        if let _ = NSData(contentsOfFile:fileName) {
            print("data file not null")
        } else {
            print("data file null")
        }
        
    }
    
    // zip 관련 내용을 추가한다.
    
    func zip() {
        do {
            let filePath = Bundle.main.url(forResource: "file", withExtension: "zip")!
            let unzipDirectory = try Zip.quickUnzipFile(filePath) // Unzip
            let zipFilePath = try Zip.quickZipFiles([filePath], fileName: "archive") // Zip
        }
        catch {
          print("Something went wrong")
        }
    }
    
    func zipAdvance() {
        do {
            let filePath = Bundle.main.url(forResource: "file", withExtension: "zip")!
            let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
            try Zip.unzipFile(filePath, destination: documentsDirectory, overwrite: true, password: "password", progress: { (progress) -> () in
                print(progress)
            }) // Unzip

            let zipFilePath = documentsDirectory.appendingPathComponent("archive.zip")
            try Zip.zipFiles(paths: [filePath], zipFilePath: zipFilePath, password: "password", progress: { (progress) -> () in
                print(progress)
            }) //Zip

        }
        catch {
          print("Something went wrong")
        }
    }
    
}
