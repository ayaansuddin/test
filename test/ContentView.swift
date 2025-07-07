import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.white, Color.black], /// update gradient colors
    startPoint: .top, endPoint: .bottom)

struct ContentView: View {
    
    var body: some View {
        VStack {
            Spacer()
            
            // Your Logo
            Image("basics-logo")/// replace with your logo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.black)
                .frame(height: 40)

            Spacer()
            
            // Continue with Apple Button
            Button(
                action: {
                    // add action here
                },
                label: {
                    HStack{
                        Image("apple-icon")
                            .resizable()
                            .frame(width:20, height: 20)
                            .padding(.horizontal, 6)
                        
                        Text("Continue with Apple")
                            .bold()
                            .foregroundColor(Color.black)
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.gray) /// make the background gray
                    .cornerRadius(10) /// make the background rounded
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                })
            
            Spacer()
                .frame(height: 15)
            
            // Continue with Google Button
            Button(
                action: {
                    // add action here
                },
                label: {
                    HStack{
                        Image("google-icon")
                            .resizable()
                            .frame(width:20, height: 20)
                            .padding(.horizontal, 6)
                        
                        Text("Continue with Google")
                            .bold()
                            .foregroundColor(Color.black)
                        
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.gray) /// make the background gray
                    .cornerRadius(10) /// make the background rounded
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                })
            
            // Legal Disclaimer
            Text("By continuing, you agree to Basic's [Terms of Service](https://basics.com/terms-of-service) and [Privacy Policy](https://basics.com/privacypolicy) ")
                .multilineTextAlignment(.center)
                .foregroundColor(Color.gray)
                .tint(Color.gray)
                .padding(.top, 20)
                .font(.caption)
                .frame(width: 250)
        }
        .padding()
        .background(backgroundGradient)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
