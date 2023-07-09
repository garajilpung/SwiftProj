//
//  MVVMViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/25.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit


struct MVVM_Character {
    
    //화면을 구성할 데이터
    let image:UIImage
    let name:String
    let gender:String
    let country:String
    
    //초기화
    init(name:String,image:UIImage,gender:String,country:String) {
        self.name = name
        self.image = image
        self.gender = gender
        self.country = country
    }
}

class CharacterViewModel {
    
    let characters:[MVVM_Character] = [
        MVVM_Character(name:"스폰지밥",image: #imageLiteral(resourceName: "ch_raon"), gender: "남자", country:"미국"),
        MVVM_Character(name:"뚱이",image: #imageLiteral(resourceName: "ch_ari"), gender: "남자", country:"미국"),
        MVVM_Character(name:"징징이",image: #imageLiteral(resourceName: "loading_11"), gender: "남자", country:"미국"),
        MVVM_Character(name:"플랭크톤",image: #imageLiteral(resourceName: "loading_19"), gender: "남자", country:"미국"),
        MVVM_Character(name:"퐁퐁여사",image: #imageLiteral(resourceName: "ch_ara_2"), gender: "여자", country:"미국")
    ]
    
    //MARK:- Properties
    
    let image:Observable<UIImage?> = Observable(nil)
    let name:Observable<String?> = Observable(nil)
    let gender:Observable<String?> = Observable(nil)
    let country:Observable<String?> = Observable(nil)
    
    var index:Int = 0
    
    let sFlag : Observable<String?> = Observable(nil)
    
    init() {
        self.image.value = characters[0].image
        self.name.value = characters[0].name
        self.gender.value = characters[0].gender
        self.country.value = characters[0].country
    }
    
    func tapButton(isPrevious:Bool) {
        if isPrevious {
            index = index > 0 ? index-1 : 0
        }else {
            index = index < characters.count - 1 ? index + 1 : characters.count - 1
        }
        self.image.value = characters[index].image
        self.name.value = characters[index].name
        self.gender.value = characters[index].gender
        self.country.value = characters[index].country
    }
    
    func setFlag(flag : String) {
        sFlag.value = flag
    }
}

class MVVMViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // 기존 MVVM 부분
    // 뷰를 보고 싶으면 상단뷰를 히든 시킨다.
    @IBOutlet weak var tbList: UITableView!
    
    private var articleListVM: ArticleListViewModel!
    
    
    // 신 MVVM 부분
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var tfFlag: UITextField!
    @IBOutlet weak var lbFlag: UILabel!
    
    private var viewModel : CharacterViewModel = CharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tbList.dataSource = self
        tbList.delegate = self
        
        tbList.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        setup()
        
        bind()
        
        tfFlag.delegate = self
        tfFlag.addTarget(self, action: #selector(textfiledDidChange), for: UIControl.Event.editingChanged)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setup() {
        let url = URL(string: "https://garajilpung.synology.me/test/article.json")!
        WebService().getArticles(url: url) { //1
            (articles) in

            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles) //2
            }
            DispatchQueue.main.async {
                self.tbList.reloadData()
            }
        }
    }
    
    private func bind() {
        viewModel.image.bind { image in
            self.image.image = image
        }
        
        viewModel.name.bind { name in
            self.name.text = name
        }
        
        viewModel.country.bind { country in
            self.country.text = country
        }
        
        viewModel.gender.bind { gender in
            self.gender.text = gender
        }
        
        viewModel.sFlag.bind { flag in
            self.lbFlag.text = flag
        }
        
    }
    
    // MARK: - UIButton Event
    @IBAction func onBtnClose(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    

    // MARK: - UiTableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}

        let articleVM = self.articleListVM.articleAtIndex(indexPath.row) //3
        cell.descriptionLabel?.text = articleVM.description
        cell.titleLabel?.text = articleVM.title
        return cell
    }
    
    //MARK:- IBActions
        
    @IBAction func tapPreviousButton(_ sender: Any) {
        viewModel.tapButton(isPrevious: true)
    }
    
    @IBAction func tapNextButton(_ sender: Any) {
        viewModel.tapButton(isPrevious: false)
    }
    
    // MARK: - UITextField Delegate
    @objc func textfiledDidChange(textField: UITextField) {
        print("Text changed")
        
        guard let str = textField.text else {
            return
        }
        
        viewModel.setFlag(flag: str)
    }
}
