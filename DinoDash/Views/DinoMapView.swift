//
//  DinoMapView.swift
//  DinoDash
//
//  Created by ReetDhillon on 2025-03-14.
//

import SwiftUI
import MapKit

struct DinoMapView: View {
    let dinos = DinosaurViewModel()
    @State var mapPosition: MapCameraPosition
    @State var satelite = false
    @State var isCardOpen = false
    
    var body: some View {
        Map(position: $mapPosition){
            ForEach(dinos.dinoData){
                dino in
                Annotation(dino.name,
                           coordinate: dino.location){
                    Image(dino.Image)
                        .resizable()
                        .scaledToFit()
                        .frame(height:100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
                           
            }
        }
        .onTapGesture{
            print(mapPosition)
            isCardOpen.toggle()
        }
        .sheet(isPresented: $isCardOpen){
            DinoInfoView(dinosaurInfo: dinos.dinoData[2], mapPoistion: mapPosition)
    
        }
        .presentationDetents([.height(200)])
        .mapStyle(satelite ? .imagery(elevation:  .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing){
            Button{
                satelite.toggle()
            } label:{
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    DinoMapView(mapPosition: .camera(MapCamera(
        centerCoordinate: DinosaurViewModel().dinoData[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80))
                )
    .preferredColorScheme(.dark)
}
