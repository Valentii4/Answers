//
//  ContentView.swift
//  YourHelper
//
//  Created by Valentin Mironov on 25.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
//        Answer(answer: AnswerModel(id: 1, answer: "debug"))
        
        AnswerList()
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
