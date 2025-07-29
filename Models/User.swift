import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var email: String
    var created_at: Date

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case created_at
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let idString = try container.decode(String.self, forKey: .id)
        guard let uuid = UUID(uuidString: idString) else {
            throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "ID is not a valid UUID")
        }
        id = uuid

        email = try container.decode(String.self, forKey: .email)

        let dateString = try container.decode(String.self, forKey: .created_at)
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .created_at, in: container, debugDescription: "Invalid date format")
        }
        created_at = date
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id.uuidString, forKey: .id)
        try container.encode(email, forKey: .email)

        let formatter = ISO8601DateFormatter()
        try container.encode(formatter.string(from: created_at), forKey: .created_at)
    }
}
