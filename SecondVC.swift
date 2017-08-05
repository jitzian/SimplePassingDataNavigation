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
    
    var data : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("data: \(data!)")
        // Do any additional setup after loading the view.
        mLabel.text = data != nil ? data : "Someting to display"
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

    @IBAction func displayImageFromURL(_ sender: Any) {
        print("Begin of code")
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
}
