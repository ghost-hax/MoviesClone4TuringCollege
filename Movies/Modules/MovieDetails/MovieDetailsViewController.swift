//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by David on 04/02/2022.
//

import UIKit
import  Kingfisher

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var reviewsLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var viewModel:MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
 
        titleLbl.text = viewModel.movie.title
        descLbl.text = viewModel.movie.overView
        reviewsLbl.text = "\(viewModel.movie.reviews)"
        let url = URL(string:"\(EndPoint.imagesBaseUrl)\(viewModel.movie.poster)")
        posterImageView.kf.setImage(with: url)
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
