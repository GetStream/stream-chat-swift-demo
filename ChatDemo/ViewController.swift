//
//  ViewController.swift
//  ChatDemo
//
//  Created by Stream on 10/07/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
// Add Stream Chat SDK.
import StreamChatClient
import StreamChatCore
import StreamChat

/// Use ChannelsViewController as the parent view controller.
class ViewController: ChannelsViewController {
    required init?(coder: NSCoder) {
        Client.configureShared(.init(apiKey: "m7cdet3kpfdu", logOptions: .info))
        
        let userExtraData = UserExtraData(name: "Square art")
        Client.shared.set(user: User(id: "square-art-0", extraData: userExtraData),
                          token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoic3F1YXJlLWFydC0wIn0.HDTQ8dDHSndescdgmi-T6Ta0yORvVD6sYLXB08CqZaM")
        
        super.init(coder: coder)
    }
    
    /// We override the inherited method for a channel cell.
    /// Here we can create absolutely new table view cell for the channel.
    override func channelCell(at indexPath: IndexPath, channelPresenter: ChannelPresenter) -> UITableViewCell {
        // For now, get the default channel cell.
        let cell = super.channelCell(at: indexPath, channelPresenter: channelPresenter)
        
        // We need to check if the returned cell is ChannelTableViewCell.
        guard let channelCell = cell as? ChannelTableViewCell else {
            return cell
        }
        
        // Check the number of unread messages.
        if channelPresenter.channel.unreadCount.messages > 0 {
            // Add the info about unread messages to the cell.
            channelCell.update(info: "\(channelPresenter.channel.unreadCount.messages) unread", isUnread: true)
        }
        
        return channelCell
    }
    
    override func createChatViewController(with channelPresenter: ChannelPresenter) -> ChatViewController {
        let chatViewController = DemoChatViewController()
        chatViewController.presenter = channelPresenter
        return chatViewController
    }
}
