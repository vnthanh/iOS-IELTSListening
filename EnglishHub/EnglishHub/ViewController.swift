//
//  ViewController.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var levelId: String = ""
    
    @IBAction func basicLevelButtonDidTouch(sender: AnyObject) {
        self.levelId = "1"
        performSegueWithIdentifier("pushLessonList", sender: self)
    }
    
    
    @IBAction func intermediateLevelButtonDidTouch(sender: AnyObject) {
        self.levelId = "2"
        performSegueWithIdentifier("pushLessonList", sender: self)
    }
    
    @IBAction func advancedLevelButtonDidTouch(sender: AnyObject) {
        self.levelId = "3"
        performSegueWithIdentifier("pushLessonList", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pushLessonList" {
            let vc = segue.destinationViewController as! LessionCollectionViewController
            
            vc.levelId = self.levelId
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    override func viewWillAppear(animated: Bool) {
        // hide navigationbar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
}

