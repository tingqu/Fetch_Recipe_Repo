import Foundation
import SwiftData
import Observation


@MainActor
@Observable
class RecipeViewModel {
    var service = RecipeService.shared
    var context:ModelContext
    var loading: Bool = false
    
    var recipes: [Recipe] {
        return service.recipes
    }
    
    
    init(context: ModelContext) {
        self.context = context
    }
    
    
    func fetchData() async {
        do {
            loading = true
            try await service.downloadRecipes(context: context)
            loading = false
        } catch {
            loading = true
            print("Failed to fetch recipes: \(error)")
        }
    }
    
    static func preview(context: ModelContext) -> RecipeViewModel {
        let vm = RecipeViewModel(context: context)
        return vm
    }
}
