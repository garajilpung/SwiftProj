//
//  MVPViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/25.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import UIKit

protocol MVPView: AnyObject {
    func startLoading()
    func stopLoading()
    func reloadData()
}

class MVPViewController: BasicViewController, UITableViewDelegate {

    @IBOutlet weak var tbList: UITableView!
    
    
    private let articlePresenter = ArticlePresenter(webService: WebService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tbList.dataSource = self
        tbList.delegate = self
        
        tbList.register(UINib.init(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        articlePresenter.attachView(view: self)
        articlePresenter.reloadData()
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
    @IBAction func onBtnClose(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
   
}

// MARK: - UiTableView Delegate
extension MVPViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlePresenter.numberOfRowsInSection()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return articlePresenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}

        guard let article = articlePresenter.getArticleIndex(pIndex: indexPath.row) else { //3
            return UITableViewCell.init()
        }
        
        cell.descriptionLabel?.text = article.description
        cell.titleLabel?.text = article.title
        
        return cell
    }
}

extension MVPViewController: MVPView {
    func startLoading() {
        print("startLoading")
    }
    
    func stopLoading() {
        print("stopLoading")
    }
    
    func reloadData() {
        
        tbList.reloadData()
    }
    
}

