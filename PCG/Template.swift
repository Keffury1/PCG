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
    var id: Int
    var name: String
    var needs: [Needs]
    var fulfilled: [Int]
}

struct Needs: Codable {
    var id: Int
    var name: String
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
    case message = "Message"
}
