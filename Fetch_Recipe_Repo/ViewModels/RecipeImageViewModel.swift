import Foundation
import SwiftUI


@Observable
class RecipeImageViewModel{
    var image: UIImage? = nil
    var isLoading:Bool = false
    
    let url:String
    let imageKey: UUID
    
    let manager =  PhotoFileManager.shared
    
    init(url:String, imageKey: UUID ){
        self.url = url
        self.imageKey = imageKey
    }
    
    func getImage() async {
        if let savedImage = manager.get(key: imageKey.uuidString){
            self.image = savedImage
        }
        else{
            await downloadImages()
        }
    }
    
    
    func downloadImages() async{
        isLoading = true
        defer { isLoading = false }
        
        guard let url = URL(string: self.url) else{
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return }
            self.image = image
            
            // save to file manager
            self.manager.add(key: imageKey.uuidString, value: image)
        } catch {
            print("Image download failed: \(error.localizedDescription)")
        }
    }
    
}
