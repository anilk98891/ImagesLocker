//
//  ViewControllerExtension.swift
//
//  Created by Anil Kumar on 18/02/19.
//  Copyright © 2019 Busywizzy. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func showAlert(withTitle title: String, message: String, completion: (() -> Void)? = nil)
    {
        let okAction = UIAlertAction(title: "Ok", style: .default){ (action) in
            completion?()
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showOkAndCancelAlert(withTitle title: String,buttonTitle :String, message: String, _ okAction: @escaping ()->Void)
    {
        let ok = UIAlertAction(title: buttonTitle, style: .default){ (action) in
            okAction()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive){ (action) in
            
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        alertController.addAction(cancel)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func customRightBarButtonTitle(title: String){
        let rightButton = UIButton() //Custom back Button
        rightButton.frame = CGRect(x: 0, y: 0, width: 42, height: 36)
        rightButton.setTitle(title, for: .normal)
        rightButton.setTitleColor(UIColor.systemRed, for: .normal)
        rightButton .addTarget(self, action: #selector(self.btnDoneClickedRightTitle(sender:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = rightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = 0;
        self.navigationItem.setRightBarButtonItems([negativeSpacer, rightBarButton], animated: false)
    }
    
    func customRightBarButton(image: UIImage){
        let rightButton = UIButton() //Custom back Button
        rightButton.frame = CGRect(x: 0, y: 0, width: 42, height: 42)
        rightButton.setImage(image, for: .normal)
        rightButton .addTarget(self, action: #selector(self.btnDoneClicked(sender:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = rightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = 0;
        self.navigationItem.setRightBarButtonItems([negativeSpacer, rightBarButton], animated: false)
    }
    
    func customLeftBarButton(title: String){
        let leftButton = UIButton() //Custom back Button
        leftButton.frame = CGRect(x: 0, y: 0, width: 42, height: 36)
        leftButton.setTitle(title, for: .normal)
        leftButton.setTitleColor(.black, for: .normal)
        leftButton .addTarget(self, action: #selector(self.btnDoneClickedLeft(sender:)), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = leftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = 0;
        self.navigationItem.setLeftBarButtonItems([negativeSpacer, leftBarButton], animated: false)
    }
    
    @objc func btnDoneClickedRightTitle(sender:UIButton){
    }
    
    @objc func btnDoneClickedLeft(sender:UIButton)
    { //Dne Button
    }
    
    @objc func btnDoneClicked(sender:UIButton)
    { //Dne Button
    }
  
    
}
