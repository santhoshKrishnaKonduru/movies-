//
//  ViewController.swift
//  lenskartMovies
//
//  Created by Santhosh Konduru on 29/05/21.
//

import UIKit
import Kingfisher

struct Constents {
    static let baseULR = "http://image.tmdb.org/t/p/w92"
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var movieDetailsLabel: UILabel!
    
    
    var movies = [Movie]()
    var currentPage = 0
    
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    fileprivate var orientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 260, height: 260)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: MoviesCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        
        if let jsonData = readLocalFile(forName: "movies") {
            self.parse(json: jsonData)
            setLayoutComponents(movie: movies[currentPage])
        }
        
        title = "Movies"
        

    }
    
    func setLayoutComponents(movie: Movie) {
        titleLabel.text = movie.title
        movieDetailsLabel.text = movie.overview
        ratingLabel.text = "\(movie.vote_average ?? 0.0)"
        categoryLabel.text = "Language: \(movie.original_language ?? "")"
    }
    
    
}

// parse jason
extension ViewController {
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()

        do {
            movies = try decoder.decode([Movie].self, from: json)
        }catch {
            print(error)
        }

    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as! MoviesCollectionViewCell
        
        let movie = movies[indexPath.item]
        let poster_path = movie.poster_path
        let imageURLString = Constents.baseULR + "\(poster_path ?? "")"
        if let imageURL = URL(string: imageURLString) {
            let resource = ImageResource(downloadURL: imageURL, cacheKey: "\(imageURL)")
            cell.thumbNail.kf.setImage(with: resource)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        let movieDetailsVC = MovieDetailsViewController.instantiate(fromAppStoryboard: .Main)
        movieDetailsVC.movie = movie
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}

extension ViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        setLayoutComponents(movie: movies[currentPage])
    }
}

