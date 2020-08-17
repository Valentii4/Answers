//
//  AswerListViewModel.swift
//  YourHelper
//
//  Created by Valentin Mironov on 03.07.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import Foundation
class AnswerListViewModel: ObservableObject {
    var items: [AnswerModel] = [] {
        willSet{
            objectWillChange.send()
            cache.aswers = newValue
        }
    }
    var cache: Cashe!
    
    init() {
        cache = Cashe()
        
    }
    
    func addItem(item: AnswerModel) {
        items.append(item)
    }
    
    func addItems(items: [AnswerModel]){
        for item in items{
            self.items.append(item)
        }
    }
    
    func giveTheItemNumber(id: Int) -> AnswerModel?{
        for item in items{
            if(item.id == id){
                return item
            }
        }
        return nil
    }
    
}
