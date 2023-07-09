//
//  InfinityScrollViewController.swift
//  SwiftProj
//
//  Created by suhyup02 on 2020/12/08.
//  Copyright © 2020 garajilpung. All rights reserved.
//

import UIKit

@objc(InfinityScrollViewController)
class InfinityScrollViewController: BasicViewController{
   

    let list = [ #colorLiteral(red: 0.5843137255, green: 0.8823529412, blue: 0.8274509804, alpha: 1) ,#colorLiteral(red: 0.9529411765, green: 0.5058823529, blue: 0.5058823529, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.8901960784, blue: 0.5411764706, alpha: 1), #colorLiteral(red: 0.5843137255, green: 0.8823529412, blue: 0.8274509804, alpha: 1), #colorLiteral(red: 0.9529411765, green: 0.5058823529, blue: 0.5058823529, alpha: 1)]
        
    let list2 = [ UIColor.yellow, UIColor.red, UIColor.black, UIColor.blue, UIColor.magenta]
    
    var nScrIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var scrView: UIScrollView!
    
    @IBOutlet weak var vClr01: UIView!
    @IBOutlet weak var vClr02: UIView!
    @IBOutlet weak var vClr03: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        flowlayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowlayout
        
        collectionView.register(UINib.init(nibName: "InfinityScrollCell", bundle: nil), forCellWithReuseIdentifier: "infinityScrollCell")
        
        
        vClr01.backgroundColor = list2[list2.count-1]
        vClr02.backgroundColor = list2[nScrIndex]
        vClr03.backgroundColor = list2[nScrIndex+1]
        
//        scrView.scrollRectToVisible(<#T##CGRect#>, animated: false)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("viewDidLayoutSubviews")
        self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear")
        
        scrView.scrollRectToVisible(CGRect(x: scrView.frame.size.width, y: 0, width: scrView.frame.size.width, height: scrView.frame.size.height), animated: false)
    }
    
    
    
}

extension InfinityScrollViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infinityScrollCell", for: indexPath)
        cell.contentView.backgroundColor = list[indexPath.row]
        return cell
    }
}


extension InfinityScrollViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if(scrollView == collectionView as UIScrollView) {
            let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
            let pageInt = Int(round(pageFloat))
            
            switch pageInt {
            case 0:
                collectionView.scrollToItem(at: [0, 3], at: .left, animated: false)
            case list.count - 1:
                collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
            default:
                break
            }
        }else if(scrollView == scrView) {
            let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
            let pageInt = Int(round(pageFloat))
            
            print("pageInt : \(pageInt)")
            
            var nPreIndex = 0
            var nPostIndex = 0
            
            switch pageInt {
            case 0: // 이전화면으로 이동
                nScrIndex -= 1
                if(nScrIndex < 0) {
                    nScrIndex = list2.count - 1
                }
                
                if(nScrIndex-1 < 0) {
                    nPreIndex = list2.count - 1
                }else {
                    nPreIndex = nScrIndex - 1
                }
                
                if(nScrIndex+1 >= list2.count) {
                    nPostIndex = 0
                }else {
                    nPostIndex = nScrIndex + 1
                }
                
                vClr01.backgroundColor = list2[nPreIndex]
                vClr02.backgroundColor = list2[nScrIndex]
                vClr03.backgroundColor = list2[nPostIndex]
                
            case 2: // 다음 화면으로 이동
                
                nScrIndex += 1
                if(nScrIndex >= list2.count) {
                    nScrIndex = 0
                }
                
                if(nScrIndex-1 < 0) {
                    nPreIndex = list2.count - 1
                }else {
                    nPreIndex = nScrIndex - 1
                }
                
                if(nScrIndex+1 >= list2.count) {
                    nPostIndex = 0
                }else {
                    nPostIndex = nScrIndex + 1
                }
                
                vClr01.backgroundColor = list2[nPreIndex]
                vClr02.backgroundColor = list2[nScrIndex]
                vClr03.backgroundColor = list2[nPostIndex]
            default:
                break
            }

            
            

            scrollView.scrollRectToVisible(CGRect(x: scrView.frame.size.width, y: 0, width: scrView.frame.size.width, height: scrView.frame.size.height), animated: false)
        }
    }
}
