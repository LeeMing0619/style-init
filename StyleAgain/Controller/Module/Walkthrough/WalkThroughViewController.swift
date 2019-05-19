//
//  WalkThroughViewController.swift
//  StyleAgain
//
//  Created by Macmini on 12/3/18.
//  Copyright © 2018 Style Again. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

let topAndDress = """
        [{"title": "L"}, {"title": "M"}, {"title": "X"}, {"title": "XS"}, {"title": "XL"}, {"title": "2XL"}, {"title": "3XL"}, {"title": "4XL"}]
    """.data(using: .utf8)

let waistAndBottom = 1..<25
let shoesAndHeel = 1..<10
let favoritebloggers = """
        [{"url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn2Akbm3N0_O_r-QBiILoRjB9LJPI7gnvEOUbST2Y9CBAIKjT3"},
        {"url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHY615x6HlgeOY9wo4r2OzPA_la-1BsyiQ0c3SGLTPrXkCAeLizg"},
        {"url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFk0PGc1S2vc0PuGDBzQmw8Y5mj4ARPgGqkLmiX6B3vF32pSf_Ag"},
        {"url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRpaiMTkAu0i_4n4x2-G2DU69pqU7Ns1USpOLi0rxAA0G3Q8hckg"},
        {"url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkTq57mzQK0q1OaWWLrAMf503vwHJkT_x9N3kYlH62iCSdxdVNCw"},
        {"url": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-yz_JBX6wIDklSF_QCmufNmLc-iW9Sknni5d2uhBD_Q1yD6rT"}]
    """.data(using: .utf8)

class WalkThroughViewController: BaseViewController {
    @IBOutlet weak var horzPagerView: FSPagerView! {
        didSet {
            self.horzPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    var pageIndex: Int = 0 {
        didSet {
            pageControl.currentPage = pageIndex
        }
    }
    var itemList: WalkthroughOptionList?
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        if let pagerView = horzPagerView {
            pagerView.dataSource = self
            pagerView.clipsToBounds = false
            pagerView.delegate = self
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let pagerView = horzPagerView {
            //            pagerView.itemSize = pagerView.frame.size.applying(transform)
            //            let transform = CGAffineTransform(scaleX: 0.3, y: 0.8)
            
            pagerView.itemSize = CGSize(width: 130, height: 130)
            pagerView.interitemSpacing = 0
            pagerView.decelerationDistance = FSPagerView.automaticDistance
            pagerView.transformer = FSPagerViewTransformer(type: .linear)
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            DLog(message: "Swipe to Right")
            if self.canPerformSegue(withIdentifier: "sid_prev") {
                self.performSegue(withIdentifier: "sid_prev", sender: self)
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            DLog(message: "Swipe to Left")
            if self.canPerformSegue(withIdentifier: "sid_next") {
                self.performSegue(withIdentifier: "sid_next", sender: self)
            }
        }
    }
    
    @IBAction func onPrevItem(_ sender: Any) {
        
    }
    
    @IBAction func onNextItem(_ sender: Any) {
        
    }
}

extension WalkThroughViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    func imageFromString(text: String, frame: CGRect, fontSize: CGFloat = 80) -> UIImage? {
        var rect = frame
        rect.size.width = rect.size.height
        let label = UILabel(frame: rect)
        label.text = text
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.adjustsFontSizeToFitWidth = true
        
        var imgReturn: UIImage?  = nil
        
        UIGraphicsBeginImageContext(rect.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            label.layer.render(in: currentContext)
            imgReturn = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return imgReturn
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let list = self.itemList {
            return list.items?.count ?? 0
        }
        return 0
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.contentView.layer.shadowColor = UIColor.clear.cgColor
        cell.contentView.layer.shadowRadius = 0
        cell.contentView.layer.shadowOpacity = 0
        cell.contentView.layer.shadowOffset = .zero
        
        if let items = self.itemList?.items {
            if let title = items[index].title {
                cell.imageView?.layer.shadowRadius = 0
                cell.imageView?.clipsToBounds = false
                cell.imageView?.image = self.imageFromString(text: title, frame: cell.bounds)
            }
            else if let url = items[index].url{
                cell.layer.cornerRadius = cell.bounds.size.height/2
                cell.layer.masksToBounds = true
                cell.imageView?.kf.setImage(with: url)
            }
        }
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
}

// Page View Controllers

class StartWalkThroughViewController: WalkThroughViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        pageIndex = 0
    }
}

class TopAndDressViewController: WalkThroughViewController {
    override func viewDidLoad() {
        itemList = try? JSONDecoder().decode(WalkthroughOptionList.self, from: topAndDress!)
        
        super.viewDidLoad()
        pageIndex = 1
    }
}

class WaistAndBottomViewController: WalkThroughViewController {
    override func viewDidLoad() {
        self.itemList = WalkthroughOptionList()
        for i in waistAndBottom {
            var item = WalkthroughOptionItem()
            item.title = "\(i)"
            self.itemList?.items?.append(item)
        }
        
        super.viewDidLoad()
        pageIndex = 2
    }
}

class ShoesAndHeelViewController: WalkThroughViewController {
    override func viewDidLoad() {
        self.itemList = WalkthroughOptionList()
        for i in shoesAndHeel {
            var item = WalkthroughOptionItem()
            item.title = "\(i)"
            self.itemList?.items?.append(item)
        }
        
        super.viewDidLoad()
        pageIndex = 3
    }
}

class FavoriteBloggerViewController: WalkThroughViewController {
    override func viewDidLoad() {
        itemList = try? JSONDecoder().decode(WalkthroughOptionList.self, from: favoritebloggers!)

        super.viewDidLoad()
        pageIndex = 4
    }
    
    @IBAction func onFinish(_ sender: Any) {
        
    }
}


