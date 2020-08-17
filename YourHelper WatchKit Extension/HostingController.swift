//
//  HostingController.swift
//  YourHelper WatchKit Extension
//
//  Created by Valentin Mironov on 25.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import SwiftUI

class HostingController: WKHostingController<ContentView>, WCSessionDelegate {
    
    var wcSession : WCSession!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        wcSession = WCSession.default
        wcSession.delegate = self
    }
    
    override func willActivate() {
        super.willActivate()
        
//        wcSession = WCSession.default
//        wcSession.delegate = self
//        wcSession.activate()
    }
    // MARK: WCSession Methods
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        let _ = 0
    }
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        let w = userInfo[KeyForTransferWatch.answerModels.rawValue] as? [AnswerModel]
        print("AnswerModel equal -", w?.count)
        if(w != nil){
            if(w!.count != 0 ){
                print("AnswerModel is not null", w![0].description)
            }
        }
    }
    
    override var body: ContentView {
//        wcSession = WCSession.default
//        wcSession.delegate = self
//        wcSession.activate()
        wcSession.activate()
        return ContentView()
    }
}
