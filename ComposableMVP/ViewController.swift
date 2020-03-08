//
//  ViewController.swift
//  ComposableMVP
//
//  Created by Tim Duckett on 05.03.20.
//  Copyright © 2020 tim@duckett.de. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    let items = Array(0..<99)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        
        configureCollectionView()
        
        updateData(items: items, withAnimation: false)
        
    }

}

extension ViewController {
    
    func configureLayout() {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        collectionView.collectionViewLayout = layout
        
    }
    
    func configureCollectionView() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as UICollectionViewCell
            
            guard let cellLabel = cell.viewWithTag(1000) as? UILabel else {
                fatalError("Can't access label")
            }
            
            cellLabel.text = "Cell \(identifier)"
            
            return cell
            
        })
        
    }
    
    func updateData(items: Array<Int>, withAnimation: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: withAnimation, completion: nil)
    }
    
    @IBAction func didTapOddButton(sender: UIButton) {
        let filteredItems = items.filter { (element) -> Bool in
            element % 2 != 0
        }
        updateData(items: filteredItems, withAnimation: true)
    }
    
    @IBAction func didTapEvenButton(sender: UIButton) {
        let filteredItems = items.filter { (element) -> Bool in
            element % 2 == 0
        }
        updateData(items: filteredItems, withAnimation: true)
    }
    
    @IBAction func didTapAllButton(sender: UIButton) {
        updateData(items: items, withAnimation: true)
    }
    
}


