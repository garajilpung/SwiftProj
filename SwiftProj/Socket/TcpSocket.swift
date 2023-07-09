//
//  TcpSocket.swift
//  SwiftProj
//
//  Created by suhyup02 on 2021/07/19.
//  Copyright © 2021 garajilpung. All rights reserved.
//

import UIKit

protocol CustomStreamDeleage {
    func onReceive(state:Int, bSuccess:Bool)
}

class TcpSocket: NSObject, StreamDelegate {
    var host:String?
    var port:Int?
    var inputStream: InputStream?
    var outputStream: OutputStream?
    
    var delegate : CustomStreamDeleage?
    
    func connect(host: String, port: Int) {
            
        self.host = host
        self.port = port
        
        Stream.getStreamsToHost(withName:host, port : port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
            
            // Set delegate
            inputStream!.delegate = self
            outputStream!.delegate = self
            
            // Schedule
            inputStream!.schedule(in: .main, forMode: RunLoop.Mode.default)
            outputStream!.schedule(in: .main, forMode: RunLoop.Mode.default)
            
            print("Start open()")
            
            // Open!
            inputStream!.open()
            outputStream!.open()
        }
    }
    
    @discardableResult func send(data: Data) -> Int {
//        return data.withUnsafeBytes({ (rawBufferPointer: UnsafeRawBufferPointer) -> Int in
        
        return data.withUnsafeBytes({ (rawBufferPointer: UnsafeRawBufferPointer) -> Int in
            let bufferPointer = rawBufferPointer.bindMemory(to: UInt8.self)
            return outputStream!.write(bufferPointer.baseAddress!, maxLength: data.count)
        })
    }
    
    func recv(buffersize: Int) -> Data {
        var buffer = [UInt8](repeating :0, count : buffersize)
        
        let bytesRead = inputStream?.read(&buffer, maxLength: buffersize)
        var dropCount = buffersize - bytesRead!
        if dropCount < 0 {
            dropCount = 0
        }
        let chunk = buffer.dropLast(dropCount)
        return Data(chunk)
    }
    
    func disconnect() {
        inputStream?.close()
        outputStream?.close()
    }
    
    func stream(_ stream: Stream, handle eventCode: Stream.Event) {
            
        print("event:\(eventCode)")
        
        if stream === inputStream {
            switch eventCode {
            case Stream.Event.errorOccurred:
                delegate?.onReceive(state: 1, bSuccess: false)
                print("inputStream:ErrorOccurred")
            case Stream.Event.openCompleted:
                delegate?.onReceive(state: 1, bSuccess: true)
                print("inputStream:OpenCompleted")
            case Stream.Event.hasBytesAvailable:
                print("inputStream:HasBytesAvailable")
                
                
            default:
                break
            }
        }
        else if stream === outputStream {
            switch eventCode {
            case Stream.Event.errorOccurred:
                delegate?.onReceive(state: 2, bSuccess: false)
                print("outputStream:ErrorOccurred")
            case Stream.Event.openCompleted:
                delegate?.onReceive(state: 2, bSuccess: true)
                print("outputStream:OpenCompleted")
            case Stream.Event.hasSpaceAvailable:
                print("outputStream:HasSpaceAvailable")
            default:
                break
            }
        }
    }
}
