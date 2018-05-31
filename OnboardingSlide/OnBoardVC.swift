//
//  OnBoardVC.swift
//  OnboardingSlide
//
//  Created by Khasbulatov on 31.05.2018.
//  Copyright © 2018 testOrganization. All rights reserved.
//

import UIKit

class OnBoardVC: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
        self.startButton.layer.cornerRadius = startButton.frame.width/2
        //3
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "Slide 1")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "Slide 2")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "Slide 3")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)
        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.size.width * 3, height: self.scrollView.frame.size.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        print(pageControl.currentPage)
        if pageControl.currentPage == 2 {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "onboardingComplete")
            userDefaults.synchronize()
            
            let loginVc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
            self.present(loginVc, animated: true, completion: nil)
        } else {
            scrollToPage(pageControl.currentPage + 1)
        }
    }
    
    func scrollToPage(_ page: Int) {        
        if pageControl.currentPage == 1 {
            startButton.setImage(UIImage(named: "okIcon"), for: .normal)
        }
        UIView.animate(withDuration: 0.3) {
            self.pageControl.currentPage = page
            self.scrollView.contentOffset.x = self.scrollView.frame.width * CGFloat(page)
        }
    }
}

extension OnBoardVC: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        if Int(pageNumber) == 2 {
            startButton.setImage(UIImage(named: "okIcon"), for: .normal)
        } else {
            startButton.setImage(UIImage(named: "nextIcon"), for: .normal)
        }
    }
}


