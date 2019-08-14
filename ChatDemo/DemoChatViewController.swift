//
//  DemoChatViewController.swift
//  ChatDemo
//
//  Created by Stream on 10/07/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChatCore
import StreamChat

class DemoChatViewController: ChatViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Set the general channel.
        let channel = Channel(id: "general", name: "General")
        channelPresenter = ChannelPresenter(channel: channel)
        
        // Update styles.
        style.incomingMessage.chatBackgroundColor = UIColor(hue: 0.2, saturation: 0.3, brightness: 1, alpha: 1)
        style.incomingMessage.backgroundColor = UIColor(hue: 0.6, saturation: 0.5, brightness: 1, alpha: 1)
        style.incomingMessage.borderWidth = 0
        
        style.outgoingMessage.chatBackgroundColor = style.incomingMessage.chatBackgroundColor
        style.outgoingMessage.backgroundColor = style.incomingMessage.chatBackgroundColor
        style.outgoingMessage.font = .systemFont(ofSize: 15, weight: .bold)
        style.outgoingMessage.cornerRadius = 0
        style.outgoingMessage.showCurrentUserAvatar = false
    }
}
