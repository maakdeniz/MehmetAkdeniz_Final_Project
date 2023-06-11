//
//  CoreDataStack.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//


import CoreData
import iTunesAPI

class CoreDataStack {

    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iTunesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addToFavorites(music: Music) {
        let context = persistentContainer.viewContext
        let favorite = Favorite(context: context)
        favorite.artistName = music.artistName
        favorite.trackName = music.trackName
        favorite.collectionName = music.collectionName
        favorite.artworkUrl = music.artworkUrl
        favorite.previewUrl = music.previewUrl
        saveContext()
    }
    
    func removeFromFavorites(music: Music) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackName = %@ AND artistName = %@", music.trackName!, music.artistName!)
        
        do {
            let favoriteTracks = try context.fetch(fetchRequest)
            for track in favoriteTracks {
                context.delete(track)
            }
            saveContext()
        } catch {
            print("Unable to fetch favorites.")
        }
    }

    func isFavorite(music: Music) -> Bool {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trackName = %@ AND artistName = %@", music.trackName!, music.artistName!)

        do {
            let favoriteTracks = try context.fetch(fetchRequest)
            return !favoriteTracks.isEmpty
        } catch {
            print("Unable to fetch favorites.")
            return false
        }
    }
}


