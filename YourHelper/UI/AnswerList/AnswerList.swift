//
//  AnswerList.swift
//  YourHelper
//
//  Created by Valentin Mironov on 26.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import SwiftUI

struct AnswerList: View {
    @ObservedObject var vm: AnswerListViewModel = AnswerListViewModel()
    
    var body: some View {
        NavigationView {
            List(vm.items){ answer in
                NavigationLink(destination: Answer(answer: answer, vm: self._vm)){
                    Text(answer.description)
                }
            }.onAppear(perform: {
                self.vm.objectWillChange.send()
            })
                .navigationBarTitle("Ответ")
                .navigationBarItems(trailing: Button(action: {
                    let lastElementId = self.vm.items.last?.id
                    let id = lastElementId == nil ? 0: (lastElementId! + 1)
                    self.vm.addItem(item:AnswerModel(id: id, answer: "Your answer"))
                }){
                    Image.init(systemName: "plus")
                }).padding()
            
        }
        
    }
    
    
    
}

struct AnswerList_Previews: PreviewProvider {
    static var previews: some View {
        AnswerList()
    }
}
