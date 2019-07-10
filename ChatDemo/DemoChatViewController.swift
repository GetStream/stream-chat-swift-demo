//
//  DemoChatViewController.swift
//  ChatDemo
//
//  Created by Stream on 10/07/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import StreamChat

class DemoChatViewController: ChatViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup the general channel for the chat.
        let channel = Channel(id: "general", name: "General")
        channelPresenter = ChannelPresenter(channel: channel)
    }
    
    /// Override the default implementation of UI messages
    /// with default UIKit table view cell.
    override func messageCell(at indexPath: IndexPath, message: Message,    readUsers: [User]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "message")
            ?? UITableViewCell(style: .value2, reuseIdentifier: "message")
        
        cell.textLabel?.text = message.user.name
        cell.textLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        cell.detailTextLabel?.text = message.text
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}
