
//
//  Extension.swift
//  Lockers
//
//  Created by Anil System on 28/07/20.
//  Copyright © 2020 Anil System. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
