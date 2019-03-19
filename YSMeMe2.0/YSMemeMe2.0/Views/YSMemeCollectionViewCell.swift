//
//  YSMemeCollectionViewCell.swift
//  YSMeMe
//
//  Created by Youssef Eid on 06/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit

class YSMemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeText: UILabel!
    
    func setupMemeView(meme: YSMeme) {
        self.memeImageView.image = meme.editorImage
        self.memeText.text = meme.topText + " " + meme.bottomText
    }
    
}
