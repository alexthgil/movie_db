//
//  SearchViewController.swift
//  Cinema
//
//  Created by Alex on 9/29/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

protocol SearchBarViewControllerListener: class {
    func onTextDidChange(_ vc: SearchBarViewController, searchText: String)
    func searchBarCancelButtonClicked(_ vc: SearchBarViewController)
}

class SearchBarViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var searchBarView: UISearchBar?

    weak var delegate: SearchBarViewControllerListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView?.delegate = self

    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarView?.showsCancelButton = true
        delegate?.onTextDidChange(self, searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarView?.text = nil
        searchBarView?.showsCancelButton = false
        searchBarView?.endEditing(true)
        delegate?.searchBarCancelButtonClicked(self)
    }

}
