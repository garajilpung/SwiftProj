//
//  HttpConnectionViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/03.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(HttpConnectionViewController)
class HttpConnectionViewController: BasicViewController {

    var ll : String?
    var regTime : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let formatter : DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddhhmmss"
        
        regTime = formatter.string(from: Date.init())
        
        
        let dic : NSDictionary = ["os":"i",
                                  "id":"ksos73",
                                  "regTime":regTime!]
        
        sendPost(pUrl: "https://garajilpung.synology.me/php/post.php", dic: dic)
        sendGet(pUrl: "https://garajilpung.synology.me/php/get.php", dic: dic)
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
    func sendPost(pUrl:String, dic:NSDictionary) -> Void {
        var parameter : String! = ""
    
        let defaultSession : URLSession = URLSession.init(configuration: URLSessionConfiguration.default)
        
        let url: URL! = URL(string: pUrl)
        var urlRequest : URLRequest = URLRequest.init(url: url)
        
        for key in dic.allKeys {
            print("paramete : ", parameter!)
            print("key : ", key, ",", dic[key] as! String)
            parameter = String.init(format: "%@&%@=%@", parameter, key as! String, dic[key] as! String)
            
        }
        
        let postData : Data? = parameter.data(using: .utf8)
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = postData
                
        let dTask = defaultSession.dataTask(with: urlRequest) { (data, res, err) in
            // getting Data Error
            guard err == nil else {
                print("Error occur: \(String(describing: err))")
                return
            }

            guard let data = data, let response = res as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            let str : String? = String(data: data, encoding: String.Encoding.utf8)
            print("str ", str!)
            
        }
        
        dTask.resume()
        
    }
 
    func sendGet(pUrl: String, dic:NSDictionary) ->Void {
        var parameter : String! = ""
        
        for key in dic.allKeys {
            if(parameter == "") {
                parameter = String.init(format:"%@=%@", key as! String , dic[key] as! String)
            }else {
                parameter = String.init(format:"%@&%@=%@", parameter, key as! String, dic[key] as! String)
            }
        }
        
        let getURL = String.init(format:"%@?%@", pUrl, parameter)
        
        let request : URLRequest = URLRequest(url: URL.init(string: getURL)!)
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default)
        let dTask = session.dataTask(with: request) { (data, resp, err) in
            if(data != nil) {
                let str : String? = String(data: data!, encoding: String.Encoding.utf8)
                print("str ", str!)
            }else {
                print("Error occur: \(String(describing: err))")
            }
        
        }
        
        dTask.resume()
    }
    
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = URL(string: "http://api-host-name/v1/api/uploadfile/single")

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
    
//    public func UPLOADIMG(url: String,parameters: Dictionary<String,AnyObject>?,filename:String,image:UIImage, success:((NSDictionary) -> Void)!, failed:((NSDictionary) -> Void)!, errord:((NSError) -> Void)!) {
//            var TWITTERFON_FORM_BOUNDARY:String = "AaB03x"
//            let url = NSURL(string: url)!
//            var request:NSMutableURLRequest = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10)
//            var MPboundary:String = "--\(TWITTERFON_FORM_BOUNDARY)"
//            var endMPboundary:String = "\(MPboundary)--"
//            //convert UIImage to NSData
//            var data:NSData = UIImagePNGRepresentation(image)
//            var body:NSMutableString = NSMutableString();
//            // with other params
//            if parameters != nil {
//                for (key, value) in parameters! {
//                    body.appendFormat("\(MPboundary)\r\n")
//                    body.appendFormat("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                    body.appendFormat("\(value)\r\n")
//                }
//            }
//            // set upload image, name is the key of image
//            body.appendFormat("%@\r\n",MPboundary)
//            body.appendFormat("Content-Disposition: form-data; name=\"\(filename)\"; filename=\"pen111.png\"\r\n")
//            body.appendFormat("Content-Type: image/png\r\n\r\n")
//            var end:String = "\r\n\(endMPboundary)"
//            var myRequestData:NSMutableData = NSMutableData();
//            myRequestData.appendData(body.dataUsingEncoding(NSUTF8StringEncoding)!)
//            myRequestData.appendData(data)
//            myRequestData.appendData(end.dataUsingEncoding(NSUTF8StringEncoding)!)
//            var content:String = "multipart/form-data; boundary=\(TWITTERFON_FORM_BOUNDARY)"
//            request.setValue(content, forHTTPHeaderField: "Content-Type")
//            request.setValue("\(myRequestData.length)", forHTTPHeaderField: "Content-Length")
//            request.HTTPBody = myRequestData
//            request.HTTPMethod = "POST"
//            //        var conn:NSURLConnection = NSURLConnection(request: request, delegate: self)!
//            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
//                data, response, error in
//                if error != nil {
//                    println(error)
//                    errord(error)
//                    return
//                }
//                var parseError: NSError?
//                let responseObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &parseError)
//                if let responseDictionary = responseObject as? NSDictionary {
//                    success(responseDictionary)
//                } else {
//                }
//
//            })
//            task.resume()
//
//    }
}
