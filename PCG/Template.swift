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
    case firstName = "First Name"
    case lastName = "Last Name"
    case lastInitial = "Last Initial"
    case fullName = "Full Name"
    case photo = "Photo"
    case initials = "Initials"
    case date = "Date"
    case address = "Address"
    case state = "State"
}

