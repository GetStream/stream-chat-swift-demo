//
//  ViewController.swift
//  ChatDemo
//
//  Created by Stream on 10/07/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
// Add Stream Chat SDK.
import StreamChat

/// Use ChannelsViewController as the parent view controller.
class ViewController: ChannelsViewController {
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
        if channelPresenter.unreadCount > 0 {
            // Add the info about unread messages to the cell.
            channelCell.update(info: "\(channelPresenter.unreadCount) unread", isUnread: true)
        }
        
        return channelCell
    }
}
