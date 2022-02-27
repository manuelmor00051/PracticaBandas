import Foundation

protocol BandsRepositoryProtocol {
    func getAllBands(completionHandler: @escaping ([Band]) -> Void)
    func save(band: Band, completionHandler: @escaping ((Band) -> Void))
    func removeAllBands(completionHandler: @escaping (() -> Void))
    func deleteBands(bandIds: [String], completionHandler: @escaping ([String]) -> Void)
}

struct BandsRepository: BandsRepositoryProtocol {
    private let localDataSource: BandLocalDSProtocol = BandLocalDS()
    
    func getAllBands(completionHandler: @escaping ([Band]) -> Void) {
        localDataSource.getAllBands(completionHandler: { bandsDTO in
            let domainBands = bandsDTO.map { currentBandDto in
                Band(dto: currentBandDto)
            }
            
            completionHandler(domainBands)
        })
    }
    
    func save(band: Band, completionHandler: @escaping ((Band) -> Void)) {
        localDataSource.save(band: BandDTO(domain: band), completionHandler: { bandDTO in
            completionHandler(Band(dto: bandDTO))
        })
    }
    
    func removeAllBands(completionHandler: @escaping (() -> Void)) {
        localDataSource.removeAllBands(completionHandler: completionHandler)
    }
    
    func deleteBands(bandIds: [String], completionHandler: @escaping ([String]) -> Void) {
        localDataSource.deleteBands(bandIds: bandIds, completionHandler: completionHandler)
    }
}
/*
struct BandsRepositoryMOCK: BandsRepositoryProtocol {
    func getAllBands(completionHandler: @escaping ([Band]) -> Void) {
        let artists = Artist(name: "Freddy Mercury", birthDay: Date())
        
        let band = Band(name: "Queen", members: [artists])
        
        completionHandler([band])
    }
}
*/
