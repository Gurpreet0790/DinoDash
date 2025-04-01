//
//  DinoDashListView.swift
//  DinoDash
//
//  Created by ReetDhillon on 2025-03-10.
//

import SwiftUI
import MapKit

struct DinoDashListView: View {
    let dinoDetails = DinosaurViewModel()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currenctSelection = dinoType.all
    
    var filteredDinos: [DinoDataModel] {
        dinoDetails.filter(by: currenctSelection)
        
        dinoDetails.sort(by: alphabetical)
        
        return dinoDetails.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(filteredDinos) { dino in
                    NavigationLink {
                        DinoDetailsView(dinosaurInfo: dino, mapPoistion: .camera(
                            MapCamera(
                                centerCoordinate: dino.location, distance: 30000)))
                    } label: {
                        HStack {
                            // Dino Image
                            Image(dino.Image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            VStack(alignment: .leading) {
                                // Name
                                Text(dino.name)
                                    .fontWeight(.bold)
                                
                                // Type
                                Text(dino.type.rawValue.capitalized)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 13)
                                    .padding(.vertical, 5)
                                    .background(dino.type.background)
                                    .clipShape(.capsule)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteDino) // Add delete functionality
            }
            .navigationTitle("Dino Dash")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currenctSelection.animation()) {
                            ForEach(dinoType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func deleteDino(at offsets: IndexSet){
        dinoDetails.removeDino(at: offsets)
    }
}

#Preview {
    DinoDashListView()
}
