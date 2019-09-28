//
//  IntentHandler.swift
//  XQSiriDemoIntents
//
//  Created by WXQ on 2019/9/27.
//  Copyright © 2019 WXQ. All rights reserved.
//

import Intents

// MARK: - 自定义 do, siri 会直接提示成功, 什么 可以了, 好的 这些的
@available(iOS 12.0, watchOS 5.0, *)
extension INExtension: XQTestDoIntentHandling {
    
    // MARK: - XQTestDoIntentHandling
    
    public func handle(intent: XQTestDoIntent, completion: @escaping (XQTestDoIntentResponse) -> Swift.Void) {
        print(#function, intent, "XQTestDoIntentHandling", #file)
        
        let response = XQTestDoIntentResponse.init(code: .success, userActivity: nil)
        completion(response)
    }
    
    public func confirm(intent: XQTestDoIntent, completion: @escaping (XQTestDoIntentResponse) -> Swift.Void) {
        print(#function, intent, "XQTestDoIntentHandling", #file)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let response = XQTestDoIntentResponse.init(code: .success, userActivity: nil)
            completion(response)
        }
    }
    
}
