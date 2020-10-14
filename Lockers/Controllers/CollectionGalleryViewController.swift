//
//  CollectionGalleryViewController.swift
//  Lockers
//
//  Created by Anil System on 27/07/20.
//  Copyright © 2020 Anil System. All rights reserved.
//

import UIKit

class CollectionGalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imagesCollections = [UIImage]()
    var imagePicker = UIImagePickerController()
    let documentInteractionController = UIDocumentInteractionController()
    var nameArray = [String]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Naughty Boy!!"
        if let value = defaults.value(forKey: "SavedStringArray") as? [String] {
            nameArray = value
        }
        imagesCollections = getImage(imageNames: nameArray)
        
        customRightBarButtonTitle(title: "Add")
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionViewReload()
    }
    
    func collectionViewReload() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        synchingimages()
    }
    
    @objc override func btnDoneClickedRightTitle(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func synchingimages() {
        if self.imagesCollections.count == 0 {
            self.view.viewEmptyView(bgImage: UIImage.init(named: "covid") ?? UIImage(), errorMsg: "No images in your local drive")
        } else {
            self.view.removeEmptyview()
        }
    }
    
    func setImage(images : UIImage) {
        nameArray.append(saveImage(image: images))
        imagesCollections = getImage(imageNames: nameArray)
        defaults.set(nameArray, forKey: "SavedStringArray")
    }
    
    func getImage(imageNames : [String]) -> [UIImage] {var images = [UIImage]()
        for imageName in imageNames {
            
            if let imagePath = getFilePath(fileName: imageName) {
                images.append(UIImage(contentsOfFile: imagePath) ?? UIImage())
            }
        }
        return images
    }
    
    func getFilePath(fileName: String) -> String? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        var filePath: String?
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if paths.count > 0 {
            let dirPath = paths[0] as NSString
            filePath = dirPath.appendingPathComponent(fileName)
        }
        else {
            filePath = nil
        }
        
        return filePath
    }
    
    func uiDocumnetPickerControllerSetup() {
        documentInteractionController.delegate = self
    }
    
    func saveImage(image: UIImage) -> String {
        let imageData = NSData(data: image.pngData()!)
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)
        let docs = paths[0] as NSString
        let uuid = NSUUID().uuidString + ".png"
        let fullPath = docs.appendingPathComponent(uuid)
        _ = imageData.write(toFile: fullPath, atomically: true)
        return uuid
    }
    
    func removeOldFileIfExist(fileName : String) {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        if paths.count > 0 {
            let dirPath = paths[0]
            let fileName = fileName
            let filePath = NSString(format:"%@/%@", dirPath, fileName) as String
            if FileManager.default.fileExists(atPath: filePath) {
                do {
                    try FileManager.default.removeItem(atPath: filePath)
                    print("User photo has been removed")
                } catch {
                    print("an error during a removing")
                }
            }
        }
    }
}

extension CollectionGalleryViewController {
    func share(url: UIImage) {}
}

extension CollectionGalleryViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        guard let navVC = self.navigationController else {
            return self
        }
        return navVC
    }
}

extension CollectionGalleryViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.imagesCollections.removeAll()
                self.setImage(images: pickedImage)
                self.collectionView.reloadData()
            }
            self.collectionViewReload()
        }
    }
}

extension CollectionGalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesCollections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell
        cell?.imageView.image = imagesCollections[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PreviewViewController") as PreviewViewController
        vc.image = imagesCollections[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            // Create an action for sharing
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show share sheet
                self.share(url: self.imagesCollections[indexPath.row])
            }
            
            // Create an action for copy
            let rename = UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")) { action in
                // Perform copy
            }
            
            // Create an action for delete with destructive attributes (highligh in red)
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                // Perform delete
                self.imagesCollections.remove(at: indexPath.row)
                self.removeOldFileIfExist(fileName: self.nameArray[indexPath.row])
                self.nameArray.remove(at: indexPath.row)
                self.defaults.set(self.nameArray, forKey: "SavedStringArray")
                self.collectionViewReload()
            }
            
            return UIMenu(title: "", children: [share, rename, delete])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/2.0) - 5 , height: (self.collectionView.frame.height/4.2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
}
