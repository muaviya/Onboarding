//
//  ViewController.swift
//  OnboardingSlide
//
//  Created by Khasbulatov on 31.05.2018.
//  Copyright © 2018 testOrganization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.set(false, forKey: "onboardingComplete")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.openLoginSb()
        }
    }
    
    func openLoginSb(){
        if UserDefaults.standard.bool(forKey: "onboardingComplete") {
            if let loginVc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") {
                self.present(loginVc, animated: true, completion: nil)
            }
        } else {
            if let initialVC = storyboard?.instantiateViewController(withIdentifier: "OnBoardVC") {
                self.present(initialVC, animated: false, completion: nil)
            }
        }
    }

}

