//
//  Template.swift
//  PCG
//
//  Created by Bobby Keffury on 1/19/21.
//  Copyright © 2021 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

struct Template: Codable, Identifiable {
    var id: Int
    var name: String
    var needs: [Needs]
    var fulfilled: [Int : String]
    static let idKey = \Template.id
}

struct Needs: Codable, Identifiable {
    var id: Int
    var name: String
    static let idKey = \Needs.id
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
    case petName = "Pet's Name"
    case monogram = "Monogram"
}
