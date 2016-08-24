//
//  LessionCollectionViewController.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class LessionCollectionViewController: UICollectionViewController {

    var levelId: String = ""
    let levelParser: LevelParser = LevelParser()
    var dataArray: NSMutableArray = NSMutableArray()
    
    // to mark which lesson is selected -> push segue
    var lesson: Int = 0
    
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
        
        let flow: UICollectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        
        // Set view controller background image, proceed image to fit
        UIGraphicsBeginImageContext(self.collectionView!.frame.size)
        UIImage(named: "main_bg_image")?.drawInRect(self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.collectionView!.backgroundColor = UIColor(patternImage: image)
        
        // set nav bar title for each level
        if levelId == "1" {
            self.navigationItem.title = "BASIC LEVEL"
        } else if levelId == "2" {
            self.navigationItem.title = "INTERMEDIATE LEVEL"
        } else {
            self.navigationItem.title = "ADVANCED LEVEL"
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

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
    
        // Configure the cell
        cell.lessonImageView.image = UIImage(named: "lesson_\(indexPath.row+1)")
    
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let size = CGSize(width: (screenWidth / 3 - 20), height: screenWidth / 10)
        
        return size
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        lesson = indexPath.row
        performSegueWithIdentifier("pushLessonDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pushLessonDetail" {
            let vc = segue.destinationViewController as! LessonDetailViewController
            
            vc.lesson = self.dataArray[lesson] as! LessonObject
         
        }
    }

}
