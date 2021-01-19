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
    var hisFirstName: Bool
    var hisLastName: Bool
    var herFirstName: Bool
    var herLastName: Bool
    var fullName: Bool
    var photo: Bool
    var initials: Bool
    var shortDate: Bool
    var longDate: Bool
    var address: Bool
    var state: Bool
    var year: Bool
    var monthYear: Bool
    
    internal init(image: UIImage, hisFirstName: Bool, hisLastName: Bool, herFirstName: Bool, herLastName: Bool, fullName: Bool, photo: Bool, initials: Bool, shortDate: Bool, longDate: Bool, address: Bool, state: Bool, year: Bool, monthYear: Bool) {
        self.image = image
        self.hisFirstName = hisFirstName
        self.hisLastName = hisLastName
        self.herFirstName = herFirstName
        self.herLastName = herLastName
        self.fullName = fullName
        self.photo = photo
        self.initials = initials
        self.shortDate = shortDate
        self.longDate = longDate
        self.address = address
        self.state = state
        self.year = year
        self.monthYear = monthYear
    }
}
