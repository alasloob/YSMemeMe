//
//  YSMemeTableViewController.swift
//  YSMeMe
//
//  Created by Youssef Eid on 05/07/1440 AH.
//  Copyright © 1440 Youssef Eid. All rights reserved.
//

import UIKit

class YSMemeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Meme"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YSMemeDatabase.sheard().dataSources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? YSMemeTableViewCell else {
            return UITableViewCell()
        }
        let meme = YSMemeDatabase.sheard().dataSources[indexPath.row]
        cell.setupMemeView(meme: meme)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nvShow = self.storyboard?.instantiateViewController(withIdentifier: "YSShowMeme") as? UINavigationController {
            if let show = nvShow.visibleViewController as? YSShowImageViewController {
                tableView.deselectRow(at: indexPath, animated: true)
                show.meme = YSMemeDatabase.sheard().dataSources[indexPath.row]
                self.present(nvShow, animated: true)
            }
        }
    }

}
