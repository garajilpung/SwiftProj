//
//  MVCViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/25.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

// MVC의 경우 kvo, noti 처리 데이터가 변경되는 것을 체크한다.
extension Notification.Name {
    static let mvcTableReload = Notification.Name("mvcTableReload")
}


class MVCViewController: BasicViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbList: UITableView!

    private var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tbList.dataSource = self
        tbList.delegate = self
        
        tbList.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        setup()
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
        NotificationCenter.default.addObserver(self, selector: #selector(articleTableReload(_ :)), name: Notification.Name("mvcTableReload"), object: nil)
        
        let url = URL(string: "https://garajilpung.synology.me/test/article.json")!
        WebService().getArticles(url: url) { //1
            (articles) in

            if let articles = articles {
                self.articles = articles
                NotificationCenter.default.post(name: NSNotification.Name("mvcTableReload"), object: nil)
            }
        }
    }

    
    
    // MARK: - UIButton Event
    @IBAction func onBtnClose(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
        
    // MARK: - UiTableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.articles.count != 0 ? 1 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}

        let article = self.articles[indexPath.row]
        
        cell.descriptionLabel?.text = article.description
        cell.titleLabel?.text = article.title
        
        return cell
    }
    
    
    // MARK: webservice after tableReload Notification
    @objc func articleTableReload(_ notification: Notification) {
//        let getValue = notification.object as! String
//        let getUserInfo = notification.userInfo as! String
        
        // post 통해 데이터 전달시 각기에 해당하는 object와 userInfo 값이 있으면 위와 같이 가져올 수 있다.
        DispatchQueue.main.async {
            self.tbList.reloadData()
        }
    }
}
