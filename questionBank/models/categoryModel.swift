//
//  categoryModel.swift
//  questionBank
//
//  Created by oguz on 2.02.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import Foundation
import UIKit

class categoryModel {
    
    var id: Int?
    var categoryName: String?
    var image: UIImage?
    var rowOrder: Int?
    var no_of: Int?
    var maxlevel: Int?
    
    init(id: Int?, categoryName: String?, image: UIImage?, rowOrder: Int?, no_of: Int?, maxlevel: Int?) {
        self.id = id
        self.categoryName = categoryName
        self.image = image
        self.rowOrder = rowOrder
        self.no_of = no_of
        self.maxlevel = maxlevel
        
    }
    init() {
        
    }
    
    
}
