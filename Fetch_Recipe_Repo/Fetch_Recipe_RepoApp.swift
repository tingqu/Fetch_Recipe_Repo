import SwiftUI
import SwiftData
@main
struct Fetch_Recipe_RepoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: RecipeEntity.self)
        }
    }
}
