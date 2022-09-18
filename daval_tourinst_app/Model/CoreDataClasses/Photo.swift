//
//  Photo.swift
//  daval_tourinst_app
//
//  Created by Daniel Felipe Valencia Rodriguez on 18/09/22.
//

import Foundation
import CoreData
import UIKit

@objc(Photo)
public class Photo: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate = Date()
        self.id = UUID()
    }
}
