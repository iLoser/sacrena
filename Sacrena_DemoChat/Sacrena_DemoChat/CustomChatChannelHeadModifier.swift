//
//  CustomChatChannelHeadModifier.swift
//  Sacrena_DemoChat
//
//  Created by Chermadurai Anandakumar on 15/09/24.
//

import Foundation
import SwiftUI
import StreamChat
import StreamChatSwiftUI


struct CustomChatChannelHeaderModifier: ChatChannelHeaderViewModifier {
    let channel: ChatChannel
    @ObservedObject private var channelHeaderLoader = InjectedValues[\.utils].channelHeaderLoader
    @State private var isActive: Bool = false
    
    func body(content: Content) -> some View {
        content.toolbar {
            CustomChatChannelHeader(channel: channel, avatar: channelHeaderLoader.image(for: channel))
        }
        .navigationBarBackButtonHidden(true)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity)
    }
}

struct CustomChatChannelHeader: ToolbarContent {

  @Injected(\.fonts) var fonts
  @Injected(\.images) var images
  @Injected(\.utils) private var utils
  @Injected(\.chatClient) private var chatClient
  @Environment(\.presentationMode) var presentationMode

  public var channel: ChatChannel
  let avatar: UIImage

  private var onlineIndicatorShown: Bool {
    !channel.lastActiveMembers.filter { member in
      member.id != chatClient.currentUserId && member.isOnline
    }
    .isEmpty
  }

  var body: some ToolbarContent {
      // Back button and avatar on the left
      ToolbarItem(placement: .topBarLeading) {
        ZStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                        Image(uiImage: avatar)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .padding(.vertical, 10)
                            .padding(.leading, 5)
                            .overlay(
                                onlineIndicatorShown ? Circle().fill(Color.green).frame(width: 10, height: 10).offset(x: -16, y: 12) : nil
                            )
                        Text(utils.channelNamer(channel, chatClient.currentUserId) ?? "User Name")
                            .font(fonts.bodyBold)
                            .accessibilityIdentifier("chatName")
                            .font(.headline)
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5) // Allow text to shrink on longer names
                            .lineLimit(1) // Limit text to a single line
                            .padding(.horizontal, 10) // Adjust padding if needed
                    }
                }
                // Three circles on the right (optional, adjust if needed)
                HStack(spacing: 4) {
                    SimpleCircleView()
                    SimpleCircleView()
                    SimpleCircleView()
                }
                .padding()
                .foregroundColor(.white)
            }
        }
        .background(Color(hex: "#272727"))
      }
    }
}
