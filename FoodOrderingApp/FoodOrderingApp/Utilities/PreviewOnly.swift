import SwiftUI

struct Preview: View {
    
    @State var firstName: String = ""
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            TextField("First Name", text: $firstName)
                .normalTextInput()
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Color("PrimaryColor1"))
                .padding(.horizontal, 10)
        }
        
    }
}




struct Preview_Previews: PreviewProvider {
    
    static var previews: some View {
        Preview().previewLayout(.sizeThatFits)
    }
}
