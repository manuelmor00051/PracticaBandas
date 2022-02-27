import Foundation

class BandsViewModel: ObservableObject {
    @Published var bands: [Band] = []
    
    private let getAllBands: GetAllBandsProtocol = GetAllBands()
    private let saveNewBand: SaveBandUseCaseProtocol = SaveBandUseCase()
    private let deleteAllBands: DeleteAllBandsUseCaseProtocol = DeleteAllBandsUseCase()
    private let deleteBands: DeleteBandsUseCaseProtocol = DeleteBandsUseCase()
    
    func getSavedBands() {
        getAllBands.execute(completionHandler: { retrieveBands in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = retrieveBands
            }
        })
    }
    
    func saveBand(band: Band) {
        saveNewBand.save(band: band, completionHandler: { savedBandData in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands.append(savedBandData)
            }
        })
    }
    
    func removeAllBands() {
        deleteAllBands.execute(completionHandler: {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.bands = []
            }
        })
    }
    
    func deleteBands(bandIds: [String]) {
        deleteBands.execute(bandIds: bandIds, completionHandler: {removedBandsID in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.bands = self.bands.filter{ !removedBandsID.contains($0.id)
                }
            }
        })
    }
}
