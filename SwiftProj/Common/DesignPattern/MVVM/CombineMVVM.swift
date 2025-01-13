//
//  CombineMVVM.swift
//  SwiftProj
//
//  Created by SMG on 8/22/24.
//  Copyright © 2024 garajilpung. All rights reserved.
//

import Foundation
import Combine


//@available(iOS 13.0, *)
//class UserModel : ObservableObject{
//    var userName: String
//    
//    init(userName: String = "Loading...") {
//        self.userName = userName
//    }
//}
//
//@available(iOS 13.0, *)
//class UserViewModel :ObservableObject {
//    @Published var userModel: UserModel
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        self.userModel = UserModel()
//    }
//    
//    func fetchUserName() -> Future<String, Never> {
//        return Future { promise in
//            // 비동기 작업 시뮬레이션
//            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
//                let fetchedName = "John Doe"
//                promise(.success(fetchedName))
//            }
//        }
//    }
//    
//    func updateUserName() {
//        fetchUserName()
//            .receive(on: RunLoop.main)
//            .sink { [weak self] name in
//                self?.userModel.userName = name
//            }
//            .store(in: &cancellables)
//    }
//}

@available(iOS 13.0, *)
class UserModel {
    @Published var userName: String = "Loading..."
}

@available(iOS 13.0, *)
class UserViewModel {
    private var model: UserModel
    private var cancellables = Set<AnyCancellable>()
    
    init(model: UserModel) {
        self.model = model
        
        // Model의 userName을 구독하여 변경 시 처리
        self.model.$userName
            .sink { [weak self] name in
                self?.handleUserNameUpdate(name)
            }
            .store(in: &cancellables)
    }
    
    func fetchUserName() -> Future<String, Never> {
        return Future { promise in
            // 비동기 작업 시뮬레이션
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                let fetchedName = "John Doe"
                promise(.success(fetchedName))
            }
        }
    }
    
    func updateUserName() {
        fetchUserName()
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                self?.model.userName = name
            }
            .store(in: &cancellables)
    }
    
    private func handleUserNameUpdate(_ name: String) {
        // 여기에서 View를 업데이트하거나 다른 로직을 추가할 수 있습니다.
        print("User name updated to: \(name)")
    }
}
