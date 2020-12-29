//
//  QuestionModel.swift
//  questionBank
//
//  Created by oguz on 25.02.2020.
//  Copyright © 2020 oğuz hendekci. All rights reserved.
//

import Foundation
import UIKit

class questionModel {
    
    var id: Int?
    var question: String?
    var optiona: String?
    var optionb: String?
    var optionc: String?
    var optiond: String?
    var optione: String?
    var answer: String?
    
    init(id: Int?, question: String?, optiona: String? , optionb: String?, optionc: String?, optiond: String?, optione: String?, answer: String?) {
        self.id = id
        self.question = question
        self.optiona = optiona
        self.optionb = optionb
        self.optionc = optionc
        self.optiond = optiond
        self.optione = optione
        self.answer = answer
        
    }
    init() {
        
    }
    
    
}
