/*
* Copyright (c) 2015 Razeware LLC
*
*/

import Foundation
import CoreData

class Location: NSManagedObject {

    @NSManaged var timestamp: Date
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var run: NSManagedObject

}
