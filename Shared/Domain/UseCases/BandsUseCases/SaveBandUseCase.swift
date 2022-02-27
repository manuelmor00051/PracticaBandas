import Foundation

protocol SaveBandUseCaseProtocol {
    func save(band: Band, completionHandler: @escaping ((Band) -> Void))
}

struct SaveBandUseCase: SaveBandUseCaseProtocol {
    private let repository: BandsRepositoryProtocol = BandsRepository()
    
    func save(band: Band, completionHandler: @escaping ((Band) -> Void)) {
        repository.save(band: band, completionHandler: completionHandler)
    }
}
