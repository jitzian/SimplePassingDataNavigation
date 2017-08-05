//
//  ViewController.swift
//  SimplePassingDataNavigation
//
//  Created by raian on 8/5/17.
//  Copyright © 2017 Jonathan Sandoval Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mLabel: UITextField!
    @IBOutlet weak var mButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendData(_ sender: Any) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        secondVC.data = mLabel.text != nil ? mLabel.text : "Default value"
        navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    
    
}

