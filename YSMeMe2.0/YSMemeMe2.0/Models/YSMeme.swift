//
//  YSMeme.swift
//  YSMeMe
//
//  Created by Youssef Eid on 05/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit


struct YSMeme {
    
    var topText: String
    var bottomText: String
    var orginalImage: UIImage
    var editorImage: UIImage
    
}


class YSMemeDatabase {
    
    var dataSources:[YSMeme] = []
    fileprivate static var sheradClass:YSMemeDatabase? = nil
    
    static func sheard() -> YSMemeDatabase {
        if let shared = YSMemeDatabase.sheradClass {
            return shared
        }
        sheradClass = YSMemeDatabase()
        return sheradClass!
    }
    
}
