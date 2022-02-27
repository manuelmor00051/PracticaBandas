//
//  Persistence.swift
//  Shared
//
//  Created by Manuel Moreno Cámara on 18/2/22.
//

import CoreData

protocol PersistenceControllerProtocol {
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void)
    func save(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void))
    func removeAllBands(completionHandler: @escaping (() -> Void))
    func deleteBands(bandIds: [String], completionHandler: @escaping ([String]) -> Void)
    func getAllAlbums(completionHandler: @escaping ([AlbumDTO]) -> Void)
    //func saveAlbum(bandId: String, album: AlbumDTO, completionHandler: (AlbumDTO) -> Void)
}

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Bandas")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
    }
}

extension PersistenceController: PersistenceControllerProtocol {
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            
            var retrievedBands: [CDBand] = []
            
            do {
                retrievedBands = try privateMOC.fetch(request)
            } catch {
                print("F: \(error)")
                completionHandler([])
            }
            
            let transformedDtos = retrievedBands.map { currentCDBand in
                BandDTO(cd: currentCDBand)
            }
            completionHandler(transformedDtos)
        }
    }
    
    func save(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request = CDBand.fetchRequest()
            request.predicate = nil
            
            let newBand = CDBand(context: privateMOC)
            newBand.name = band.name
            newBand.id = band.id
            
            band.members.forEach { currentArtistDto in
                let newArtist = CDArtist(context: privateMOC)
                newArtist.name = currentArtistDto.name
                newArtist.birthDate = currentArtistDto.birthDay
                newArtist.addToBelongs(newBand)
            }
            
            band.albums.forEach { currentAlbumDto in
                let newAlbum = CDAlbum(context: privateMOC)
                newAlbum.name = currentAlbumDto.name
                newAlbum.image = currentAlbumDto.image
                newAlbum.addToBelongs(newBand)
            }
            
            do {
                try privateMOC.save()
            } catch {
                print("F: \(error)")
            }
            completionHandler(band)
        }
    }
    
    func removeAllBands(completionHandler: @escaping (() -> Void)) {
        container.performBackgroundTask { privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = nil
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            
            do {
                try privateMOC.execute(deleteRequest)
            } catch {
                print("F: \(error)")
            }
            completionHandler()
        }
    }
    
    func deleteBands(bandIds: [String], completionHandler: @escaping ([String]) -> Void) {
        container.performBackgroundTask { privateMOC in
            let request: NSFetchRequest<NSFetchRequestResult> = CDBand.fetchRequest()
            request.predicate = NSPredicate(format: "id IN %@", bandIds)
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeCount
            
            do {
               _ = try privateMOC.execute(deleteRequest) as? NSBatchDeleteResult
            } catch {
                print("F: \(error)")
            }
            
            completionHandler(bandIds)
        }
    }
    
    func getAllAlbums(completionHandler: @escaping ([AlbumDTO]) -> Void) {
        container.performBackgroundTask { privateMOC in
            let request = CDAlbum.fetchRequest()
            request.predicate = nil
            
            var retrievedAlbums: [CDAlbum] = []
            
            do {
                retrievedAlbums = try privateMOC.fetch(request)
            } catch {
                print("F: \(error)")
                completionHandler([])
            }
            
            let transformedDtos = retrievedAlbums.map { currentCDAlbum in
                AlbumDTO(cd: currentCDAlbum)
            }
            completionHandler(transformedDtos)
        }
    }
    
    /*
    func saveAlbum(bandId: String, album: AlbumDTO, completionHandler: (AlbumDTO) -> Void) {
        container.performBackgroundTask { privateMOC in
            let request = CDAlbum.fetchRequest()
            request.predicate = nil
            
            let newAlbum = CDAlbum(context: privateMOC)
            newAlbum.name = album.name
            newAlbum.id = album.id
            newAlbum.releaseDate = album.releaseDate
        
            band.members.forEach { currentArtistDto in
                let newArtist = CDArtist(context: privateMOC)
                newArtist.name = currentArtistDto.name
                newArtist.birthDate = currentArtistDto.birthDay
                newArtist.addToBelongs(newBand)
            }
            
            do {
                try privateMOC.save()
            } catch {
                print("F: \(error)")
            }
            completionHandler(band)
        }
    }
}
         */
        }


