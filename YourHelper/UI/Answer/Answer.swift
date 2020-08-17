//
//  Answer.swift
//  YourHelper
//
//  Created by Valentin Mironov on 25.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import SwiftUI
struct Answer: View {
    @State var text: String = "Your answer"
    @State var textHeight: CGFloat = 250
    @State var startPopover = false
    var answer: AnswerModel
    @ObservedObject var vm: AnswerListViewModel
    
    
    init(answer: AnswerModel, vm: ObservedObject<AnswerListViewModel>) {
        self.answer = answer
        self._vm = vm
        self.text = answer.description
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(text)
                    .padding()
                    .onDisappear{
                        self.answer.description = self.text
                        self.vm.objectWillChange.send()
                    }
            }
                //title
                .navigationBarTitle("Ответ")
                .navigationBarItems(trailing: Button(action: {
                    self.startPopover = !self.startPopover
                }){
                    Image.init(systemName: "plus")
                }
                    .popover(isPresented: $startPopover) {
                        RefactorAnswer(_text: self.$text, oldText: self.text)
                }).onTapGesture {
                    UIApplication.shared.endEditing()
            }
            
            //body
        }
    }
}
//
//    struct Answer_Previews: PreviewProvider {
//        static var previews: some View {
//            Answer(answer: AnswerModel(id: 1, answer: "debug"))
//        }
//    }
//}
