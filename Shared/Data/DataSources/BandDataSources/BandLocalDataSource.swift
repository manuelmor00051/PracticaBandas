import Foundation

protocol BandLocalDSProtocol {
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void)
    func save(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void))
    func removeAllBands(completionHandler: @escaping (() -> Void))
    func deleteBands(bandIds: [String], completionHandler: @escaping ([String]) -> Void)
}

struct BandLocalDS: BandLocalDSProtocol {
    private let pController: PersistenceControllerProtocol = PersistenceController.shared
    
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void) {
        pController.getAllBands(completionHandler: completionHandler)
    }
    
    func save(band: BandDTO, completionHandler: @escaping ((BandDTO) -> Void)) {
        pController.save(band: band, completionHandler: completionHandler)
    }
    
    func removeAllBands(completionHandler: @escaping (() -> Void)) {
        pController.removeAllBands(completionHandler: completionHandler)
    }
    
    func deleteBands(bandIds: [String], completionHandler: @escaping ([String]) -> Void) {
        pController.deleteBands(bandIds: bandIds, completionHandler: completionHandler)
    }
}
/*
struct BandLocalDSMOCK: BandLocalDSProtocol {
    func getAllBands(completionHandler: @escaping ([BandDTO]) -> Void) {
        let artists = [ArtistDTO(name: "David Muñoz", birthDay: Date()), ArtistDTO(name: "Jose Muñoz", birthDay: Date())]
        let band = BandDTO(name: "Estopa", members: artists)
        
        completionHandler([band])
    }
}
*/
