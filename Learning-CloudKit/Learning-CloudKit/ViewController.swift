//
//  ViewController.swift
//  Learning-CloudKit
//
//  Created by Ihwan ID on 02/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CloudKitHelper.save() { (result) in
            switch result {
            case .success(let newItem):
                
                print("Successfully added item")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }


}

