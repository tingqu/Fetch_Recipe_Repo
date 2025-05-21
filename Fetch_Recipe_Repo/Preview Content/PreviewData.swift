import Foundation

extension JSONDecoder {
    static var apiDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }
}

extension [Recipe] {
    static var preview: [Recipe] {
        let url = Bundle.main.url(forResource: "RecipesData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let wrapper = try! JSONDecoder.apiDecoder.decode(Wrapper.self, from: data)
        return wrapper.recipes
    }
}

extension Recipe {
    static var preview: Recipe {
        [Recipe].preview[0]
    }
}
