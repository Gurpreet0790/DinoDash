//
//  DinoInfoView.swift
//  DinoDash
//
//  Created by ReetDhillon on 2025-03-14.
//

import SwiftUI
import MapKit

struct DinoInfoView: View {
    let dinosaurInfo : DinoDataModel
    @State var mapPoistion: MapCameraPosition
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
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
                        .padding(.top, 30)
                    
                    //Appears In
                    Text("Apperas In:")
                        .font(.title3)
                    
                    ForEach(dinosaurInfo.movies, id: \.self){
                        movie in
                        Text("•" + movie)
                            .font(.subheadline)
                            .padding(.vertical, 1)
                    }
                }
                .padding()
                .frame(width:geo.size.width, height: geo.size.height, alignment: .leading)
                
                Spacer()
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

