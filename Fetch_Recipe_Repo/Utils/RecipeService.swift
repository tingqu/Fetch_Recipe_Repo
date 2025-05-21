import Foundation
import SwiftData
@Observable
class RecipeService{
    static let shared = RecipeService()
    
    var recipes: [Recipe] = []
    
    private let defaultUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    @MainActor
    func downloadRecipes(context:ModelContext, from urlString: String? = nil) async throws {
//        check if the data exist in SwiftData
        let fetchDescriptor = FetchDescriptor<RecipeEntity>()
        do {
            let savedData = try context.fetch(fetchDescriptor)

            for recipe in savedData  {
                print("Found \(recipe.name)")
            }
            
            if !savedData.isEmpty{
                self.recipes = savedData
                    .map { $0.toRecipe() }
                    .sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
                
                print(recipes)
                return
            }
        } catch {
            print("Failed to load Movie model.")
        }
        
//       fetch api if no response got saved
        guard let url = URL(string: urlString ?? malformedUrl ) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(Wrapper.self, from: data)
            self.recipes = response.recipes.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }

            for recipe in self.recipes{
                let entity = RecipeEntity(from: recipe)
                context.insert(entity)
            }
        } catch {
            self.recipes = []
            print("Error fetching recipes: \(error)")
            throw error
        }
    }
}
