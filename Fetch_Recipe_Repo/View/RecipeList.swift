import Foundation
import SwiftUI

struct RecipeList: View {
    @State var viewModel: RecipeViewModel
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    var filterResult: [Recipe] {
        viewModel.recipes.filter {
            searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) || $0.cuisine.localizedStandardContains(searchText)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.loading{
                    VStack{
                        ProgressView()
                        Text("Loading Recipes")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                else if filterResult.isEmpty{
                    VStack {
                        Image(systemName: "cup.and.saucer.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No recipes available.")
                            .foregroundColor(.gray)
                            .padding(.top, 5)
                    }
                }
                else{
                    List(filterResult) { recipe in
                        NavigationLink {
                            RecipeDetail(recipe: recipe)
                        } label: {
                            RecipeRow(recipe: recipe)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("All Recipes")
            .searchable(text: $searchText, isPresented: $searchIsActive)
            .task {
                await viewModel.fetchData()
            }
        }
    }
}
