//
//  IntentHandler.swift
//  XQSiriDemoIntents
//
//  Created by WXQ on 2019/9/27.
//  Copyright © 2019 WXQ. All rights reserved.
//

import Intents
import XQIntentsSource

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        // 一直都会先走这个的
//        print(#function, intent, "IntentHandler")
        
        // 返回这个, 是要去执行的代理....如果不想所有都给这个对象执行, 也可以创建一个出来
        return self
    }
    
}

// MARK: - 自定义 run, siri...什么都不会做, 直接跳转到 app
extension IntentHandler: XQTestGoIntentHandling {
    
    // MARK: - XQTestGoIntentHandling
    func handle(intent: XQTestGoIntent, completion: @escaping (XQTestGoIntentResponse) -> Void) {
        print(#function, intent, "XQTestGoIntentHandling")
        
        let response = XQTestGoIntentResponse.init(code: .success, userActivity: nil)
        completion(response)
    }
    
    func confirm(intent: XQTestGoIntent, completion: @escaping (XQTestGoIntentResponse) -> Void) {
        print(#function, intent, "XQTestGoIntentHandling")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let response = XQTestGoIntentResponse.init(code: .success, userActivity: nil)
            completion(response)
        }
    }
    
    
}

// MARK: - 自定义 run, siri...什么都不会做, 直接跳转到 app
extension IntentHandler: XQTestRunIntentHandling {
    
    // MARK: - XQTestRunIntentHandling
    func handle(intent: XQTestRunIntent, completion: @escaping (XQTestRunIntentResponse) -> Void) {
        print(#function, intent, "XQTestRunIntentHandling")
        
        let response = XQTestRunIntentResponse.init(code: .success, userActivity: nil)
        completion(response)
    }
    
    func confirm(intent: XQTestRunIntent, completion: @escaping (XQTestRunIntentResponse) -> Void) {
        print(#function, intent, "XQTestRunIntentHandling")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            let response = XQTestRunIntentResponse.init(code: .success, userActivity: nil)
            completion(response)
        }
    }
    
    
}


// MARK: - 自定义 order, siri 那边会提示 购买某某某...
extension IntentHandler: XQTestOneIntentHandling {
    
