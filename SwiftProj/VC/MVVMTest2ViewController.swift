//
//  MVVMTest2ViewController.swift
//  SwiftProj
//
//  Created by SMG on 8/22/24.
//  Copyright © 2024 garajilpung. All rights reserved.
//

import UIKit
import Combine

@available(iOS 13.0, *)
@objc(MVVMTest2ViewController)
class MVVMTest2ViewController: BasicViewController {

    private var viewModel: UserViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private let nameLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 24)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
                    nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
        
        // Model 및 ViewModel 초기화
        let userModel = UserModel()
        viewModel = UserViewModel(model: userModel)
        
        // Model의 userName을 UILabel의 text에 바인딩
        userModel.$userName
            .receive(on: RunLoop.main)
            .sink { [weak self] updatedName in
                self?.nameLabel.text = updatedName
            }
            .store(in: &cancellables)
        
        // 데이터 로드 시작
        viewModel.updateUserName()
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
