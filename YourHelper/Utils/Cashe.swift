//
//  Cashe.swift
//  YourHelper
//
//  Created by Valentin Mironov on 26.06.2020.
//  Copyright © 2020 Valentin Mironov. All rights reserved.
//

import Foundation
import WatchConnectivity

class Cashe: NSObject {
    
    var wcSession : WCSession = WCSession.default
    
    override init(){
        super.init()
        wcSession.delegate = self
        WCSession.default.activate()
        
        
        //        NotificationCenter.default.addObserver(
        //            self, selector: #selector(type(of: self).activationDidComplete(_:)),
        //            name: .activationDidComplete, object: nil
        //        )
        //
        //        NotificationCenter.default.addObserver(
        //            self, selector: #selector(type(of: self).reachabilityDidChange(_:)),
        //            name: .reachabilityDidChange, object: nil
        //        )
        //
        //
        //        NotificationCenter.default.addObserver(
        //            self, selector: #selector(type(of: self).reachabilityDidChange(_:)),
        //            name: .didBecomeInactive, object: nil
        //        )
    }
    
    
    
    //    @objc
    //    func activationDidComplete(_ notification: Notification) {
    ////        updateReachabilityColor()
    //    }
    //
    //    // .reachabilityDidChange notification handler.
    //    //
    //    @objc
    //    func reachabilityDidChange(_ notification: Notification) {
    ////        updateReachabilityColor()
    //    }
    //
    //    @objc
    //    func didBecomeInactive(_ notification: Notification) {
    ////        updateInactiveColor()
    //    }
    
    //MARK: - CACHE
    private static let defaults = UserDefaults.standard
    
    
    
    static var tempOldAnswer: String?{
        get{
            guard let answer = defaults.string(forKey: KeyForCache.oldAnswer.rawValue) else{
                print("--> Message from cache: tempOldAnswer not saved <-- ")
                return nil
            }
            print("--> Message from cache: tempOldAnswer geting <-- ")
            return answer
        }
        set{
            defaults.set(newValue, forKey:KeyForCache.oldAnswer.rawValue )
            if(newValue == nil){
                print("--> Message from cache: tempOldAnswer clear <-- ")
                return
            }
            print("--> Message from cache: tempOldAnswer saved <-- ")
            //            print("token = \(newValue!)")
            
        }
    }
    
    
    
    var aswers: [AnswerModel]?{
        get{
            guard let answer = Cashe.defaults.object(forKey:  KeyForCache.answer.rawValue) as? Data else{
                print("--> Message from cache: answers not saved <-- ")
                return nil
            }
            let decoder = JSONDecoder()
            if let result = try? decoder.decode([AnswerModel].self, from: answer) {
                print("--> Message from cache: get saved aswers <-- ")
                return result
            }
            print("--> Message from cache: answers not saved 2 <-- ")
            return nil
        }
        set{
            
            
            do {
                let res = try JSONEncoder().encode(newValue)
                Cashe.defaults.set(res, forKey: KeyForCache.answer.rawValue)
                //transfer to apple watch
                if (WCSession.isSupported() && newValue != nil){
                    let message = [KeyForTransferWatch.answerModels.rawValue:newValue!]
                    print("wcSession.transferUserInfo(message).isTransferring - ", wcSession.transferUserInfo(message).isTransferring)
                }
                
                print("--> Message from cache: set answers saved <-- ")
            } catch {
                print("--> Message from cache: error saving answers <--")
            }
            
        }
    }
    
    
    
    static var aswer: AnswerModel?{
        get{
            guard let answer = defaults.object(forKey:  KeyForCache.answer.rawValue) as? Data else{
                print("--> Message from cache: answer not saved <-- ")
                return nil
            }
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(AnswerModel.self, from: answer) {
                print("--> Message from cache: get saved aswer <-- ")
                return result
            }
            print("--> Message from cache: answer not saved 2 <-- ")
            return nil
        }
        set{
            
            do {
                let res = try JSONEncoder().encode(newValue)
                defaults.set(res, forKey: KeyForCache.answer.rawValue)
                print("--> Message from cache: set answer saved <-- ")
            } catch {
                print("--> Message from cache: error saving answer <--")
            }
            
        }
    }
} 


extension Cashe: WCSessionDelegate {
    
    
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        postNotificationOnMainQueueAsync(name: .activationDidComplete)
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        postNotificationOnMainQueueAsync(name: .reachabilityDidChange)
    }
    
    
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        postNotificationOnMainQueueAsync(name: .didBecomeInactive)
        print("sessionDidBecomeInactive")
        //code
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        postNotificationOnMainQueueAsync(name: .didBecomeInactive)
        print("sessionDidDeactivate")
    }
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        postNotificationOnMainQueueAsync(name: .didBecomeInactive)
        print("\n didFinish")
    }
}


extension Notification.Name {
    static let didBecomeInactive = Notification.Name("didBecomeInactive")
    static let activationDidComplete = Notification.Name("ActivationDidComplete")
    static let reachabilityDidChange = Notification.Name("ReachabilityDidChange")
}

private func postNotificationOnMainQueueAsync(name: NSNotification.Name){
    DispatchQueue.main.async {
        NotificationCenter.default.post(name: name, object: nil)
    }
}

private func delay(_ delay:Double, closure:@escaping ()->()) {
    let when = DispatchTime.now() + delay
    DispatchQueue.global(qos: .background).asyncAfter(deadline: when, execute: closure)
}
