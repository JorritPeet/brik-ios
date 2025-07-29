import SwiftUI

struct UserListView: View {
    @State private var users: [User] = []

    var body: some View {
        NavigationView {
            List(users) { user in
                Text(user.email)
            }
            .navigationTitle("Gebruikers")
            .task {
                do {
                    users = try await SupabaseService.shared.fetchUsers()
                } catch {
                    print("Fout: \(error)")
                }
            }
        }
    }
}

