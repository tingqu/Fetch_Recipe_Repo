import Foundation
import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe
    
    var line: some View {
        VStack { Divider().background(.gray) }.padding(10)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                RecipeImage(url: recipe.photoURLLarge ?? "", key: recipe.id)
                    .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                    .clipped()
                    .shadow(radius: 10)
                    .cornerRadius(24)
                
                Divider()
                
                HStack(spacing: 4) {
                    Image(systemName: "fork.knife")
                    Text("Cuisine: \(recipe.cuisine)")
                        .font(.headline)
                }
                
                Divider()
                
                DisclosureGroup {
                    VStack(spacing: 8){
                        if let source = recipe.sourceURL,
                           let sourceURL = URL(string: source) {
                            Link("View Recipe Source", destination: sourceURL)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                        
                        if let youtube = recipe.youtubeURL,
                           let youtubeURL = URL(string: youtube) {
                            Link("Watch on YouTube", destination: youtubeURL)
                                .font(.subheadline)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.top, 4)
                } label: {
                    Label("Links", systemImage: "link")
                        .font(.headline)
                }
                
                Spacer(minLength: 350)
                
                HStack {
                    line
                    Text("End").foregroundColor(.gray)
                    line
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle(recipe.name)
    }
}


#Preview {
    NavigationStack {
        RecipeDetail(recipe: Recipe(
            id: UUID(),
            cuisine: "French",
            name: "Donuts",
            photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/d7f2d753-a434-426b-afdd-c63b899bcac1/large.jpg",
            photoURLSmall: nil,
            sourceURL: "https://example.com",
            youtubeURL: "https://youtube.com"
        ))
    }
}

