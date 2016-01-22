//
//  ViewController.swift
//  Instagram
//
//  Created by Majid Rahimi on 1/21/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import AFNetworking

//tableView.rowHeight = 320;
class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photos: [NSDictionary]?

    @IBOutlet weak var mainTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.rowHeight = 320
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.photos = responseDictionary["data"] as! [NSDictionary]
                            self.mainTable.reloadData()

                    }
                }
        });
        task.resume()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let photos = photos {
            return photos.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoCell

        let photo = photos![indexPath.row]
        let path = photo.valueForKeyPath("images.low_resolution.url") as! String
        let profile_picture = NSURL(string: path)
        
        cell.mainPicture.setImageWithURL(profile_picture!)
        return cell
    }
    
        
    }
    
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
//        
//        let movie = movies![indexPath.row]
//        let title = movie["title"] as! String
//        let overview = movie["overview"] as! String
//        let posterPath = movie["poster_path"] as! String
//        //        let review = movie["popularity"] as! String
//        
//        let baseUrl = "http://image.tmdb.org/t/p/w500"
//        let imageUrl = NSURL(string: baseUrl + posterPath)
//        
//        
//        cell.titleLabel.text = title
//        cell.overViewLabel.text = overview
//        cell.posterView.setImageWithURL(imageUrl!)
//        
//        
//        
//        print("row \(indexPath.row)")
//        return cell
//    }


