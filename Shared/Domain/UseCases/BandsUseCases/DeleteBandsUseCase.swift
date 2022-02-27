import Foundation

protocol DeleteBandsUseCaseProtocol {
    func execute(bandIds: [String], completionHandler: @escaping ([String]) -> Void)
}

struct DeleteBandsUseCase: DeleteBandsUseCaseProtocol {
    private let repository: BandsRepositoryProtocol = BandsRepository()
    
    func execute(bandIds: [String], completionHandler: @escaping ([String]) -> Void) {
        repository.deleteBands(bandIds: bandIds, completionHandler: completionHandler)
    }
}
