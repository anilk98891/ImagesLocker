//
//  InputScreenViewController.swift
//  Lockers
//
//  Created by Anil System on 27/07/20.
//  Copyright © 2020 Anil System. All rights reserved.
//

import UIKit

class InputScreenViewController: UIViewController {
    
    @IBOutlet weak var textFieldPasscode: UITextField!
    
    var counter = 6
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldPasscode.becomeFirstResponder()
        self.title = "Hey!! Welcome"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonActionCheck(_ sender: Any) {
        guard counter > 1 else{
            self.textFieldPasscode.resignFirstResponder()
            self.textFieldPasscode.isUserInteractionEnabled = false
            self.view.showToast(message: "You have completed your attempts.")
            return
        }
        if textFieldPasscode.text == "1334" {
            counter = 6
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "CollectionGalleryViewController") as CollectionGalleryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            counter -= 1
            self.textFieldPasscode.resignFirstResponder()
            self.view.showToast(message: "Remaining Attempt left: \(counter)",completion: {
                self.textFieldPasscode.becomeFirstResponder()
            })
        }
    }
}
