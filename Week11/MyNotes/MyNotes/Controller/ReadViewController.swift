//
//  ReadViewController.swift
//  MyNotes
//
//  Created by Frederik Søndergaard Jensen on 16/03/2020.
//  Copyright © 2020 Frederik Søndergaard Jensen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

let storage = Storage.storage(url:"gs://mynotes-4136d.appspot.com/")
let pathReference = storage.reference(withPath: "images/")

class ReadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var noteTableView: UITableView!
    var noteArray = [NoteModel]()
    var imageArray: NSMutableDictionary = [:]
    
    var db: Firestore!
    var usr: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
        noteTableView.register(UINib(nibName: "NoteCellImage", bundle: nil), forCellReuseIdentifier: "NoteCellImage")
        noteTableView.register(UINib(nibName: "NoteCellNoImage", bundle: nil), forCellReuseIdentifier: "NoteCellNoImage")
        // Do any additional setup after loading the view.
        
        // Firebase auth stuff.
        usr = Auth.auth().currentUser
        db = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
        getAllImages()
        
    }
    
    func loadNotes() {
        DispatchQueue.global().async {
            self.noteArray = [NoteModel]()
            self.db.collection("users").document(self.usr.uid).collection("notes").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        let currentNote = NoteModel(title: document.data()["title"] as! String, body: document.data()["text"] as! String, imageName: document.data()["image"] as! String, time: document.data()["date"] as! NSNumber)
                        self.noteArray.append(currentNote)
                    }
                    
                    self.noteTableView.reloadData()
                }
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Sorting the notes after time posted.
        noteArray = noteArray.sorted { Int(truncating: $1.time) < Int(truncating: $0.time) }
        let note = noteArray[indexPath.row]
        
        
        if let img = imageArray.value(forKey: note.imageName) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellImage", for: indexPath) as! NoteCellImage
            cell.noteImage.image = (img as! UIImage)
            cell.noteTitle.text = note.title
            cell.noteText.text = note.body
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCellNoImage", for: indexPath) as! NoteCellNoImage
            cell.noteTitle.text = note.title
            cell.noteText.text = note.body
            return cell
        }
        
        
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
                
                self.downloadImages(path: "\(item)", name: "\(item.name)")
            }
        }
    }
    
    //Download images to memory
    func downloadImages(path: String, name: String) {
        print(path)
        imageArray = [:]
        let gsReference = storage.reference(forURL: path)
        // Create a reference to the file you want to download
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        gsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
                
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.imageArray[name] = image
                
                self.noteTableView.reloadData()
            }
        }
        
    }
}

