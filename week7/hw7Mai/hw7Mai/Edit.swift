
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit

struct Edit: View {
    
    @EnvironmentObject var store: Storage
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    //created an array to store each one instead of relying on single slider
    @State private var intensities: [String: Double] = [
        "Sepia Tone": 0.5,
        "Pixellate": 0.0,
        "Gaussian Blur": 0.0,
        "Vignette": 0.0,
        "Unsharp Mask": 0.0
     //   "Adjust Hue": 0.0
      //  "Crystallize": 0.0
    ]
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.pixellate()
    
    @State private var originalCIImage: CIImage? = nil
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(intensities.keys.sorted(),id: \.self){ filterName in
                        VStack(alignment: .leading) {
                            Text(filterName)
                                .font(.headline)
                            
                            Slider(value: Binding(
                                get: { intensities[filterName] ?? 0 },
                                set: { newValue in //updates
                                    intensities[filterName] = newValue
                                    applyProcessing() //links to the function that changes the photo
                                }
                            ), in: 0...1)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                if let processedImage {
                    Button("Save"){
                        saveImage()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.bottom)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Edit!")
        }
    }
    
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self),
                  let inputImage = UIImage(data: imageData) else { return }
            
            
            originalCIImage = CIImage(image: inputImage)
            applyProcessing()
        }
    }
    //had to rewrite  applyProcessing since this would rely on
    //https://www.hackingwithswift.com/read/13/4/applying-filters-cicontext-cifilter
//    used hackingwithswift
    func applyProcessing() {
        guard let originalCIImage else { return }
        
        var currentImage = originalCIImage
        for (filterName, intensity) in intensities {
            
            guard intensity > 0 else { continue }
            
            let filter: CIFilter
            switch filterName {
                case "Sepia Tone": filter = CIFilter.sepiaTone()
                case "Pixellate": filter = CIFilter.pixellate()
                case "Gaussian Blur": filter = CIFilter.gaussianBlur()
                case "Vignette": filter = CIFilter.vignette()
                case "Unsharp Mask": filter = CIFilter.unsharpMask()
               // case "Adjust Hue": filter = CIFilter.hueAdjust()
                //case "Crystallize": filter = CIFilter.crystallize()
                default: continue
            }
            filter.setValue(currentImage, forKey: kCIInputImageKey)
            if filter.inputKeys.contains(kCIInputIntensityKey) {
                filter.setValue(intensity, forKey: kCIInputIntensityKey)
            }
            if filter.inputKeys.contains(kCIInputRadiusKey) {
                filter.setValue(intensity * 200, forKey: kCIInputRadiusKey)
            }
            if filter.inputKeys.contains(kCIInputScaleKey) {
                filter.setValue(intensity * 200, forKey: kCIInputScaleKey)
            }
            if let output = filter.outputImage {
                        currentImage = output
                    }
            
            
        }
        guard let cgImage = context.createCGImage(currentImage, from: currentImage.extent) else { return }
        processedImage = Image(uiImage: UIImage(cgImage: cgImage))
        
        
    }
    func saveImage() {
            guard let processedImage = processedImage else { return } // from after processing is applied from applyProcessing
        
            let renderer = ImageRenderer(content: processedImage)
            if let uiImage = renderer.uiImage {
                store.savedImages.append(uiImage)
            }
        }
}

#Preview {
    Edit()
        .environmentObject(Storage())
}
