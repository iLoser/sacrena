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
        let bobUserId = "Bob"
        let token: Token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiQWxpY2VfOWZlZWZlMzItN2ZkZC00ZWM2LWI4ZGItZmMyOTA0MzIyOTA2In0.vTPO2I_C04V8U_1m5pK-m50hVvo7IgdAeXBvy8MmsSQ"
        let config = ChatClientConfig(apiKey: .init("xsfeyu47rftn"))
        ChatClient.shared = ChatClient(config: config)
        
        var colors = ColorPalette()
        var fonts = Fonts()
        
        colors.background = UIColor(Color(hex: "#272727"))
        colors.messageCurrentUserBackground = [UIColor(Color(hex: "#cdff3a"))]
        colors.messageOtherUserBackground = [UIColor(Color(hex: "#ffffff"))]
        colors.messageCurrentUserTextColor = UIColor(Color.black)
        colors.messageOtherUserTextColor = UIColor(Color(hex: "#2b2d28"))
        
        fonts.body = Font.subheadline

        let appearance = Appearance(colors: colors, fonts: fonts)
        
        streamChat = StreamChat(chatClient: ChatClient.shared, appearance: appearance)
        ChatClient.shared.connectUser(
            userInfo: UserInfo(id: userId),
            token: token
        ) { result in
            do {
                let channelController = try ChatClient.shared.channelController(
                    createDirectMessageChannelWith: [userId, bobUserId], extraData: [:]
                )
                channelController.synchronize { error in
                    if let error = error {
                        print("Failed to create channel: \(error)")
                    } else {
                        print("Direct message channel created or found")
                    }
                }
            } catch {
                print("Error creating channel: \(error)")
            }
        }
    }
    
}

