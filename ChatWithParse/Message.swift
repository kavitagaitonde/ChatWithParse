//
//  Message.swift
//  ChatWithParse
//
//  Created by Kavita Gaitonde on 9/27/17.
//  Copyright © 2017 Kavita Gaitonde. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {

    @NSManaged var text: String?
    @NSManaged var user: PFUser?

    // returns the Parse name that should be used
    class func parseClassName() -> String {
        return "Message"
    }}
