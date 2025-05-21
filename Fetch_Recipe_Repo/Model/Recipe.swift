import SwiftUI
import Foundation
import SwiftData


struct Wrapper:Decodable{
    let recipes:[Recipe]
}

struct Recipe: Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?
}


extension Recipe: Decodable{
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Untitled"
        self.photoURLLarge = try container.decodeIfPresent(String.self, forKey: .photoURLLarge)
        self.photoURLSmall = try container.decodeIfPresent(String.self, forKey: .photoURLSmall)
        self.sourceURL = try container.decodeIfPresent(String.self, forKey: .sourceURL)
        self.youtubeURL = try container.decodeIfPresent(String.self, forKey: .youtubeURL)
    }
}

@Model
class RecipeEntity {
    var id: UUID
    var name: String
    var cuisine: String
    var photoURLSmall: String?
    var photoURLLarge: String?
    var sourceURL: String?
    var youtubeURL: String?
    
    init(id: UUID, name: String, cuisine: String, photoURLSmall: String?, photoURLLarge: String?, sourceURL: String?, youtubeURL: String?) {
        self.id = id
        self.name = name
        self.cuisine = cuisine
        self.photoURLSmall = photoURLSmall
        self.photoURLLarge = photoURLLarge
        self.sourceURL = sourceURL
        self.youtubeURL = youtubeURL
    }
}

extension RecipeEntity{
    convenience init(from recipe: Recipe) {
        self.init(
            id: recipe.id,
            name: recipe.name,
            cuisine: recipe.cuisine,
            photoURLSmall: recipe.photoURLSmall,
            photoURLLarge: recipe.photoURLLarge,
            sourceURL: recipe.sourceURL,
            youtubeURL: recipe.youtubeURL
        )
    }
    
    func toRecipe() -> Recipe{
        return Recipe(
            id: self.id,
            cuisine: self.cuisine,
            name: self.name,
            photoURLLarge: self.photoURLLarge,
            photoURLSmall: self.photoURLSmall,
            sourceURL: self.sourceURL,
            youtubeURL: self.youtubeURL
        )
    }
}


