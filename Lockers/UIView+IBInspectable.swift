
import UIKit
import AVFoundation

//@IBDesignable           //@IBDesignable does not work for class extensions.
extension UIView {
    
    //MARK:- Border related
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    
    //MARK:- Shadow related
    
    @IBInspectable var shadow: Bool {
        get {
            return self.shadow
        }
        set {
            if(newValue)
            {
                layer.shadowColor = UIColor.gray.cgColor;
                layer.shadowRadius = 3;
                layer.shadowOpacity = 0.3;
                layer.masksToBounds = false;
            }
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
   
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
}

extension AVURLAsset {
    var fileSize: Int? {
        let keys: Set<URLResourceKey> = [.totalFileSizeKey, .fileSizeKey]
        let resourceValues = try? url.resourceValues(forKeys: keys)
        return resourceValues?.fileSize ?? resourceValues?.totalFileSize
    }
}

extension String {
    var data: Float? {
        let arr = self.components(separatedBy: " ")
        if arr.count > 0 {
            return Float(arr[0]) ?? 0.0
        } else {
            return 0.0
        }
    }
    
    var cancat: String? {
        let arr = self.components(separatedBy: "/")
        if arr.count > 0 && arr.count >= 2{
            return arr[2]
        } else {
            return ""
        }
    }
}
