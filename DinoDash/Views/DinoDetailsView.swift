//
//  DinoDetailsView.swift
//  DinoDash
//
//  Created by ReetDhillon on 2025-03-11.
//

import SwiftUI
import MapKit

struct DinoDetailsView: View {
    let dinosaurInfo : DinoDataModel
    @State var mapPoistion: MapCameraPosition
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    //Background Image
                    Image(dinosaurInfo.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.8),
                                                   Gradient.Stop(color: .black, location: 1),
                                                  ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    NavigationLink {
                        Image(dinosaurInfo.Image)
                            .resizable()
                            .scaledToFit()
                            .imageScale(.large)
                    } label : {
                        //Dino Image
                        Image(dinosaurInfo.Image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                            .scaleEffect(x: -1)
                            .shadow(color: .black, radius: 7)
                            .offset(y:20)
                    }
                    
                }
                
                VStack(alignment: .leading){
                    //Dino Name
                    Text(dinosaurInfo.name)
                        .font(.largeTitle)
                    
                    //Current Location
                    NavigationLink{
                        DinoMapView(mapPosition: .camera(MapCamera(
                            centerCoordinate: dinosaurInfo.location,
                            distance: 1000,
                            heading: 250,
                            pitch: 80))
                        )
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    } label : {
                        Map(position: $mapPoistion){
                            Annotation(dinosaurInfo.name, coordinate: dinosaurInfo.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                                
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading){
                            Text("Current Location")
                                .padding([.leading,.bottom],5)
                                .padding(.trailing,8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    //Appears In
                    Text("Apperas In:")
                        .font(.title3)
                    
                    ForEach(dinosaurInfo.movies, id: \.self){
                        movie in
                        Text("•" + movie)
                            .font(.subheadline)
//                            .padding(.vertical, 1)
                    }
                    
                    //Movie Moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(dinosaurInfo.movieScenes){
                        sceneDetails in
                        Text(sceneDetails.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(sceneDetails.sceneDescription)
                            .padding(.bottom, 15)
                        
                    }
                    
                    //Link to Webpage
                    Text("Read More:")
                        .font(.caption)
                    
                    Link(dinosaurInfo.link, destination: URL(string: dinosaurInfo.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                }
                .padding()
                .padding(.bottom, 45)
                .frame(width:geo.size.width, height: geo.size.height, alignment: .leading)
            }
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let dinoData = DinosaurViewModel().dinoData[2]
    NavigationStack{
        DinoDetailsView(dinosaurInfo: dinoData, mapPoistion: .camera(
            MapCamera(
                centerCoordinate: dinoData.location, distance: 30000)))
        .preferredColorScheme(.dark)
    }
}
