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
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil;
    
    var items = Array(0..<99)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = configureLayout()
        collectionView.delegate = self
        
        setupData()
        
    }

    func setupData() {
        
        // Setup datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as UICollectionViewCell
            
            guard let cellLabel = cell.viewWithTag(1000) as? UILabel else {
                fatalError("Can't access label")
            }
            
            cellLabel.text = "Cell \(identifier)"
            
            return cell;
            
        })
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
        
    }
    
    func configureLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        //section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }

}

extension ViewController {
    
    @IBAction func didTapOddButton(sender: UIButton) {
        print("didTapOddButton")
        
        let filteredItems = items.filter { (element) -> Bool in
            element % 2 != 0
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    @IBAction func didTapEvenButton(sender: UIButton) {
        print("didTapOddButton")
        
        let filteredItems = items.filter { (element) -> Bool in
            element % 2 == 0
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)    }

    @IBAction func didTapAllButton(sender: UIButton) {
        print("didTapAllButton")

        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected \(indexPath.row)")
    }
    
}

