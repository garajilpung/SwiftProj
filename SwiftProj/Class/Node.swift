//
//  Node.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/03/22.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

public class Node<T> {
    var value : T
    var next : Node?
    weak var previous : Node?
    
    public init(_ value:T) {
        self.value = value
    }
    
    public init(head:Node<T>? = nil, _ value:T, tail:Node<T>? = nil) {
        self.value = value
    }
}

public class ForwardLinkedList<T:Equatable> {
    
    private var head : Node<T>?
    
    public var isEmpty: Bool {
        get {
            if head == nil {
                return true
            }else {
                return false
            }
        }
    }
    
    public func append(data:T) {
        if isEmpty {
            head = Node.init(data)
            return
        }
        
        var node = head
        while node?.next != nil {
            node = node?.next
        }
        
        node?.next = Node.init(data)
    }
    
    public func insert(data: T, at index:Int) {
        
        if isEmpty {
            head = Node.init(data)
        }
        
        var node = head
        for _ in 0..<(index-1) {
            if node?.next == nil { break }
            node = node?.next
        }
        
        let nextNode = node?.next
        node?.next = Node.init(data)
        node?.next?.next = nextNode
    }
    
    public func removeLast() {
        if isEmpty {
            return
        }
        
        if head?.next == nil {
            head = nil
            return
        }
        
        var node = head
        while node?.next?.next != nil {
            node = node?.next
        }
        
        node?.next = node?.next?.next
    }
    
    func remove(at index: Int) {
        
        if isEmpty {
            return
            
        }
        
        // head를 삭제하는 경우
        if index == 0 || head?.next == nil {
            head = head?.next
            return
        }
        
        var node = head
        for _ in 0..<(index - 1) {
            if node?.next?.next == nil { break }
            node = node?.next
        }
        
        node?.next = node?.next?.next
    }
    
    func searchNode(from data: T) -> Node<T>? {
        
        if isEmpty {
            return nil
        }
        
        var node = head
        while node?.next != nil {
            if node?.value == data { break }
            node = node?.next
        }
        
        return node
    }
}

public class DobuleLinkedList<T:Equatable> {
    
    private var head : Node<T>?
    private var tail : Node<T>?
    
    public var isEmpty : Bool {
        get {
            if head == nil {
                return true
            }else {
                return false
            }
        }
    }
    
    public func append(data: T) {
        if isEmpty {
            head = Node.init(data)
            tail = head
            return
        }
        
        let newNode = Node.init(data)
        tail?.next = newNode
        newNode.previous = tail
        tail = newNode
    }
    
    public func removeFirst() -> T? {
        if isEmpty {
            return nil
        }
        
        var first : T?
        
        if head?.next == nil {
            first = head?.value
            head = nil
            tail = nil
            return first
        }
        
        first = head?.value
        head?.next?.previous = nil
        head = head?.next
        
        return first
    }
    
    public func removeLast() -> T?{
     
        if isEmpty {
            return nil
        }
        
        var last : T?
        
        if head?.next == nil {
            last = head?.value
            head = nil
            tail = nil
            return last
        }
        
        last = tail?.value
        tail?.previous?.next = tail?.next
        tail = tail?.previous
        
        return last
    }
    
    func searchNode(from data: T) -> Node<T>? {
        
        if isEmpty {
            return nil
        }
        
        var node = head
        while node?.next != nil {
            if node?.value == data { break }
            node = node?.next
        }
        
        return node
    }

    func searchNodeFromTail(from data: T) -> Node<T>? {
        
        if isEmpty { return nil }
        
        var node = tail
        while node?.previous != nil {
            if node?.value == data { break }
            node = node?.previous
        }
        
        return node
    }

}


public class Stack<T> {
    private var stack: [T] = []
        
    public var count: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    
    public func push(_ element: T) {
        stack.append(element)
    }
    
    public func pop() -> T? {
        return isEmpty ? nil : stack.popLast()
    }
}

public class Queue<T> {
    private var queue: [T?] = []
    private var head: Int = 0
    
    public var count: Int {
        return queue.count
    }
    
    public var isEmpty: Bool {
        return queue.isEmpty
    }
    
    public func enqueue(_ element: T) {
        queue.append(element)
    }
    
    func dequeue() -> T? {
        guard head <= queue.count, let element = queue[head] else { return nil }
        queue[head] = nil
        head += 1
        
        if head > 50 {
            queue.removeFirst(head)
            head = 0
        }
        return element
    }
}

public class LinkedQueue<T:Equatable> {
    private var queue : DobuleLinkedList<T>?
    
    public init() {
        
    }
    
    public var isEmpty:Bool {
        get {
            if queue == nil {
                return true
            }else {
                return false
            }
        }
    }
    
    public func enqueue(_ element:T) {
        queue?.append(data: element)
    }
    
    public func dequeue() -> T? {
        return queue?.removeFirst()
    }
}
