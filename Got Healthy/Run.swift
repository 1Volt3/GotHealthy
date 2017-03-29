/*
* Copyright (c) 2015 Razeware LLC
*
*/

import Foundation
import CoreData

class Run: NSManagedObject {

    @NSManaged var duration: NSNumber
    @NSManaged var distance: NSNumber
    @NSManaged var timestamp: Date
    @NSManaged var locations: NSOrderedSet

}
