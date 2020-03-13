//
//  ImagesViewController.swift
//  PictureSaver
//
//  Created by Frederik Søndergaard Jensen on 13/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import Firebase

let storage = Storage.storage(url:"gs://picturesaver-f6310.appspot.com/")
let pathReference = storage.reference(withPath: "images/")
private let reuseIdentifier = "imageCell"
var imageArray = [UIImage]()


class ImagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageTableView: UITableView!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTableView.delegate = self
        imageTableView.dataSource = self
        getAllImages()
        // Do any additional setup after loading the view.
    }
    
    //Get all images from google storage
    func getAllImages() {
        pathReference.listAll { (result, error) in
          if let error = error {
            print(error)
          }
          for prefix in result.prefixes {
            print(prefix)
          }
          for item in result.items {
            // The items under storageReference.

            self.downloadImages(path: "\(item)")
          }
        }
    }
    
    //Download images to memory
    func downloadImages(path: String) {
        print(path)
        imageArray = [UIImage]()
        let gsReference = storage.reference(forURL: path)
        // Create a reference to the file you want to download

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print(error)
            
          } else {
            // Data for "images/island.jpg" is returned
            let image = UIImage(data: data!)
            imageArray.append(image!)
            self.imageTableView.reloadData()
          }
        }
        
    }
    
    // MARK: TABLEVIEW
    
    
    // Number of cells in tableview.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    // Populate each cell in the tableview.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.imageView?.image = imageArray[indexPath.row]
        return cell!
    }
}
