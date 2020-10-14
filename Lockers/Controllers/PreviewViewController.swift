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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageViewPreview.image = image
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewPreview
    }
    
}
