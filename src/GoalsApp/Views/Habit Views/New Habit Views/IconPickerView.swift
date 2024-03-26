import SwiftUI

public struct IconPickerView: View {
    @EnvironmentObject private var appData: AppData
    
    @Binding var selection: String
    @Environment(\.presentationMode) var presentationMode
    let columns = Array(repeating: GridItem(.flexible()), count: 6)
    
    
    public init(selection: Binding<String>, title: String, autoDismiss: Bool = false) {
        self._selection = selection
    }
    
    @ViewBuilder
    public var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach (suggestedSymbols, id: \.self) { symbol in
                        Button(action: {
                            selection = symbol
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: symbol)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(appData.account.backgroundTheme.complementaryColor)
                                .frame(width: 30, height: 30)
                                .background(
                                    Circle()
                                        .foregroundStyle(.gray.opacity(0.25))
                                        .frame(width: 50, height: 50)
                                )
                                .padding(.top, 20)
                                .padding(.leading)
                                .padding(.trailing)
                        }
                    }
                }
                .padding()
                .navigationTitle("Pick an Icon")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark.circle")
                        }

                    }
                }
                .padding(.vertical, 5)
                
            }.padding(.horizontal, 5)
        }
        .preferredColorScheme(appData.account.backgroundTheme.colorScheme)

        .onChange(of: selection) { newValue in
            presentationMode.wrappedValue.dismiss()
        }
    }

}

#Preview {
    IconPickerView(selection: .constant("bookmark.fill"), title: "Pick a symbol", autoDismiss: true)
        .environmentObject(AppData())
}
