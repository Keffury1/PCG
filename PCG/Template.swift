//
//  Template.swift
//  PCG
//
//  Created by Bobby Keffury on 1/19/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

struct Template: Codable {
    var image: String
    var needs: [Need]
    var fulfilled: [String]
    
    internal init(image: String, needs: [Need], fulfilled: [String]) {
        self.image = image
        self.needs = needs
        self.fulfilled = fulfilled
    }
}

enum Need: String, Codable {
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
