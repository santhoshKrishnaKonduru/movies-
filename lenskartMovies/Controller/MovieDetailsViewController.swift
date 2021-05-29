//
//  MovieDetailsViewController.swift
//  lenskartMovies
//
//  Created by Santhosh Konduru on 29/05/21.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var movie: Movie! // message passing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let poster_path = movie.poster_path
        let imageURLString = Constents.baseULR + "\(poster_path ?? "")"
        if let imageURL = URL(string: imageURLString) {
            let resource = ImageResource(downloadURL: imageURL, cacheKey: "\(imageURL)")
            imageView.kf.setImage(with: resource)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
