//
//  YSShowImageViewController.swift
//  YSMeMe
//
//  Created by Youssef Eid on 06/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit

class YSShowImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lbText: UILabel!
    
    var meme: YSMeme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let me = self.meme {
            self.imageView.image = me.editorImage
            self.lbText.text = me.topText + " " + me.bottomText
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

}
