//
//  RefactorAnswer.swift
//  YourHelper
//
//  Created by Valentin Mironov on 25.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import SwiftUI

struct RefactorAnswer: View {
    @Binding var text: String
    @State var textHeight: CGFloat = 350
    @State var showAlert: Bool = false
    let oldText: String
    
    
    init(_text: Binding<String>, oldText: String){
        self._text = _text
        self.oldText = oldText.description
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            TextView(placeholder: "Your answer", text: self.$text, minHeight: self.textHeight, calculatedHeight: self.$textHeight)
                .padding(.all, 8.0)
                .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            
            HStack {
                Button(action: {
                    self.text = Cashe.tempOldAnswer!
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Close").foregroundColor(.red)
                }.padding()
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Save")
                }.padding()
                
            }
            Spacer()
            
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

//struct RefactorAnswer_Previews: PreviewProvider {
//    static var previews: some View {
//        RefactorAnswer(text: Binding<String>(get: { () -> String in
//            return "your answer"
//        }, set: { (newElement) in
//
//        }))
//    }
//}

