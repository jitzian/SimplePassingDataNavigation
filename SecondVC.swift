//
//  SecondVC.swift
//  SimplePassingDataNavigation
//
//  Created by raian on 8/5/17.
//  Copyright © 2017 Jonathan Sandoval Cruz. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mButtonUIAlert: UIButton!
    
    var data : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data: \(data!)")
        // Do any additional setup after loading the view.
        mLabel.text = data != nil ? data : "Someting to display"
        
//        mButtonUIAlert.isExclusiveTouch = true
        mButtonUIAlert.isMultipleTouchEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    static var count : Int = 0
    @IBAction func displayImageFromURL(_ sender: Any) {
        SecondVC.count += 1
        
        if (SecondVC.count % 2) == 0 {
            print(SecondVC.count)
        }
        
//        print("Begin of code: ")
//        print(SecondVC.count)
        
        if let checkedUrl = URL(string: "http://www.apple.com/euro/ios/ios8/a/generic/images/og.png") {
            mImageView.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl)
        }
        print("End of code. The image will continue downloading in the background and it will be loaded when it ends.")
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.mImageView.image = UIImage(data: data)
            }
        }
    }
    
    var buttonIsActive = false
    
    @IBAction func displayUIAlert(_ sender: Any) {
        
        if buttonIsActive == false {
            buttonIsActive = true
        
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                self.buttonIsActive = false
            }
            
            //Creating UIAlertController and
            //Setting title and message for the alert dialog
            let alertController = UIAlertController(title: "Enter details?", message: "Enter your name and email", preferredStyle: .alert)
            
            //the confirm action taking the inputs
            let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                
                //getting the input values from user
                let name = alertController.textFields?[0].text
                let email = alertController.textFields?[1].text
                
                self.mLabel.text = "Name: " + name! + "Email: " + email!
                
            }
            
            //the cancel action doing nothing
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            //adding textfields to our dialog box
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter Name"
            }
            alertController.addTextField { (textField) in
                textField.placeholder = "Enter Email"
            }
            
            //adding the action to dialogbox
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            //finally presenting the dialog box
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }

}
