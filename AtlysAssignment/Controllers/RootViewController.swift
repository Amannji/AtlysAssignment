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
    
    var imageCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupScrollView()
        setupImages()
        setupPagingControl()
        
    }
    override func viewDidLayoutSubviews() {
        let middleOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        scrollView.setContentOffset(middleOffset, animated: false)
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
            scrollView.heightAnchor.constraint(lessThanOrEqualToConstant: 250),
            
        ])
    }
    
    private func setupPagingControl(){
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        
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
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 15
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                   imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
               ])
            
            return imageView
        
        }
        
        imageCount = imageViews.count
        
        
        let leftSpacer = UIView()
        let rightSpacer = UIView()
        leftSpacer.translatesAutoresizingMaskIntoConstraints = false
        rightSpacer.translatesAutoresizingMaskIntoConstraints = false
        
        
        leftSpacer.backgroundColor = .clear
        rightSpacer.backgroundColor = .clear
        
        let stackView = UIStackView(arrangedSubviews:[leftSpacer]+imageViews+[rightSpacer])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = -60
        stackView.isLayoutMarginsRelativeArrangement = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo:scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,multiplier: CGFloat(imageCount)),
            
            rightSpacer.widthAnchor.constraint(equalTo: leftSpacer.widthAnchor)
            
        ])
        
 
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    
        let contentWidth = scrollView.frame.size.width * CGFloat(imageCount)
        let maxOffset = contentWidth - 1.5*scrollView.frame.size.width
        let minOffset: CGFloat = 190
        
           
           var clampedOffset = scrollView.contentOffset.x
           if clampedOffset < minOffset {
               clampedOffset = minOffset
           } else if clampedOffset > maxOffset {
               clampedOffset = maxOffset
           }
        
        UIView.animate(withDuration: 0.4) {
                scrollView.contentOffset.x = clampedOffset
            }
        
        let centerX = scrollView.frame.size.width / 2 + scrollView.contentOffset.x
        
        
        
        for imageView in scrollView.subviews[0].subviews {
            guard let imageView = imageView as?  UIImageView else { continue }
            
            let imageCenterX = imageView.frame.midX
            let distance = abs(centerX - imageCenterX)
            let scale = max(1 - (distance / scrollView.frame.size.width), 0.75)
            
            imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            imageView.layer.zPosition = 1 - (distance / scrollView.frame.size.width)
            
        }
        let pageIndex = round(scrollView.contentOffset.x / (scrollView.frame.width))
            pageControl.currentPage = Int(pageIndex)
        }

}





