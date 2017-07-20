//
//  LoadingViewController.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import UIKit

private let _sharedInstance = LoadingViewController()

class LoadingViewController: UIViewController {
    
    var parentVc: UIViewController? = nil
    
    required init() {
        super.init(nibName: "LoadingViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    class var sharedInstance: LoadingViewController {
        return _sharedInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: public implementation
    
    func showWithParentViewController(parentViewController: UIViewController) {
        DispatchQueue.main.async {
            self.parentVc = parentViewController
            self.parentVc?.addChildViewController(self)
            self.parentVc?.view.addSubview(self.view)
            self.view.frame = CGRect(x: 0.0, y: 0.0, width: (self.parentVc?.view.bounds.width)!, height: (self.parentVc?.view.bounds.height)!)            
            self.view.backgroundColor = UIColor.black
            
            UIView.animate(withDuration: 0.25) {
                self.view.alpha = 0.4
            }
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.253, animations: {
                self.view.alpha = 0.0
            }) { (finished) in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        }
    }
}
