struct AppDependency {
    let mainCoordinator: MainCoordinator
}

extension AppDependency {
    static func resolve() -> AppDependency {
        
        let stockRepository: StockRepository = StockRepositoryImpl()
        
        let stockListControllerFactory: () -> StockListController = {
            let useCase = GetStockUseCase(stockRepository: stockRepository)
            let viewModel = StockListViewModel(useCase: useCase)
            
            return .init(dependency: .init(viewModel: viewModel))
        }
        
        let mainCoordinator: MainCoordinator = .init(dependency: .init(stockListControllerFactory: stockListControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
