//
//  RootViewController.swift
//  AtlysAssignment
//
//  Created by Aman Gupta on 23/08/24.
//

import UIKit

class RootViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        setupScrollView()
        setupImages()
        setupPagingControl()
        
    }
    
    private func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 250),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 250),
            
        ])
    }
    
    private func setupPagingControl(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: 8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        
    }
    
    private func setupImages(){
        let images = ["image1","image2","image3"]
        let imageViews = images.map{ name -> UIImageView in
            let imageView = UIImageView(image:UIImage(named: name))
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 15
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        
        }
        
        let stackView = UIStackView(arrangedSubviews: imageViews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: CGFloat(images.count)),
        ])
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.frame.size.width / 2 + scrollView.contentOffset.x
        
        for imageView in scrollView.subviews[0].subviews {
            guard let imageView = imageView as?  UIImageView else { continue }
            
            let imageCenterX = imageView.frame.midX
            let distance = abs(centerX - imageCenterX)
            let scale = max(1 - (distance / scrollView.frame.size.width), 0.75)
            
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
        }
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }

}
