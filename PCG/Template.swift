//
//  Template.swift
//  PCG
//
//  Created by Bobby Keffury on 1/19/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

struct Template {

    var image: UIImage
    var needs: [Need]
    var fulfilled: [String]
    
    internal init(image: UIImage, needs: [Need], fulfilled: [String]) {
        self.image = image
        self.needs = needs
        self.fulfilled = fulfilled
    }
}

enum Need: String {
    case hisFirstName
    case hisLastName
    case hisLastInitial
    case herFirstName
    case herLastName
    case fullName
    case photo
    case initials
    case shortDate
    case longDate
    case address
    case state
    case year
    case monthYear
}

