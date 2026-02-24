//
//  TrailerVC.swift
//  MovieApp
//
//  Created by Ajai on 23/02/26.
//

import UIKit
import WebKit

class TrailerVC: UIViewController {
    private let key: String
    private var webView = WKWebView()
    
    init(key: String) {
        self.key = key
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(webView)
        
        webView.frame = view.bounds
        
        if let trailerURL = URL(string: Constants.trailerBaseURL+key) {
            webView.load(URLRequest(url: trailerURL))
        }
    }

}
