import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    var body: some View {
        RecipeList(viewModel: RecipeViewModel(context: context))
    }
}

#Preview {
    let container = try! ModelContainer(for: RecipeEntity.self, configurations: .init(isStoredInMemoryOnly: true))
    return ContentView()
        .modelContainer(container)
}
