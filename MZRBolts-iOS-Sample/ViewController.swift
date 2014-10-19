//
//  ViewController.swift
//  MZRBolts-iOS-Sample
//
//  Copyright (c) 2014 molabo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PREPARE EMPTY TASK - FOR CONNECTING IN SERIES
        var task = BFTask(result: nil)
        
        // 1. ASYNCRONOUS CONNECTION TO YAHOO
        task = task.continueWithBlock({ (task: BFTask!) -> BFTask! in
            
            // INSTANTIATE TASK COMPLETION
            
            let taskCompletion = BFTaskCompletionSource()
            
            // ASYNCRONOUS CONNECTION
            
            let url = "http://yahoo.co.jp"
            let session = NSURLSession.sharedSession()
            let sessionTask = session.dataTaskWithURL(NSURL(string: url), completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if let err = error {
                    println("1 ERROR: YAHOO!")
                    taskCompletion.setError(err)
                }
                println("1 SUCCESS: YAHOO!")
                taskCompletion.setResult(data)
            })
            sessionTask.resume()
            
            // RETURN TASK COMPLETION
            
            return taskCompletion.task
        })
        
        // 2. ASYNCRONOUS CONNECTION TO GOOGLE
        task = task.continueWithBlock({ (task: BFTask!) -> BFTask! in
            
            // INSTANTIATE TASK COMPLETION
            
            let taskCompletion = BFTaskCompletionSource()
            
            // ASYNCRONOUS CONNECTION
            
            let url = "http://google.com"
            let session = NSURLSession.sharedSession()
            let sessionTask = session.dataTaskWithURL(NSURL(string: url), completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if let err = error {
                    println("2 ERROR: GOOGLE!")
                    taskCompletion.setError(err)
                }
                println("2 SUCCESS: GOOGLE!")
                taskCompletion.setResult(data)
            })
            sessionTask.resume()
            
            // RETURN TASK COMPLETION
            
            return taskCompletion.task
        })
    }
}

