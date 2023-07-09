//
//  Presenter.swift
//  SwiftProj
//
//  Created by suhyup02 on 2022/01/25.
//  Copyright © 2022 garajilpung. All rights reserved.
//

import Foundation


class ArticlePresenter {
    private let webService: WebService
    private var articles : [Article] = []
    
    private weak var mvpView: MVPView?
    
    init (webService : WebService) {
        self.webService = webService
    }
    
    func attachView(view: MVPView) {
        mvpView = view
    }
    
    func detachView() {
        mvpView = nil
    }
    
    func numberOfSections() -> Int {
        var ret = 0
        
        if articles.count > 0 {
            ret = 1
        }else {
            ret = 0
        }
        
        return ret
    }
    
    func numberOfRowsInSection() -> Int {
        return articles.count
    }
    
    func getArticleIndex(pIndex: Int) -> Article? {
        if articles.count-1 <= pIndex {
            return nil
        }else {
            return articles[pIndex]
        }
    }
    
    func reloadData() {
        mvpView?.startLoading()
        let url = URL(string: "https://garajilpung.synology.me/test/article.json")!
        webService.getArticles(url: url) { [weak self] articleList in
            DispatchQueue.main.async {
                self?.mvpView?.stopLoading()
            }
            
            if let articles = articleList {
                self?.articles = articles
                DispatchQueue.main.async {
                    self?.mvpView?.reloadData()
                }
            }
        }
    }
}
