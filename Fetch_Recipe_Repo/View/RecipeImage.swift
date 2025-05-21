import SwiftUI
struct RecipeImage:View{
    @State var viewModel:RecipeImageViewModel
    
    init(url: String, key: UUID) {
        _viewModel = State(initialValue: RecipeImageViewModel(url: url, imageKey: key))
    }
    
    var body: some View{
        VStack{
            if viewModel.isLoading{
                ProgressView()
            }
            else if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Rectangle())
            }
            else{
                ProgressView()
            }
        }
        .task{
            await viewModel.getImage()
        }
    }
}


struct RecipeImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Image(uiImage: UIImage(systemName: "photo")!)
                .resizable()
                .frame(width: 100, height: 100)
                .previewDisplayName("Sample Image")
            
            ProgressView()
                .frame(width: 100, height: 100)
                .previewDisplayName("Loading")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
