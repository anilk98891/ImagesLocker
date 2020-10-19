//
//  PreviewViewController.swift
//  Lockers
//
//  Created by Anil System on 28/07/20.
//  Copyright © 2020 Anil System. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewPreview : UIImageView!
    
    var image = UIImage()
    var currentAnimation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageViewPreview.image = image
        customRightBarButtonTitle(title: "Rotate")
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewPreview
    }
    
    @objc override func btnDoneClickedRightTitle(sender: UIButton) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],animations: {
            switch self.currentAnimation {
            case 0:
                self.imageViewPreview.transform = CGAffineTransform(scaleX: 2, y: 2)
                
            case 1:
                self.imageViewPreview.transform = .identity
                
            case 2:
                self.imageViewPreview.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                
            case 3:
                self.imageViewPreview.transform = CGAffineTransform(scaleX: -2, y: -2)
                
            case 4:
                self.imageViewPreview.transform = CGAffineTransform(scaleX: -1, y: -1)
                
            case 5:
                self.imageViewPreview.transform = .identity
                
            case 6:
                self.imageViewPreview.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                
            case 7:
                self.imageViewPreview.transform = .identity
                
            default:
                break
            }
        })
        {
            finished in
            self.currentAnimation += 1
            if self.currentAnimation > 7 {
                self.currentAnimation = 0
            }
        }
    }
}
