//
//  OptionListViewController.swift
//  
//
//  Created by Lennart Fischer on 01.04.22.
//

import Foundation

#if canImport(UIKit) && os(iOS)

import UIKit

public struct OptionListItem: Hashable, Equatable {
    
    public let text: String
    public let backgroundColor: UIColor
    public let image: UIImage?
    
    public init(
        text: String,
        backgroundColor: UIColor = .clear,
        image: UIImage? = nil
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.image = image
    }
    
}

public enum OptionListSection {
    
    case general
    
}

@available(iOS 14.0, *)
final public class OptionListViewController: UIViewController, UICollectionViewDelegate {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: buildCollectionViewLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var snapshot: NSDiffableDataSourceSnapshot<OptionListSection, OptionListItem>!
    private var dataSource: UICollectionViewDiffableDataSource<OptionListSection, OptionListItem>!
    
    // MARK: - UIViewController Lifecycle -
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createDataSource()
        self.setupUI()
        self.setupConstraints()
        
        let items = [
            OptionListItem(
                text: "Tickets",
                backgroundColor: .systemBlue,
                image: UIImage(systemName: "ticket")
            ),
            OptionListItem(
                text: "Festivaldorf",
                backgroundColor: .systemBlue,
                image: UIImage(systemName: "signpost.right")
            ),
            OptionListItem(
                text: "Volunteers",
                backgroundColor: .systemBlue,
                image: UIImage(systemName: "person.3")
            ),
        ]
        
        snapshot = NSDiffableDataSourceSnapshot<OptionListSection, OptionListItem>()
        snapshot.appendSections([.general])
        snapshot.appendItems(items, toSection: .general)
        
        // Display data in the collection view by applying the snapshot to data source
        dataSource.apply(snapshot, animatingDifferences: false)
        
    }
    
    // MARK: - UI -
    
    private func setupUI() {
        
//        self.view.backgroundColor = UIColor.systemRed
        self.view.addSubview(collectionView)
        
    }
    
    private func setupConstraints() {
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // MARK: - UICollectionView -
    
    private func buildCollectionViewLayout() -> UICollectionViewLayout {
        
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
    }
    
    private func optionItemCell() -> UICollectionView.CellRegistration<UICollectionViewListCell, OptionListItem> {
        return .init { cell, _, item in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = item.text
            configuration.image = item.image
            cell.contentConfiguration = configuration
        }
    }
    
    private func createDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<OptionListSection, OptionListItem>(
            collectionView: collectionView
        ) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: OptionListItem) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: self.optionItemCell(),
                for: indexPath,
                item: identifier
            )
            
            cell.accessories = [.disclosureIndicator()]
            
            return cell
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
}

#if DEBUG
import SwiftUI

@available(iOS 14.0, *)
extension OptionListViewController: UIViewControllerRepresentable {
    
    public func makeUIViewController(context: Context) -> OptionListViewController {
        OptionListViewController()
    }
    
    public func updateUIViewController(
        _ uiViewController: OptionListViewController,
        context: Context
    ) {
    }
    
}

struct OptionListViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        OptionListViewController()
    }
}

#endif

#endif
