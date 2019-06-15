//
//  ViewController.swift
//  ContactsApp
//
//  Created by Sudipta Sahoo on 10/06/19.
//  Copyright © 2019 Sudipta Sahoo. All rights reserved.
//

import UIKit
import Networking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //
        Networking.shared.request(TestEndPoint.validEndPoint) { (result: Result<[Contact], Error>) in
            switch result{
            case .success(let decodedObj):
                print(decodedObj)
            case .failure(let error):
                print(error)
            }
        }
    }
}

