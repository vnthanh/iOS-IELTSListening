//
//  LessonDetailViewController.swift
//  EnglishHub
//
//  Created by ThanhVo on 8/23/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class LessonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var lesson: LessonObject = LessonObject()
    
    var lessonConversationArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // transparent navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true

        // Do any additional setup after loading the view.
        lessonConversationArray = lesson.conversationArray
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        
        // Set view controller background image, proceed image to fit
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "main_bg_image")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessonConversationArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as! CustomTableViewCell
        
        cell.conversationLabel.text = lessonConversationArray[indexPath.row] as? String
        
        return cell
    }

}
