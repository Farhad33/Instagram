//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Majid Rahimi on 1/28/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var photos: NSDictionary!

    @IBOutlet weak var largeImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
//        let photo = photos![indexPath.row]
//        let url = photos["]
//        let path = photos["images.thumbnail.url"] as! String
//        let profile_picture = NSURL(string: path)
//        largeImage.setImageWithURL(profile_picture!)
        if let path = photos.valueForKeyPath("images.low_resolution.url") as? String {
            let profile_picture = NSURL(string: path)
            largeImage.setImageWithURL(profile_picture!)
        }
//        let baseURL = “http://image.tmdb.org/t/p/w500”
//        if let posterPath = movie[“poster_path”] as? String {
//            let posterURL = NSURL(string: baseURL + posterPath)
//            cell.posterImageview.setImageWithURL(posterURL!)
        }

        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
