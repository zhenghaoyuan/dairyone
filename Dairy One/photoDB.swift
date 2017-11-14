//
//  photoDB.swift
//  Dairy One
//
//  Created by 郑 on 2017/11/12.
//  Copyright © 2017年 haoyuan. All rights reserved.
//

import UIKit
import Foundation

let photoDBChangeNotification = "PHOTO_DB_CHANGED"

class photoDB {
	static var sharedInstance = photoDB();
	
	var photo : [UIImage?] = [] {
		didSet {
			NotificationCenter.default.post(name: Notification.Name(photoDBChangeNotification), object: self)
		}
	}
	// This is a kind of compromise because I don't know how to rotate the video from output source,
	// So I have to rotate in imageview. And to prevent the multiple rotation, I want it is done only once
	var rotation :[Bool?] = []

}
