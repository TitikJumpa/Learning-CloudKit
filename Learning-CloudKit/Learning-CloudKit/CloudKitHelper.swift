//
//  CloudKitHelper.swift
//  SwiftUICloudKitDemo
//
//  Created by Alex Nagy on 23/09/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

// MARK: - notes
// good to read: https://www.hackingwithswift.com/read/33/overview
//
// important setup in CloudKit Dashboard:
//
// https://www.hackingwithswift.com/read/33/4/writing-to-icloud-with-cloudkit-ckrecord-and-ckasset
// https://www.hackingwithswift.com/read/33/5/a-hands-on-guide-to-the-cloudkit-dashboard
//
// On your device (or in the simulator) you should make sure you are logged into iCloud and have iCloud Drive enabled.

struct CloudKitHelper {
    
    // MARK: - record types
    struct RecordType {
        static let Items = "stories"
    }
    
    // MARK: - errors
    enum CloudKitHelperError: Error {
        case recordFailure
        case recordIDFailure
        case castFailure
        case cursorFailure
    }
    
    // MARK: - saving to CloudKit
    static func save( completion: @escaping (Result<Stories, Error>) -> ()) {
        let itemRecord = CKRecord(recordType: RecordType.Items)
        itemRecord["title"] = "test 123 dicoba" as CKRecordValue
        itemRecord["decription"] = "test 123 dicoba" as CKRecordValue
         //itemRecord["photo"] = UIImage() as CKRecordValue
        CKContainer(identifier: "iCloud.ihwan.id.container1").publicCloudDatabase.save(itemRecord) { (record, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
                guard let record = record else {
                    completion(.failure(CloudKitHelperError.recordFailure))
                    return
                }
                let recordID = record.recordID
                guard let text = record["title"] as? String else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                let listElement = Stories(recordID: recordID, title: "halo semuanya", description: "halo halo bandung", photo: UIImage() )
                completion(.success(listElement))
            }
        }
    }
    
    // MARK: - fetching from CloudKit
//    static func fetch(completion: @escaping (Result<Stories, Error>) -> ()) {
//        let pred = NSPredicate(value: true)
//        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
//        let query = CKQuery(recordType: RecordType.Items, predicate: pred)
//        query.sortDescriptors = [sort]
//
//        let operation = CKQueryOperation(query: query)
//        operation.desiredKeys = ["text"]
//        operation.resultsLimit = 50
//
//        operation.recordFetchedBlock = { record in
//            DispatchQueue.main.async {
//                let recordID = record.recordID
//                guard let text = record["title"] as? String else { return }
//                let listElement = Stories(recordID: recordID, title:  text)
//                completion(.success(listElement))
//            }
//        }
//
//        operation.queryCompletionBlock = { (/*cursor*/ _, err) in
//            DispatchQueue.main.async {
//                if let err = err {
//                    completion(.failure(err))
//                    return
//                }
////                guard let cursor = cursor else {
////                    completion(.failure(CloudKitHelperError.cursorFailure))
////                    return
////                }
////                print("Cursor: \(String(describing: cursor))")
//            }
//
//        }
//
//        CKContainer.default().publicCloudDatabase.add(operation)
//    }
    
//    // MARK: - delete from CloudKit
//    static func delete(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord.ID, Error>) -> ()) {
//        CKContainer.default().publicCloudDatabase.delete(withRecordID: recordID) { (recordID, err) in
//            DispatchQueue.main.async {
//                if let err = err {
//                    completion(.failure(err))
//                    return
//                }
//                guard let recordID = recordID else {
//                    completion(.failure(CloudKitHelperError.recordIDFailure))
//                    return
//                }
//                completion(.success(recordID))
//            }
//        }
//    }
//
//    // MARK: - modify in CloudKit
//    static func modify(item: Stories, completion: @escaping (Result<Stories, Error>) -> ()) {
//        guard let recordID = item.recordID else { return }
//        CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, err in
//            if let err = err {
//                DispatchQueue.main.async {
//                    completion(.failure(err))
//                }
//                return
//            }
//            guard let record = record else {
//                DispatchQueue.main.async {
//                    completion(.failure(CloudKitHelperError.recordFailure))
//                }
//                return
//            }
//            record["title"] = item.title as CKRecordValue
//
//            CKContainer.default().publicCloudDatabase.save(record) { (record, err) in
//                DispatchQueue.main.async {
//                    if let err = err {
//                        completion(.failure(err))
//                        return
//                    }
//                    guard let record = record else {
//                        completion(.failure(CloudKitHelperError.recordFailure))
//                        return
//                    }
//                    let recordID = record.recordID
//                    guard let text = record["title"] as? String else {
//                        completion(.failure(CloudKitHelperError.castFailure))
//                        return
//                    }
//                    let listElement = Stories(recordID: recordID, title: text)
//                    completion(.success(listElement))
//                }
//            }
//        }
//    }
}
