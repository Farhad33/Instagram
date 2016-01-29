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
class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var photos: [NSDictionary]?
    var isMoreDataLoading = false

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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = mainTable.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - mainTable.bounds.size.height 

            if(scrollView.contentOffset.y > scrollOffsetThreshold && mainTable.dragging) {
                isMoreDataLoading = true
                
            }
        }
    }
    
    func loadMoreData() {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (data, response, error) in
                
                // Update flag
                self.isMoreDataLoading = false
                
                // ... Use the new data to update the data source ...
                
                // Reload the tableView now that there is new data
                self.myTableView.reloadData()
        });
        task.resume()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! photoCell

        let photo = photos![indexPath.row]
        
        if let path = photo.valueForKeyPath("images.low_resolution.url") as? String {
            let profile_picture = NSURL(string: path)
            cell.mainPicture.setImageWithURL(profile_picture!)
        }
        
        return cell
    
//        let baseURL = “http://image.tmdb.org/t/p/w500”
//        if let posterPath = movie[“poster_path”] as? String {
//            let posterURL = NSURL(string: baseURL + posterPath)
//            cell.posterImageview.setImageWithURL(posterURL!)
//        }
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = mainTable.indexPathForCell(cell)
        let photo = photos![indexPath!.row]
        let vc = segue.destinationViewController as! PhotoDetailsViewController
        vc.photos = photo
        
//        let cell = sender as! UITableViewCell
//        var vc = segue.destinationViewController as! PhotoDetailsViewController
//        var indexPath = mainTable.indexPathForCell(cell)

        
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


