//
//  Stories.swift
//  Learning-CloudKit
//
//  Created by Ihwan ID on 02/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//
import SwiftUI
import CloudKit

struct Stories: Identifiable {
    var id = UUID()
    var recordID: CKRecord.ID?
    var title: String
    var description: String
    var photo: UIImage
    
}
