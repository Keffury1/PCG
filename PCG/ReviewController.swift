//
//  ReviewController.swift
//  PCG
//
//  Created by Bobby Keffury on 8/25/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation

class ReviewController {
    
    //MARK: - Properties
    
    var reviews: [Review]?
    
    //MARK: - Methods
    
    func loadReviews() {
        if let file = Bundle.main.url(forResource: "Reviews", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                let reviews = try decoder.decode([Review].self, from: data)
                self.reviews = reviews
            } catch {
                print(error)
            }
        }
    }
}
