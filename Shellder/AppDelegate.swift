//
//  AppDelegate.swift
//  Shellder
//
//  Created by Robert Demuth on 10/20/15.
//  Copyright © 2015 CS 4720. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func createActivity(id: Int, title: String, latitude :Float, longitude: Float) -> Bool {
        
        let activity = NSEntityDescription.insertNewObjectForEntityForName("Activity", inManagedObjectContext: managedObjectContext) as? Activity
        
        activity!.id = id
        activity!.title = title
        activity!.latitude = latitude
        activity!.longitude = longitude
        activity!.photo = nil
        activity!.complete = false
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError{
            print("Failed to save the new activity. Error = \(error)")
        }
        
        return false
        
    }
    
    func preloadData() {
        createActivity(1, title: "Nab the #1 ticket at Bodo's", latitude: 38.035713, longitude: -78.500913)
        createActivity(2, title: "Sing the Good Ole Song", latitude: 0, longitude: 0)
        createActivity(3, title: "Attend Rotunda Sing", latitude: 38.035647, longitude: -78.503372)
        createActivity(4, title: "High-five Dean Groves", latitude: 0, longitude: 0)
        createActivity(5, title: "Make a Class Gift", latitude: 0, longitude: 0)
        createActivity(6, title: "Paint Beta Bridge", latitude: 38.039558, longitude: -78.501814)
        createActivity(7, title: "Chow down on late night food on the Corner", latitude: 38.034944, longitude: -78.500517)
        createActivity(8, title: "Tailgate a football game", latitude: 0, longitude: 0)
        createActivity(9, title: "Eat at Pancakes for Parkinson's", latitude: 38.033330, longitude: -78.504653)
        createActivity(10, title: "Check out a book from a library", latitude: 0, longitude: 0)
        createActivity(11, title: "Dress up in ties and pearls", latitude: 38.031109, longitude: -78.513723)
        createActivity(12, title: "Tube down the James River", latitude: 0, longitude: 0)
        createActivity(13, title: "See the Jefferson Statue in it's new home", latitude: 38.036124, longitude: -78.505804)
        createActivity(14, title: "Relive O'Hill brunch (Yum!!!)", latitude: 38.034834, longitude: -78.515074)
        createActivity(15, title: "Stroll around the Farmer's market downtown", latitude: 38.029592, longitude: -78.481688)
        createActivity(16, title: "Eat at a food truck", latitude: 38.034068, longitude: -78.506104)
        createActivity(17, title: "Attend Tom Tom Festival", latitude: 38.029930, longitude: -78.478743)
        createActivity(18, title: "Order food to Clemons", latitude: 38.036350, longitude: -78.506086)
        createActivity(19, title: "Cheer on the baseball team at Davenport", latitude: 38.045928, longitude: -78.513427)
        createActivity(20, title: "Take a historical tour of U.Va.", latitude: 0, longitude: 0)
        createActivity(21, title: "Get lunch at Bellair Market", latitude: 38.050641, longitude: -78.527746)
        createActivity(22, title: "Watch an improv show", latitude: 0, longitude: 0)
        createActivity(23, title: "Carve a pumpkin at Puppies and Pumpkins", latitude: 38.033517, longitude: -78.505837)
        createActivity(24, title: "Attend a concert on the Downtown Mall", latitude: 38.029930, longitude: -78.478743)
        createActivity(25, title: "Watch the sunrise from Humpback Mountain or Old Rag", latitude: 0, longitude: 0)
        createActivity(26, title: "Sign up for an Alumni Membership", latitude: 38.038148, longitude: -78.507920)
        createActivity(27, title: "Hug Ms. Kathy in Newcomb", latitude: 38.035782, longitude: -78.506677)
        createActivity(28, title: "Visit Monticello", latitude: 38.008575, longitude: -78.453232)
        createActivity(29, title: "Attend a class you are not enrolled in", latitude: 0, longitude: 0)
        createActivity(30, title: "Pick apples at Carter's Mountain", latitude: 37.991660, longitude: -78.471458)
        createActivity(31, title: "Check out the Declaration of Independence in Special Collections", latitude: 38.036124, longitude: -78.505804)
        createActivity(32, title: "Trek to a Charlottesville brewery or vineyard", latitude: 0, longitude: 0)
        createActivity(33, title: "Jam at Fridays After Five", latitude: 38.029930, longitude: -78.478743)
        createActivity(34, title: "Attend a themed party or date function", latitude: 0, longitude: 0)
        createActivity(35, title: "Complete the Dining Hall Marathon - 3 Dining Halls, 1 Day", latitude: 0, longitude: 0)
        createActivity(36, title: "Volunteer through Madison House", latitude: 38.038941, longitude: -78.501868)
        createActivity(37, title: "Celebrate Lighting of the Lawn", latitude: 38.035647, longitude: -78.503372)
        createActivity(38, title: "Go on a real date", latitude: 0, longitude: 0)
        createActivity(39, title: "Visit Carr's Hill", latitude: 38.037977, longitude: -78.503856)
        createActivity(40, title: "Ice skate Downtown", latitude: 38.030789, longitude: -78.483247)
        createActivity(41, title: "Attend the Virginia Film Festival", latitude: 0, longitude: 0)
        createActivity(42, title: "Write on the Freedom Wall Downtown", latitude: 38.029552, longitude: -78.477581)
        createActivity(43, title: "Get swole at all four gyms", latitude: 0, longitude: 0)
        createActivity(44, title: "Experience a performance in Old Cabell Hall", latitude: 38.032903, longitude: -78.504860)
        createActivity(45, title: "Make a home cooked meal", latitude: 0, longitude: 0)
        createActivity(46, title: "Enjoy a picnic on The Lawn", latitude: 38.034196, longitude: -78.504170)
        createActivity(47, title: "Compete in an Intramural Sport", latitude: 0, longitude: 0)
        createActivity(48, title: "Take a picture in front of the 'I Love Charlottesville Sign' in Belmont", latitude: 38.025095, longitude: -78.475765)
        createActivity(49, title: "Get spooked at Brown College Haunting", latitude: 38.034718, longitude: -78.507690)
        createActivity(50, title: "Attend Trick or Treating on The Lawn", latitude: 38.034196, longitude: -78.504170)
        createActivity(51, title: "Run the 4th Year 5K", latitude: 0, longitude: 0)
        createActivity(52, title: "Attend a musical or play in the Drama Building", latitude: 38.039664, longitude: -78.504385)
        createActivity(53, title: "Participate in a Greek philanthropy event", latitude: 0, longitude: 0)
        createActivity(54, title: "Play in Mad Bowl", latitude: 38.037769, longitude: -78.502220)
        createActivity(55, title: "Hang out at a Final Friday Reception at the Fralin", latitude: 38.038265, longitude: -78.503092)
        createActivity(56, title: "Sport some 2016 gear", latitude: 0, longitude: 0)
        createActivity(57, title: "Drive up Skyline Drive", latitude: 38.097819, longitude: -78.781188)
        createActivity(58, title: "Check out a multicultural event", latitude: 0, longitude: 0)
        createActivity(59, title: "Watch a U.Va. away game at a local establishment", latitude: 38.034944, longitude: -78.500517)
        createActivity(60, title: "Support someone who does St. Baldrick", latitude: 0, longitude: 0)
        createActivity(61, title: "Attend a Homecomings event", latitude: 0, longitude: 0)
        createActivity(62, title: "Plant in the U.Va. Community Garden", latitude: 38.035351, longitude: -78.514262)
        createActivity(63, title: "Witness a Probate", latitude: 0, longitude: 0)
        createActivity(64, title: "Visit a Pavilion resident", latitude: 38.034196, longitude: -78.504170)
        createActivity(65, title: "Stargaze on the Lawn", latitude: 38.034196, longitude: -78.504170)
        createActivity(66, title: "Support the tennis teams at Snyder courts", latitude: 38.038623, longitude: -78.506576)
        createActivity(67, title: "Eat at Cavalier Diner", latitude: 38.055999, longitude: -78.496895)
        createActivity(68, title: "Spread the U.Va. love and host a non-U.Va. friend", latitude: 0, longitude: 0)
        createActivity(69, title: "'Take back the night'", latitude: 0, longitude: 0)
        createActivity(70, title: "Attend UPC Springfest", latitude: 0, longitude: 0)
        createActivity(71, title: "Bake, braid, or enjoy a loaf with Challah for Hunger", latitude: 0, longitude: 0)
        createActivity(72, title: "Attend an Earth Week event", latitude: 0, longitude: 0)
        createActivity(73, title: "Play a sport on Nameless field", latitude: 38.037503, longitude: -78.505923)
        createActivity(74, title: "Groove to the vibes of a local band", latitude: 0, longitude: 0)
        createActivity(75, title: "Support the lacrosse/soccer teams at Klockner", latitude: 38.046815, longitude: -78.512316)
        createActivity(76, title: "Make a poster for a basketball game", latitude: 38.045945, longitude: -78.506737)
        createActivity(77, title: "Indulge in College Inn cheesy bread", latitude: 38.035022, longitude: -78.500415)
        createActivity(78, title: "Build a snowman on the Lawn and have a snowball fight", latitude: 38.034196, longitude: -78.504170)
        createActivity(79, title: "Enjoy a U.Va. Club Ice Hockey game", latitude: 38.030789, longitude: -78.483247)
        createActivity(80, title: "Attend a lecture at the Miller Center", latitude: 38.047660, longitude: -78.513659)
        createActivity(81, title: "Go snow tubing at Wintergreen", latitude: 37.929901, longitude: -78.941783)
        createActivity(82, title: "Survive one hour at Biltmore", latitude: 38.036353, longitude: -78.500606)
        createActivity(83, title: "Attend the class party", latitude: 0, longitude: 0)
        createActivity(84, title: "Pull an all nighter at Clemons", latitude: 38.036350, longitude: -78.506086)
        createActivity(85, title: "Play a game of cornhole", latitude: 0, longitude: 0)
        createActivity(86, title: "Attend a flash seminar", latitude: 0, longitude: 0)
        createActivity(87, title: "Listen to a U.Va. radio broadcast", latitude: 38.041906, longitude: -78.503433)
        createActivity(88, title: "Eat at Duck Donuts", latitude: 38.065290, longitude: -78.492904)
        createActivity(89, title: "Get your Corks and Curls", latitude: 0, longitude: 0)
        createActivity(90, title: "Chase a squirrel", latitude: 0, longitude: 0)
        createActivity(91, title: "Eat brunch at a local establishment", latitude: 38.034944, longitude: -78.500517)
        createActivity(92, title: "Test your knowledge at trivia night", latitude: 38.033648, longitude: -78.498630)
        createActivity(93, title: "Accept a flyer from someone tabling (and actually go to the event)", latitude: 0, longitude: 0)
        createActivity(94, title: "Try slacklining on grounds", latitude: 0, longitude: 0)
        createActivity(95, title: "Read an article from a student publication", latitude: 0, longitude: 0)
        createActivity(96, title: "Dance the Virginia Reel at Restoration/Colonnade Ball", latitude: 38.033517, longitude: -78.505837)
        createActivity(97, title: "Participate in drag bingo", latitude: 0, longitude: 0)
        createActivity(98, title: "Take a U-V-A picture", latitude: 0, longitude: 0)
        createActivity(99, title: "Sing Karaoke at Fellini's", latitude: 38.031686, longitude: -78.482063)
        createActivity(100, title: "Sing in a booth at the Virginian", latitude: 38.035340, longitude: -78.500672)
        createActivity(101, title: "Vote in a Student Election", latitude: 0, longitude: 0)
        createActivity(102, title: "Study in a Garden", latitude: 38.034196, longitude: -78.504170)
        createActivity(103, title: "Grab a frisbee from the 21 box on the Lawn (next to Lawn room 21)", latitude: 38.035066, longitude: -78.504059)
        createActivity(104, title: "Befriend a first year", latitude: 0, longitude: 0)
        createActivity(105, title: "Run on the Rivanna Trail", latitude: 38.055041, longitude: -78.510222)
        createActivity(106, title: "Witness the Purple Shadows on Jefferson's birthday", latitude: 38.034196, longitude: -78.504170)
        createActivity(107, title: "Watch the sunset from the top floor of Culbreth parking garage", latitude: 38.040181, longitude: -78.504217)
        createActivity(108, title: "Attend an Awareness Training (Green Dot, Safe Space, Diversity, etc…)", latitude: 0, longitude: 0)
        createActivity(109, title: "Think about applying for a job (UCS can help!!!)", latitude: 0, longitude: 0)
        createActivity(110, title: "Encourage someone to apply to U.Va.", latitude: 0, longitude: 0)
        createActivity(111, title: "Tell a secret at the Whispering Wall", latitude: 38.034964, longitude: -78.506743)
        createActivity(112, title: "Appreciate a horse at Foxfield", latitude: 38.099742, longitude: -78.552107)
        createActivity(113, title: "Thank your parents", latitude: 0, longitude: 0)
        createActivity(114, title: "Get the feels at Graduation", latitude: 38.035203, longitude: -78.503638)
        createActivity(115, title: "Go to Valediction", latitude: 38.035203, longitude: -78.503638)
        createActivity(116, title: "Wear the Honors of Honor", latitude: 38.035203, longitude: -78.503638)
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = NSUserDefaults.standardUserDefaults()
        let isPreloaded = defaults.boolForKey("isPreloaded")
        if !isPreloaded {
            preloadData()
            defaults.setBool(true, forKey: "isPreloaded")
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "cs.virginia.edu.CoreDataTest" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Shellder", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Shellder.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

