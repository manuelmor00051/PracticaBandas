import Foundation

protocol GetAllBandsProtocol {
    func execute(completionHandler: @escaping ([Band]) -> Void)
}

struct GetAllBands: GetAllBandsProtocol {
    private let repository: BandsRepositoryProtocol = BandsRepository()
    
    func execute(completionHandler: @escaping ([Band]) -> Void) {
        repository.getAllBands(completionHandler: completionHandler)
    }
    
    
}

struct GetAllBandsMOCK: GetAllBandsProtocol {
    func execute(completionHandler: @escaping ([Band]) -> Void) {
        let artist = [Artist(name: "Mark Knopfler", birthDay: Date())]
        
        let band = Band(name: "Dire Straits", members: artist, albums: [Album(name: "", image: "")])
        
        completionHandler([band])
    }
    

}
