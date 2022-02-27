import Foundation

protocol DeleteAllBandsUseCaseProtocol {
    func execute(completionHandler: @escaping (() -> Void))
}

struct DeleteAllBandsUseCase: DeleteAllBandsUseCaseProtocol {
    private let repository: BandsRepositoryProtocol = BandsRepository()
    
    func execute(completionHandler: @escaping (() -> Void)) {
        repository.removeAllBands(completionHandler: completionHandler)
    }
}
