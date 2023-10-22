//
//  LoadingView.swift
//  myWeatherForecast
//
//  Created by Jan Stusio on 20/10/2023.
//

import SwiftUI
import RiveRuntime


struct LoadingView: View {
    var body: some View {
        
        ZStack {
            //rive animation for loading, maybe connected with weather or location
            RiveViewModel(fileName: "cloudAndSunLoading").view()//author: skydevelopers, CC BY 4.0, source: https://rive.app/community/2741-5623-cloud-and-sun/
            
            Text("Locating and loading weather data")
                .fontWeight(.semibold)
                .offset(y: 130)
        }
    }
}

#Preview {
    LoadingView()
}
