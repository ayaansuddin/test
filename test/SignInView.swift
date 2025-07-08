import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "lock.shield.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text("Welcome to RunSafe!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Please sign in to continue.")
                .font(.headline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Button("Sign In") {
                authManager.login()
            }
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.horizontal, 40)
            .padding(.vertical, 15)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            
            Spacer()
        }
        .padding()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AuthManager())
    }
}
