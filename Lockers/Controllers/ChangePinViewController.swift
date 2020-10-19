//
//  ChangePinViewController.swift
//  Lockers
//
//  Created by Anil System on 19/10/20.
//  Copyright © 2020 Anil System. All rights reserved.
//

import UIKit

class ChangePinViewController: UIViewController {
    @IBOutlet weak var textViewOld: UITextField!
    @IBOutlet weak var textViewNew: UITextField!
    @IBOutlet weak var imageView: UIImageView!

    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        customRightBarButtonTitle(title: "Save")
        loadGif()
    }
    
    private func loadGif() {
        let jeremyGif = UIImage.gifImageWithName("locker")
        imageView.image = jeremyGif
    }
    
    private func getUserDefaultValue() -> String? {
        return (defaults.value(forKey: "pin") ?? "") as? String
    }
    
    private func storeuserDefaults(){
        defaults.setValue(textViewNew.text, forKey: "pin")
        self.showAlert(withTitle: "Success!!", message: "Saved successfully") {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func storeNewValueUserDefaults() {
        let oldValue = getUserDefaultValue()
        if oldValue == textViewOld.text || oldValue == ""  {
            storeuserDefaults()
        } else {
            self.view.showToast(message: "Please enter valid old password.")
        }
    }
    
    @objc override func btnDoneClickedRightTitle(sender: UIButton) {
        //save to userdefaults
        guard !(textViewNew.text?.isEmpty ?? false) else{
            self.showAlert(withTitle: "Empty new password", message: "Enter new password!!")
            return
        }
        storeNewValueUserDefaults()
    }
    
}
