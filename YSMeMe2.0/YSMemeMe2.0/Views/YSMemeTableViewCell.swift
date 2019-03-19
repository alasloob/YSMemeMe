//
//  YSMemeTableViewCell.swift
//  YSMeMe
//
//  Created by Youssef Eid on 05/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit

class YSMemeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    @IBOutlet weak var memText: UILabel!
    
    func setupMemeView(meme: YSMeme) {
        self.memeImageView.image = meme.editorImage
        self.memText.text = meme.topText + " " + meme.bottomText
    }
    
}
