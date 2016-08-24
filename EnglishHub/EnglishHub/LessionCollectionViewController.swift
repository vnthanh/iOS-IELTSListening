//
//  LessionCollectionViewController.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class LessionCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var levelId: String = ""
    let levelParser: LevelParser = LevelParser()
    var dataArray: NSMutableArray = NSMutableArray()
    
    // to mark which lesson is selected -> push segue
    var lesson: Int = 0
    
    // handle NSUserDefault
    var seenLessonArray: NSMutableArray? // array of seen lesson (index)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show navigationbar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // transparent navigationbar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true

        print(levelId)
        dataArray = levelParser.getLessonList(levelId)
        
//        let flow: UICollectionViewFlowLayout = self.collectionView as! UICollectionViewFlowLayout
//        flow.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        
        // Set view controller background image, proceed image to fit
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "main_bg_image")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        // set nav bar title for each level
        if levelId == "1" {
            self.navigationItem.title = "BASIC LEVEL"
        } else if levelId == "2" {
            self.navigationItem.title = "INTERMEDIATE LEVEL"
        } else {
            self.navigationItem.title = "ADVANCED LEVEL"
        }
        
        // load seen lesson array (nsuserdefaults)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // check each level
        if levelId == "1" {
            seenLessonArray = defaults.objectForKey("seenLessonArrayLevel1")?.mutableCopy() as? NSMutableArray
        } else if levelId == "2" {
            seenLessonArray = defaults.objectForKey("seenLessonArrayLevel2")?.mutableCopy() as? NSMutableArray
        }
        else {
            seenLessonArray = defaults.objectForKey("seenLessonArrayLevel3")?.mutableCopy() as? NSMutableArray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
    
        // Check from NSUserDefault to display different image for each lesson user has seen
        if seenLessonArray != nil && seenLessonArray!.containsObject(indexPath.row) {
            cell.lessonImageView.image = UIImage(named: "lesson_\(indexPath.row+1)_tap")
        } else {
            // Configure the cell
            cell.lessonImageView.image = UIImage(named: "lesson_\(indexPath.row+1)")
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let size = CGSize(width: (screenWidth / 3 - 20), height: screenWidth / 10)
        
        return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        lesson = indexPath.row
        performSegueWithIdentifier("pushLessonDetail", sender: self)
        
        // Save, add to nsuserdefault (array)
        if seenLessonArray != nil {
            if seenLessonArray!.containsObject(indexPath.row) {
                return
            }
            self.seenLessonArray!.addObject(indexPath.row)
        } else {
            self.seenLessonArray = NSMutableArray()
            self.seenLessonArray!.addObject(indexPath.row)
        }
        
        // call nsuserdefault ref
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // check each level
        if levelId == "1" {
            defaults.setObject(self.seenLessonArray, forKey: "seenLessonArrayLevel1")
        } else if levelId == "2" {
            defaults.setObject(self.seenLessonArray, forKey: "seenLessonArrayLevel2")
        }
        else {
            defaults.setObject(self.seenLessonArray, forKey: "seenLessonArrayLevel3")
        }

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pushLessonDetail" {
            let vc = segue.destinationViewController as! LessonDetailViewController
            
            vc.lesson = self.dataArray[lesson] as! LessonObject
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.collectionView.reloadData()
    }
}
