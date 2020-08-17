//
//  Answer.swift
//  YourHelper
//
//  Created by Valentin Mironov on 26.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import Foundation


class AnswerModel: Codable, Identifiable {
    let id: Int
    var description: String = ""
    
    init(id: Int, answer: String) {
        self.id = id
        self.description = answer
    }
}
