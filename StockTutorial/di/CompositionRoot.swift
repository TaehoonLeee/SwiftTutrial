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
        
        let stockDetailControllerFactory: (Stock) -> StockDetailController = { stock in
            let useCase = GetStockDetailUseCase(stockRepository: stockRepository)
            let viewModel = StockDetailViewModel(useCase: useCase)
            
            return .init(dependency: .init(stock: stock, viewModel: viewModel))
        }
        
        let selectDateControllerFactory: () -> SelectDateController = {
            .init()
        }
        
        let mainCoordinator: MainCoordinator = .init(dependency: .init(stockListControllerFactory: stockListControllerFactory, stockDetailControllerFactory: stockDetailControllerFactory, selectDateControllerFactory: selectDateControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