    // MARK: - XQTestOneIntentHandling
    func handle(intent: XQTestOneIntent, completion: @escaping (XQTestOneIntentResponse) -> Void) {
        print(#function, intent, "XQTestOneIntentHandling")
        let response = XQTestOneIntentResponse.init(code: XQTestOneIntentResponseCode.success, userActivity: nil)
        completion(response)
    }
    
    func confirm(intent: XQTestOneIntent, completion: @escaping (XQTestOneIntentResponse) -> Void) {
        print(#function, intent, "XQTestOneIntentHandling")
        
        let response = XQTestOneIntentResponse.init(code: XQTestOneIntentResponseCode.success, userActivity: nil)
        completion(response)
    }
    
}

// MARK: - 发送消息这些, 例如QQ
extension IntentHandler: INSendMessageIntentHandling, INSearchForMessagesIntentHandling, INSetMessageAttributeIntentHandling {
    
    // MARK: - INSendMessageIntentHandling
    
    func resolveRecipients(for intent: INSendMessageIntent, with completion: @escaping ([INSendMessageRecipientResolutionResult]) -> Void) {
        print(#function)
        if let recipients = intent.recipients {
            
            // If no recipients were provided we'll need to prompt for a value.
            if recipients.count == 0 {
                completion([INSendMessageRecipientResolutionResult.needsValue()])
                return
            }
            
            var resolutionResults = [INSendMessageRecipientResolutionResult]()
            for recipient in recipients {
                let matchingContacts = [recipient] // Implement your contact matching logic here to create an array of matching contacts
                switch matchingContacts.count {
                case 2  ... Int.max:
                    // We need Siri's help to ask user to pick one from the matches.
                    resolutionResults += [INSendMessageRecipientResolutionResult.disambiguation(with: matchingContacts)]
                    
                case 1:
                    // We have exactly one matching contact
                    resolutionResults += [INSendMessageRecipientResolutionResult.success(with: recipient)]
                    
                case 0:
                    // We have no contacts matching the description provided
                    resolutionResults += [INSendMessageRecipientResolutionResult.unsupported()]
                    
                default:
                    break
                    
                }
            }
            completion(resolutionResults)
        }
    }
    
    func resolveContent(for intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        print(#function)
        if let text = intent.content, !text.isEmpty {
            completion(INStringResolutionResult.success(with: text))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func confirm(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // Verify user is authenticated and your app is ready to send a message.
        print(#function)
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }
    
    func handle(intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // Implement your application logic to send a message here.
        print(#function)
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
    
    
    // MARK: - INSearchForMessagesIntentHandling
    
    func handle(intent: INSearchForMessagesIntent, completion: @escaping (INSearchForMessagesIntentResponse) -> Void) {
        // Implement your application logic to find a message that matches the information in the intent.
        print(#function)
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSearchForMessagesIntent.self))
        let response = INSearchForMessagesIntentResponse(code: .success, userActivity: userActivity)
        // Initialize with found message's attributes
        response.messages = [INMessage(
            identifier: "identifier",
            content: "I am so excited about SiriKit!",
            dateSent: Date(),
            sender: INPerson(personHandle: INPersonHandle(value: "sarah@example.com", type: .emailAddress), nameComponents: nil, displayName: "Sarah", image: nil,  contactIdentifier: nil, customIdentifier: nil),
            recipients: [INPerson(personHandle: INPersonHandle(value: "+1-415-555-5555", type: .phoneNumber), nameComponents: nil, displayName: "John", image: nil,  contactIdentifier: nil, customIdentifier: nil)]
            )]
        completion(response)
    }
    
    // MARK: - INSetMessageAttributeIntentHandling
    
    func handle(intent: INSetMessageAttributeIntent, completion: @escaping (INSetMessageAttributeIntentResponse) -> Void) {
        // Implement your application logic to set the message attribute here.
        print(#function)
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSetMessageAttributeIntent.self))
        let response = INSetMessageAttributeIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
}

// MARK: - 运动方面
extension IntentHandler: INStartWorkoutIntentHandling, INPauseWorkoutIntentHandling, INResumeWorkoutIntentHandling, INCancelWorkoutIntentHandling, INEndWorkoutIntentHandling {
    // MARK: - INStartWorkoutIntentHandling
    func handle(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print(#function, intent, "INStartWorkoutIntentHandling")
    }
    
    func confirm(intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print(#function, intent, "INStartWorkoutIntentHandling")
    }
    
    func resolveWorkoutName(for intent: INStartWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function, intent, "INStartWorkoutIntentHandling")
    }
    
    
    func resolveGoalValue(for intent: INStartWorkoutIntent, with completion: @escaping (INDoubleResolutionResult) -> Void) {
        print(#function, intent, "INStartWorkoutIntentHandling")
    }
    
    
    func resolveWorkoutGoalUnitType(for intent: INStartWorkoutIntent, with completion: @escaping (INWorkoutGoalUnitTypeResolutionResult) -> Void) {
        print(#function)
    }
    
    
    func resolveWorkoutLocationType(for intent: INStartWorkoutIntent, with completion: @escaping (INWorkoutLocationTypeResolutionResult) -> Void) {
        print(#function)
    }
    
    func resolveIsOpenEnded(for intent: INStartWorkoutIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
        print(#function)
    }
    
    // MARK: - INPauseWorkoutIntentHandling
    
    func handle(intent: INPauseWorkoutIntent, completion: @escaping (INPauseWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func confirm(intent: INPauseWorkoutIntent, completion: @escaping (INPauseWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func resolveWorkoutName(for intent: INPauseWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function)
    }
    
    // MARK: - INResumeWorkoutIntentHandling
    func handle(intent: INResumeWorkoutIntent, completion: @escaping (INResumeWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func confirm(intent: INResumeWorkoutIntent, completion: @escaping (INResumeWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func resolveWorkoutName(for intent: INResumeWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function)
    }
    
    // MARK: - INCancelWorkoutIntentHandling
    func handle(intent: INCancelWorkoutIntent, completion: @escaping (INCancelWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func confirm(intent: INCancelWorkoutIntent, completion: @escaping (INCancelWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func resolveWorkoutName(for intent: INCancelWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function)
    }
    
    // MARK: - INEndWorkoutIntentHandling
    
    func handle(intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func confirm(intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
        print(#function)
    }
    
    func resolveWorkoutName(for intent: INEndWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function)
    }
}


// MARK: - 跟车的一些交互
extension IntentHandler: INActivateCarSignalIntentHandling {
    
    // MARK: - INActivateCarSignalIntentHandling
    
    /// 这里流程是这样
    /// 对 siri 说 打开双闪灯, 然后,  resolveCarName -> resolveSignals -> confirm
    /// confirm 这里会询问用户, 是否要激活汽车视觉信号, 然后用户说是, 就会走 handle, 走完 handle 就结束了
    /// 中间的流程, 比如多辆车, 还有各种什么的, 我们可以返回值, 让用户去选
    
    func handle(intent: INActivateCarSignalIntent, completion: @escaping (INActivateCarSignalIntentResponse) -> Void) {
        print(#function, intent, "INActivateCarSignalIntentHandling")
        let response = INActivateCarSignalIntentResponse.init(code: .success, userActivity: nil)
        completion(response)
    }
    
    func confirm(intent: INActivateCarSignalIntent, completion: @escaping (INActivateCarSignalIntentResponse) -> Void) {
        print(#function, intent, "INActivateCarSignalIntentHandling")
        let activity = NSUserActivity.init(activityType: "xq_INActivateCarSignalIntentHandling")
        activity.title = "activity.title"
        
        let response = INActivateCarSignalIntentResponse.init(code: .success, userActivity: activity)
        completion(response)
    }
    
    func resolveCarName(for intent: INActivateCarSignalIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function, intent, "INActivateCarSignalIntentHandling")
        
        let speakableString = INSpeakableString.init(vocabularyIdentifier: "vocabularyIdentifier", spokenPhrase: "spokenPhrase", pronunciationHint: "pronunciationHint")
        let result = INSpeakableStringResolutionResult.success(with: speakableString)
//        let result = INSpeakableStringResolutionResult.notRequired()
        completion(result)
        
    }
    
    func resolveSignals(for intent: INActivateCarSignalIntent, with completion: @escaping (INCarSignalOptionsResolutionResult) -> Void) {
        print(#function, intent, "INActivateCarSignalIntentHandling")
        
        let result = INCarSignalOptionsResolutionResult.success(with: INCarSignalOptions.visible)
        completion(result)
    }
    
}

// MARK: - 添加任务, 添加一些注意事项
extension IntentHandler: INAddTasksIntentHandling {
    
    // MARK: - INAddTasksIntentHandling
    
    /// 对 siri 说, 'xxx(应用名)提醒我买狗粮'.  如果这里不加应用名称, 会直接加到系统app里面去
    /// resolveTargetTaskList ->
    
    func handle(intent: INAddTasksIntent, completion: @escaping (INAddTasksIntentResponse) -> Void) {
        print(#function, intent, "INAddTasksIntentHandling")
    }
    
    func confirm(intent: INAddTasksIntent, completion: @escaping (INAddTasksIntentResponse) -> Void) {
        print(#function, intent, "INAddTasksIntentHandling")
    }
    
    func resolveTargetTaskList(for intent: INAddTasksIntent, with completion: @escaping (INTaskListResolutionResult) -> Void) {
        print(#function, intent, "INAddTasksIntentHandling")
//        INTaskListResolutionResult.success(with: INTaskList)
    }
    
    
    func resolveTaskTitles(for intent: INAddTasksIntent, with completion: @escaping ([INSpeakableStringResolutionResult]) -> Void) {
        print(#function, intent, "INAddTasksIntentHandling")
        
        // intent.taskTitles 是系统识别出来, 要买的东西
        var resultArr = [INSpeakableStringResolutionResult]()
        for item in intent.taskTitles ?? [] {
            resultArr.append(INSpeakableStringResolutionResult.success(with: item))
        }
        
        completion(resultArr)
    }
    
    
    func resolveSpatialEventTrigger(for intent: INAddTasksIntent, with completion: @escaping (INSpatialEventTriggerResolutionResult) -> Void) {
        print(#function, intent, "INAddTasksIntentHandling")
    }
    
    
    func resolveTemporalEventTrigger(for intent: INAddTasksIntent, with completion: @escaping (INTemporalEventTriggerResolutionResult) -> Void) {
        print(#function, intent, "INAddTasksIntentHandling")
    }
    
}


// MARK: - 叫车, 打滴
extension IntentHandler: INRequestRideIntentHandling {
    
    // MARK: - INRequestRideIntentHandling
    
    /// 这个没发现走...会直接打开app而已
    /// 但是滴滴app那边就会询问...不知道除了什么差错
    
    func handle(intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
    
    func confirm(intent: INRequestRideIntent, completion: @escaping (INRequestRideIntentResponse) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
    
    func resolvePickupLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
    
    func resolveDropOffLocation(for intent: INRequestRideIntent, with completion: @escaping (INPlacemarkResolutionResult) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
    
    func resolveRideOptionName(for intent: INRequestRideIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
    
    func resolvePartySize(for intent: INRequestRideIntent, with completion: @escaping (INIntegerResolutionResult) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
    
    func resolveScheduledPickupTime(for intent: INRequestRideIntent, with completion: @escaping (INDateComponentsRangeResolutionResult) -> Void) {
        print(#function, intent, "INRequestRideIntentHandling")
    }
}


// MARK: - 获取二维码, 支付二维码, 名片二维码这些
extension IntentHandler: INGetVisualCodeIntentHandling {
    
    // MARK: - INGetVisualCodeIntentHandling
    
    func handle(intent: INGetVisualCodeIntent, completion: @escaping (INGetVisualCodeIntentResponse) -> Void) {
        print(#function, intent, "INGetVisualCodeIntentHandling")
    }
    
    func confirm(intent: INGetVisualCodeIntent, completion: @escaping (INGetVisualCodeIntentResponse) -> Void) {
        print(#function, intent, "INGetVisualCodeIntentHandling")
    }
    
    func resolveVisualCodeType(for intent: INGetVisualCodeIntent, with completion: @escaping (INVisualCodeTypeResolutionResult) -> Void) {
        print(#function, intent, "INGetVisualCodeIntentHandling")
    }
}



