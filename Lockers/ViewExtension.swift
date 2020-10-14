//
//  ViewExtension.swift
//
//  Created by Anil Kumar on 18/02/19.
//  Copyright © 2019 Busywizzy. All rights reserved.
//

import Foundation
import  UIKit
extension UIView {
    func viewEmptyView(bgImage: UIImage, errorMsg: String) {
        let bGImageView = UIImageView.init(image: bgImage)
        bGImageView.frame = CGRect(x: 0, y: 0, width: 100 , height: 100)
        bGImageView.center = self.center
        bGImageView.center.y -= 50
        bGImageView.tag = 100
        self.addSubview(bGImageView)
        
        let textError = UILabel()
        textError.tag = 101
        textError.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: 100)
        textError.text = errorMsg
        textError.textAlignment = .center
        textError.center = self.center
        textError.center.y += 50
        self.addSubview(textError)
    }
    
    func removeEmptyview(){
        if let viewWithTag = self.viewWithTag(100){
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = self.viewWithTag(101){
            viewWithTag.removeFromSuperview()
        }
    }
    
    func viewEmptyError()-> UIView{
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 50))
        view.backgroundColor = .lightGray
        let label = UILabel.init(frame: CGRect.init(x: 20, y: view.center.y, width: self.frame.size.width - 40, height: 100))
        label.text = "No events has been found"
        label.textColor = .black
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .semibold)
        view.addSubview(label)
        return view
    }
    
    func showToast(message : String,completion : (() -> ())? = nil) {
        let v = UIApplication.shared.keyWindow!
        let toastLabel = UILabel(frame: CGRect(x: v.frame.size.width/2 - 50, y: v.frame.size.height-150, width: v.frame.size.width - 50, height: 55))
        toastLabel.numberOfLines = 2
        toastLabel.center.x = v.center.x
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        v.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            completion?() ?? nil
        })
    }
    
    func showAlert(withTitle title: String, message: String, completion: (() -> Void)? = nil)
    {
        let v = UIApplication.shared.keyWindow!
        let okAction = UIAlertAction(title: "Ok", style: .default){ (action) in
            completion?()
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert);
        alertController.addAction(okAction)
        
        v.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
