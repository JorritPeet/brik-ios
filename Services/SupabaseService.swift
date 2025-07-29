import Foundation
import Supabase

final class SupabaseService {
    static let shared = SupabaseService()
    private(set) var client: SupabaseClient!

    private init() {}

    func setup() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Secrets.supabaseUrl)!,
            supabaseKey: Secrets.supabaseKey
        )
    }

    func fetchUsers() async throws -> [User] {
        let users: [User] = try await client
            .from("profiles")
            .select()
            .execute()
            .value
        return users
    }
}
