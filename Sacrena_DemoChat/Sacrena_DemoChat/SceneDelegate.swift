//
//  SceneDelegate.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 14/09/24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatSwiftUI

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var streamChat: StreamChat?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let userId = "Alice_9feefe32-7fdd-4ec6-b8db-fc2904322906"
        let token: Token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiQWxpY2VfOWZlZWZlMzItN2ZkZC00ZWM2LWI4ZGItZmMyOTA0MzIyOTA2In0.vTPO2I_C04V8U_1m5pK-m50hVvo7IgdAeXBvy8MmsSQ"
        let config = ChatClientConfig(apiKey: .init("xsfeyu47rftn"))
        ChatClient.shared = ChatClient(config: config)
        streamChat = StreamChat(chatClient: ChatClient.shared)
        ChatClient.shared.connectUser(
            userInfo: UserInfo(id: userId),
            token: token,
            completion: { _ in
            print("All ok")
        })
    }
    
}
