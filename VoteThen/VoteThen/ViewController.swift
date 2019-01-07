//
//  ViewController.swift
//  VoteThen
//
//  Created by hongae  on 12/28/18.
//  Copyright © 2018 hongae . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var List: UITextView!
    @IBOutlet weak var ListItem: UITextField!
    @IBOutlet weak var beginvote: UIButton!
    @IBOutlet weak var refresh: UIButton!
    
    var Master = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        List.text = ""
        ListItem.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //refresh on homescreen
    @IBAction func refresh(_ sender: Any) {
        Master.removeAll()
        
        
        UIView.animate(withDuration: 1, animations: {
            self.refresh.transform = self.refresh.transform.rotated(by: CGFloat.pi)
            self.refresh.transform = self.refresh.transform.rotated(by: CGFloat.pi)
            self.List.alpha = 0})
            
        self.List.text = ""
        List.alpha = 1


    }
    @IBAction func Insert(_ sender: Any) {
        //checks to see input exists and isnt already there
        if ListItem.text != "" && Master[ListItem.text!] == nil{
            List.text += ">>> \(ListItem.text!) \n"
            Master[ListItem.text!] = 0
            print(Master)
            ListItem.text = ""
            UIView.animate(withDuration: 1, animations:{
            self.beginvote.isEnabled = true
            self.beginvote.alpha = 1
                
            }
            )
        }
    }
    //sends data to other controller and prepares for next sequence
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var VotingPageViewController = segue.destination as! VotingPageViewController
        VotingPageViewController.Master = Master
    }
    
}

extension ViewController : UITextFieldDelegate{
    
    //returns text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
}

